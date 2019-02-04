//
//  FlatScraper.swift
//  WebBrowserExecuteJavaScript
//
//  Created by Maxim Kovalko on 2/4/19.
//  Copyright © 2019 Maxim Kovalko. All rights reserved.
//

import WKZombie

final class FlatScraper<Model> where Model: Codable {
    private let endpoint: Endpoint
    private let browser: WKZombie
    private var page: Int
    
    private lazy var workItem = DispatchWorkItem(block: browse)
    
    init?(endpoint: Endpoint,
          browser: WKZombie = WKZombie.sharedInstance,
          startPage: Int = 1) {
        self.endpoint = endpoint
        self.browser = browser
        self.page = startPage
    }
    
    private func browse() {
        guard let url = endpoint.url(forPage: page) else { return }
        browser.open(url)
            >>> browser.execute(endpoint.javaScript)
            === handle
    }
    
    func fetchData() {
        !workItem.isCancelled => workItem.perform
    }
    
    private func nextPage() {
        page += 1; fetchData()
    }
    
    private func reset() {
        func cancel() { workItem.cancel(); page = 1 }
        !workItem.isCancelled => cancel
    }
}

//MARK: - Handle Result

private extension FlatScraper {
    func handle(result: JavaScriptResult?) {
        func data(from value: JavaScriptResult?) -> Data? {
            return value?.data(using: .utf8)
        }
        
        func models(from value: Data?) -> [Model] {
            guard let data = value else { return [] }
            return (try? JSONDecoder().decode([Model].self, from: data)) ?? []
        }
        
        func onNext(values: [Model]) {
            !values.isEmpty => nextPage
            values.isEmpty => reset
        }
        
        result |> data |> models |> log |> onNext
    }
}

//MARK: - Logging

private extension FlatScraper {
    func log(values: [Model]) -> [Model] {
        func delimiter(symbol: Character, repeat count: Int) -> String {
            return (0..<count).map { _ in String(symbol) }.joined()
        }
        
        let (separator, line) = (
            delimiter(symbol: "\n", repeat: 3),
            delimiter(symbol: "-", repeat: 30)
        )
        
        func formattedDelimiter() -> String {
            return [separator, line].joined()
                |> { "\($0)PAGE #\(page)" }
                |> { "\($0)" + [line, separator].joined() }
        }
        
        [formattedDelimiter(), JSONEncoder().prettyPrinted(values) ?? ""]
            .forEach { print($0) }
        
        return values
    }
}

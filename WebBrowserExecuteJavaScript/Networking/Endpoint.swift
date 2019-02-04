//
//  Endpoint.swift
//  WebBrowserExecuteJavaScript
//
//  Created by Maxim Kovalko on 2/4/19.
//  Copyright © 2019 Maxim Kovalko. All rights reserved.
//

import WKZombie

enum Endpoint {
    case kharkiv
    case kyiv
    case lviv
    case odessa
    case dnepropetrovsk
    
    private var baseURL: String { return "https://lun.ua/" }
    private var urlString: String { return baseURL + title }
    
    var javaScript: JavaScriptResult {
        return "JSON.stringify(window.INITIAL_STATE.search.results.items);"
    }
}

private extension Endpoint {
    var title: String {
        switch self {
        case .kharkiv:
            return "аренда-квартир-харьков"
        case .kyiv:
            return "аренда-квартир-киев"
        case .lviv:
            return "аренда-квартир-львов"
        case .odessa:
            return "аренда-квартир-одесса"
        case .dnepropetrovsk:
            return "аренда-квартир-днепропетровск"
        }
    }
}

extension Endpoint {
    func url(forPage page: Int) -> URL? {
        func queryAllowed(from string: String) -> String? {
            return string.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            )
        }
        
        return (urlString |> queryAllowed)
            .map { "\($0)?page=\(page)" } |> URL.init
    }
}

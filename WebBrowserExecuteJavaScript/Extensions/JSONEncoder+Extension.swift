//
//  JSONEncoder+Extension.swift
//  WebBrowserExecuteJavaScript
//
//  Created by Maxim Kovalko on 2/4/19.
//  Copyright © 2019 Maxim Kovalko. All rights reserved.
//

import Foundation

extension JSONEncoder {
    func prettyPrinted<T: Encodable>(_ value: T) -> String? {
        guard let encoded = try? encode(value) else { return nil }
        outputFormatting = .prettyPrinted
        return String(bytes: encoded, encoding: .utf8)
    }
}

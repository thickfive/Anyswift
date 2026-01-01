//
//  Data+Extension.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation

public extension Data {
    var jsonString: String? {
        if let jsonObject = try? JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed) {
            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
                return String.init(data: jsonData, encoding: .utf8)
            }
        }
        return nil
    }
}

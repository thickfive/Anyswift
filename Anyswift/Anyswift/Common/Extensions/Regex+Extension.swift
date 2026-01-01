//
//  Regex+Extension.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation

public extension Regex where Output == Substring {
    static let email = /^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/
    static let code = /^\d{6}$/
}

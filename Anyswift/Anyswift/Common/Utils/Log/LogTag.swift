//
//  LogTag.swift
//  Mixed
//
//  Created by vvii on 2025/12/26.
//

import Foundation

public enum Tag: String, CustomStringConvertible {
    case crash
    case network
    // ...
    public var description: String {
        return rawValue
    }
}

// Log.error(error, tag: .network)
public extension String {
    static let crash = Tag.crash.description
    static let network = Tag.network.description
    // ... more from enum Tag
}

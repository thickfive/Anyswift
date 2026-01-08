//
//  SymbolModels.swift
//  Anyswift
//
//  Created by vvii on 2026/1/6.
//

import Foundation

struct Symbol: Codable, Hashable, Identifiable {
    let key: String
    let categories: [String]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.key == rhs.key
    }
    
    var id: String {
        return key
    }
}

extension Symbol {
    struct Category: Codable, Hashable {
        let icon: String
        let key: String
        
        var uppercasedKey: String {
            var chars = Array(key)
            chars = chars.enumerated().map {
                $0 > 0 ? $1 : Character($1.uppercased())
            }
            return String(chars)
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(key)
        }
        
        static func ==(lhs: Self, rhs: Self) -> Bool {
            lhs.key == rhs.key
        }
    }
}

extension Symbol.Category {
    static let all: Symbol.Category = Symbol.Category(icon: "square.grid.2x2", key: "all")
}

struct AvailabilityInfo: Codable, Hashable, Identifiable {
    let platform: String
    let version: String
    
    var id: String {
        return platform
    }
}

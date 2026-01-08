//
//  SymbolError.swift
//  Anyswift
//
//  Created by vvii on 2026/1/6.
//

import Foundation

enum SymbolError: Error, CustomStringConvertible {
    case bundleNotFound(String)
    case resourceNotFound(String)
    
    var description: String {
        switch self {
        case .bundleNotFound(let bundle): "Bundle not found: \(bundle)"
        case .resourceNotFound(let resource): "Resource not found: \(resource)"
        }
    }
}

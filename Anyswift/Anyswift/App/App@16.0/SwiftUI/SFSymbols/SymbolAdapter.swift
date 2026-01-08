//
//  SymbolAdapter.swift
//  Anyswift
//
//  Created by vvii on 2026/1/7.
//

import Foundation
import SwiftUI

extension SymbolEffectAdapter {
    enum RepeatMode: Hashable {
        case once
        case repeating
    }
}

extension SymbolEffectAdapter {
    enum CopyMode: Hashable {
        case swift
        case objc
    }
}

extension SymbolRenderingMode: @retroactive Hashable {
    var id: String {
        return String(describing: self)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: SymbolRenderingMode, rhs: SymbolRenderingMode) -> Bool {
        lhs.id == rhs.id
    }
}

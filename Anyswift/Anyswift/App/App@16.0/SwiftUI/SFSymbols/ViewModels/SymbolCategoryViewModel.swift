//
//  SymbolCategoryViewModel.swift
//  Anyswift
//
//  Created by vvii on 2026/1/6.
//

import Foundation
import Combine

@MainActor
class SymbolCategoryViewModel: ObservableObject {
    let category: Symbol.Category
    @Published var symbols: [Symbol] = []
    
    init(category: Symbol.Category) {
        self.category = category
        loadSymbols()
    }
    
    func loadSymbols() {
        Task {
            do {
                if category == Symbol.Category.all {
                    symbols = try await SymbolManager.shared.loadOrderedSymbols()
                } else {
                    symbols = try await SymbolManager.shared.loadSymbols(of: category.key)
                }
            } catch {
                Log.error(error)
            }
        }
    }
}

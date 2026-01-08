//
//  SymbolCategoryListViewModel.swift
//  Anyswift
//
//  Created by vvii on 2026/1/6.
//

import Foundation
import Combine

@MainActor
class SymbolCategoryListViewModel: ObservableObject {
    @Published var categories: [Symbol.Category] = []
    
    init() {
        loadCategoryList()
    }
    
    func loadCategoryList() {
        Task {
            do {
                categories = try await SymbolManager.shared.loadCategoryList()
            } catch {
                Log.error(error)
            }
        }
    }
}

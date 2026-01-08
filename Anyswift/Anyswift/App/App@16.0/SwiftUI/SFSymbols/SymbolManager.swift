//
//  SymbolManager.swift
//  Anyswift
//
//  Created by vvii on 2026/1/6.
//

import Foundation

/// /Library/Developer/CoreSimulator/Volumes/iOS_23C54/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 26.2.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/SFSymbols.framework/CoreGlyphs.bundle
class SymbolManager {
    static let shared = SymbolManager()
    
    func loadCategoryList() async throws -> [Symbol.Category] {
        guard let bundle = Bundle(identifier: "com.apple.CoreGlyphs") else {
            throw SymbolError.bundleNotFound("com.apple.CoreGlyphs")
        }
        if let symbol_category_list_url = bundle.url(forResource: "categories", withExtension: "plist") {
            let symbol_category_list_data = try Data(contentsOf: symbol_category_list_url)
            let decoder = PropertyListDecoder()
            let categoryList = try decoder.decode([Symbol.Category].self, from: symbol_category_list_data)
            return categoryList
        }
        throw SymbolError.resourceNotFound("categories.plist")
    }
    
    func loadSymbols(of category: String) async throws -> [Symbol] {
        guard let bundle = Bundle(identifier: "com.apple.CoreGlyphs") else {
            throw SymbolError.bundleNotFound("com.apple.CoreGlyphs")
        }
        if let resourcePath = bundle.path(forResource: "symbol_categories", ofType: "plist"),
           let plist = NSDictionary(contentsOfFile: resourcePath) as? [String: [String]] {
            var symbols: [Symbol] = []
            for (key, categories) in plist {
                let symbol = Symbol(key: key, categories: categories)
                if categories.contains(category) || category == "all" {
                    symbols.append(symbol)
                }
            }
            return symbols
        }
        throw SymbolError.resourceNotFound("symbol_categories.plist")
    }
    
    func loadOrderedSymbols() async throws -> [Symbol] {
        guard let bundle = Bundle(identifier: "com.apple.CoreGlyphs") else {
            throw SymbolError.bundleNotFound("com.apple.CoreGlyphs")
        }
        if let resourcePath = bundle.path(forResource: "symbol_order", ofType: "plist"),
           let plist = NSArray(contentsOfFile: resourcePath) as? [String] {
            let ordered_symbols = plist.map { key in
                Symbol(key: key, categories: [])
            }
            return ordered_symbols
        }
        throw SymbolError.resourceNotFound("symbol_order.plist")
    }
    
    func loadAvailability(of symbol: String) async throws -> [String: String] {
        guard let bundle = Bundle(identifier: "com.apple.CoreGlyphs") else {
            throw SymbolError.bundleNotFound("com.apple.CoreGlyphs")
        }
        if let resourcePath = bundle.path(forResource: "name_availability", ofType: "plist"),
           let plist = NSDictionary(contentsOfFile: resourcePath),
           let symbols = plist["symbols"] as? [String: String],
           let year_to_release = plist["year_to_release"] as? [String: Dictionary<String, String>] {
            if let year = symbols[symbol], let availability = year_to_release[year] {
                return availability
            }
        }
        throw SymbolError.resourceNotFound("name_availability.plist")
    }
}

extension SymbolManager {
    
    @available(*, deprecated, message: "just for test")
    func loadAllSymbols() {
        guard let bundle = Bundle(identifier: "com.apple.CoreGlyphs") else {
            print("Failed: Bundle 'com.apple.CoreGlyphs' not found. Retrying...")
            return
        }
        if let resourcePath = bundle.path(forResource: "name_availability", ofType: "plist"),
           let plist = NSDictionary(contentsOfFile: resourcePath),
           let plistSymbols = plist["symbols"] as? [String: String] {
            Log.info("name_availability", plistSymbols)
        }
        
        if let resourcePath = bundle.path(forResource: "symbol_order", ofType: "plist"),
           let plist = NSArray(contentsOfFile: resourcePath) as? [String] {
            let ordered_symbols = plist
            Log.info("symbol_order", ordered_symbols)
        }
        
        if let resourcePath = bundle.path(forResource: "symbol_categories", ofType: "plist"),
           let plist = NSDictionary(contentsOfFile: resourcePath) as? [String: [String]] {
            var symbols: [Symbol] = []
            for (key, value) in plist {
                let symbol = Symbol(key: key, categories: value)
                symbols.append(symbol)
            }
            Log.info("symbol_categories", symbols)
        }
        
        if let symbol_category_list_url = bundle.url(forResource: "categories", withExtension: "plist"),
           let symbol_category_list_data = try? Data(contentsOf: symbol_category_list_url) {
            let decoder = PropertyListDecoder()
            do {
                let categoryList = try decoder.decode([Symbol.Category].self, from: symbol_category_list_data)
                Log.info("categories", categoryList)
            } catch {
                Log.error(error)
            }
        }
    }
}

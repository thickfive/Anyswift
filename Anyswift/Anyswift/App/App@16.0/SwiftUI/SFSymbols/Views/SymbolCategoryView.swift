//
//  SymbolCategoryView.swift
//  Anyswift
//
//  Created by vvii on 2026/1/6.
//

import SwiftUI

struct SymbolCategoryView: View {
    let category: Symbol.Category
    @StateObject private var viewModel: SymbolCategoryViewModel
    @State private var isPresented: Bool = false
    @State private var selectedSymbol: Symbol?
    @State private var searchText: String = ""
    private let columns = Array(repeating: GridItem(.fixed(100), spacing: 10, alignment: .center), count: 3)
    
    private var filteredSymbols: [Symbol] {
        if searchText.isEmpty {
            return viewModel.symbols
        } else {
            return viewModel.symbols.filter({ $0.key.localizedCaseInsensitiveContains(searchText) })
        }
    }
    
    init(category: Symbol.Category) {
        self.category = category
        _viewModel = StateObject(wrappedValue: SymbolCategoryViewModel(category: category))
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(filteredSymbols, id: \.self) { symbol in
                    Button {
                        selectedSymbol = symbol
                    } label: {
                        VStack {
                            ZStack {
                                Image(systemName: symbol.key)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(Color.gray)
                            }
                            .padding(20)
                            .frame(width: 80, height: 80)
                            .clipShape(
                                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                            )
                            .overlay {
                                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                                    .strokeBorder(lineWidth: 1)
                                    .foregroundStyle(Color.gray)
                            }
                            
                            ZStack(alignment: .top) {
                                Color.clear
                                Text(symbol.key)
                                    .font(.system(size: 14))
                                    .multilineTextAlignment(.center)
                            }
                            .frame(height: 40)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 20)
        }
        .navigationTitle("\(category.uppercasedKey)(\(viewModel.symbols.count))")
        .sheet(item: $selectedSymbol) { symbol in
            SymbolDetailView(symbol: symbol)
        }
        .searchable(text: $searchText, prompt: "Search")
        .scrollDismissesKeyboard(.immediately)
    }
}

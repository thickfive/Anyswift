//
//  SymbolCategoryListView.swift
//  Anyswift
//
//  Created by vvii on 2026/1/6.
//

import SwiftUI

struct SymbolCategoryListView: View {
    @StateObject var viewModel = SymbolCategoryListViewModel()
    private let columns = Array(repeating: GridItem(.fixed(100), spacing: 10, alignment: .center), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.categories, id: \.self) { category in
                    NavigationLink(destination: SymbolCategoryView(category: category)) {
                        VStack {
                            ZStack {
                                Image(systemName: category.icon)
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
                                Text(category.uppercasedKey)
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
        .navigationTitle("SF Symbols Categories(\(viewModel.categories.count))")
    }
}

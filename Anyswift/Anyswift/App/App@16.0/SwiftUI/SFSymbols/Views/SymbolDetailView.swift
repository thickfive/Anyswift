//
//  SymbolDetailView.swift
//  Anyswift
//
//  Created by vvii on 2026/1/6.
//

import SwiftUI
import Combine

struct SymbolDetailView: View {
    private let symbol: Symbol
    @StateObject private var viewModel: SymbolDetailViewModel
    @State private var presentationDetent: PresentationDetent = .large
    
    init(symbol: Symbol) {
        self.symbol = symbol
        _viewModel = StateObject(wrappedValue: SymbolDetailViewModel(symbol: symbol))
    }
    
    @State private var isTapped: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    Group {
                        if #available(iOS 17.0, *) {
                            Image(systemName: isTapped ? "circle.circle" : symbol.key, variableValue: viewModel.variableValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .applyIf(viewModel.isGradient, apply: { view in
                                    view.foregroundStyle(viewModel.primary)
                                }, elseApply: { view in
                                    view.foregroundStyle(viewModel.primary, viewModel.secondary, viewModel.tertiary)
                                })
                                .symbolRenderingMode(viewModel.renderingMode)
                                .symbolEffect(.variableColor, options: viewModel.repeatMode == .once ? .nonRepeating : .repeating, isActive: viewModel.isActive)
                                .contentTransition(.symbolEffect(.replace))
                                .onTapGesture {
                                    isTapped.toggle()
                                }
                        } else {
                            Image(systemName: symbol.key, variableValue: viewModel.variableValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(viewModel.primary, viewModel.secondary, viewModel.tertiary)
                                .symbolRenderingMode(viewModel.renderingMode)
                        }
                    }
                    .font(viewModel.font)
                }
                .padding(20)
                .frame(width: 80, height: 80)
                .background(viewModel.background)
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
                        .font(viewModel.font)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 40)
            }
            .padding(.vertical, 40)
            
            if presentationDetent == .large {
                SymbolOptionsView()
                    .environmentObject(viewModel)
                Spacer()
            }
        }
        .padding(20)
        .presentationDetents([.medium, .large], selection: $presentationDetent)
        .presentationDragIndicator(.visible)
    }
}


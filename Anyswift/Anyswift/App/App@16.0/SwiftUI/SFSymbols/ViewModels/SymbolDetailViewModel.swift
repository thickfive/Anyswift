//
//  SymbolDetailViewModel.swift
//  Anyswift
//
//  Created by vvii on 2026/1/6.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class SymbolDetailViewModel: ObservableObject {
    let symbol: Symbol
    
    @Published var selectedIndex: Int = 0
    
    // 基础信息
    @Published var availabilityInfos: [AvailabilityInfo] = []
    
    // 渲染
    @Published var renderingMode: SymbolRenderingMode = .palette
    @Published var isGradient: Bool = false
    @Published var isVariable: Bool = false
    @Published var variableValue: Double = 0.0
    // 颜色
    @Published var primary: Color = .gray
    @Published var secondary: Color = .blue
    @Published var tertiary: Color = .yellow
    @Published var background: Color = .clear
    
    // 动画 @available(iOS 17.0, *)
    @Published var isActive: Bool = false
    @Published var effect: SymbolEffectAdapter = .automatic
    @Published var repeatMode: SymbolEffectAdapter.RepeatMode = .once
    @Published var copyMode: SymbolEffectAdapter.CopyMode = .swift
    
    // 字体
    @Published var font: Font = .system(.body, design: .serif, weight: .regular)
    @Published var textStyle: Font.TextStyle = .body
    @Published var design: Font.Design = .default
    @Published var weight: Font.Weight = .regular
    
    private var cancellables: [AnyCancellable] = []
    
    init(symbol: Symbol) {
        self.symbol = symbol
        Publishers.CombineLatest3($textStyle, $design, $weight)
            .sink { [weak self] (textStyle, design, weight) in
                self?.font = .system(textStyle, design: design, weight: weight)
            }
            .store(in: &cancellables)
        loadAvailability()
    }
    
    func loadAvailability() {
        Task {
            do {
                let availability = try await SymbolManager.shared.loadAvailability(of: symbol.key)
                var availabilityInfos: [AvailabilityInfo] = []
                for (key, value) in availability {
                    availabilityInfos.append(AvailabilityInfo(platform: key, version: value))
                }
                self.availabilityInfos = availabilityInfos
            } catch {
                Log.error(error)
            }
        }
    }
}

// SymbolEffectAdapter
enum SymbolEffectAdapter: Hashable {
    case automatic
    case appear
    case variableColor
    
    var value: Any {
        if #available(iOS 17.0, *) {
            switch self {
            case .automatic: return VariableColorSymbolEffect.variableColor
            case .appear: return VariableColorSymbolEffect.variableColor
            case .variableColor: return VariableColorSymbolEffect.variableColor
            @unknown default: return AppearSymbolEffect.appear
            }
        } else {
            return ""
        }
    }
}

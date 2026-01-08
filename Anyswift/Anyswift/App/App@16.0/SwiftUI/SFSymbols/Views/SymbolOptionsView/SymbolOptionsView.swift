//
//  SymbolOptionsView.swift
//  Anyswift
//
//  Created by vvii on 2026/1/7.
//

import SwiftUI

struct SymbolOptionsView: View {
    @EnvironmentObject private var viewModel: SymbolDetailViewModel
    
    var body: some View {
        VStack {
            Picker("Options", selection: $viewModel.selectedIndex) {
                Image(systemName: "info").tag(0)
                Image(systemName: "paintbrush").tag(1)
                Image(systemName: "sensor.tag.radiowaves.forward").tag(2)
                Image(systemName: "textformat").tag(3)
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 20)
            
            switch viewModel.selectedIndex {
            case 0: SymbolInfoInspector()       // "基础信息检查器"
            case 1: SymbolRenderInspector()     // "渲染检查器"
            case 2: SymbolAnimationInspector()  // "动画检查器"
            default: SymbolFontInspector()      // "字体检查器"
            }
        }
    }
}

/* SF Symbols
    // 􀅳 = "info"
    // 􀎑 = "paintbrush"
    // 􁁝 = "sensor.tag.radiowaves.forward" // ?
    // 􀅒 = "textformat"

    // 􀝥 = "paintpalette"
    // 􀀁 = "circle.fill"
    // 􁐄 = "slider.horizontal.below.square.and.square.filled"

    // 􁁝 = "sensor.tag.radiowaves.forward" // ?
    // 􀊄 = "play.fill"
    // 􀊞 = "repeat"
    // 􀉁 = "document.on.document" // iOS 18
 
    // 􀅒 = "textformat"
 */

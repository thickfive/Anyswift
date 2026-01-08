//
//  SymbolAnimationInspector.swift
//  Anyswift
//
//  Created by vvii on 2026/1/7.
//

import SwiftUI

// Symbol Animation Inspector
struct SymbolAnimationInspector: View {
    @EnvironmentObject private var viewModel: SymbolDetailViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "sensor.tag.radiowaves.forward")
                Text("动画")
                Spacer()
                Picker("Animation", selection: $viewModel.effect) {
                    Text("automatic").tag(SymbolEffectAdapter.automatic)
                }
                .pickerStyle(.menu)
                .fixedSize(horizontal: true, vertical: false)
                Button {
                    viewModel.isActive.toggle()
                } label: {
                    Image(systemName: "play.fill")
                        .tint(.black)
                }
            }
            HStack {
                Image(systemName: "repeat")
                Text("重复播放")
                Spacer()
                Picker("RepeatMode", selection: $viewModel.repeatMode) {
                    Text("once").tag(SymbolEffectAdapter.RepeatMode.once)
                    Text("repeating").tag(SymbolEffectAdapter.RepeatMode.repeating)
                }
                .pickerStyle(.menu)
                .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
}

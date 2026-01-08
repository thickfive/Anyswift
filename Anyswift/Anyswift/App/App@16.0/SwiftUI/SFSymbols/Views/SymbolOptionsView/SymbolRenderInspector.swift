//
//  SymbolRenderInspector.swift
//  Anyswift
//
//  Created by vvii on 2026/1/7.
//

import SwiftUI

/// Symbol Render Inspector
struct SymbolRenderInspector: View {
    @EnvironmentObject private var viewModel: SymbolDetailViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "paintpalette")
                Text("渲染模式")
                Spacer()
                Picker("Render Mode", selection: $viewModel.renderingMode) {
                    Text("单色").tag(SymbolRenderingMode.monochrome)
                    Text("分层").tag(SymbolRenderingMode.hierarchical)
                    Text("调色盘").tag(SymbolRenderingMode.palette)
                    Text("多色").tag(SymbolRenderingMode.multicolor)
                }
                .pickerStyle(.menu)
                .fixedSize(horizontal: true, vertical: false)
            }
            HStack {
                Image(systemName: "circle.fill")
                Text("渐变")
                Spacer()
                Toggle("", isOn: $viewModel.isGradient)
            }
            HStack {
                Image(systemName: "slider.horizontal.below.square.and.square.filled")
                Text("可变")
                Spacer()
                Toggle("", isOn: $viewModel.isVariable)
            }
            if viewModel.isVariable {
                Slider(value: $viewModel.variableValue)
            }
            HStack {
                Image(systemName: "circle.circle")
                Text("颜色")
                Spacer()
                VStack {
                    ZStack(alignment: .trailing) {
                        Picker("颜色", selection: $viewModel.primary) {
                            Text("自定义").tag(Color.random)
                            Text("原色").tag(Color.gray)
                            Text("红色").tag(Color.red)
                            Text("橙色").tag(Color.orange)
                            Text("黄色").tag(Color.yellow)
                            Text("绿色").tag(Color.green)
                            Text("蓝色").tag(Color.blue)
                            Text("青色").tag(Color.cyan)
                            Text("紫色").tag(Color.purple)
                        }
                        .pickerStyle(.menu)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.trailing, 28)
                        ColorPicker("", selection: $viewModel.primary)
                    }
                    if viewModel.renderingMode == .palette {
                        ZStack(alignment: .trailing) {
                            Picker("颜色", selection: $viewModel.secondary) {
                                Text("自定义").tag(Color.random)
                                Text("强调色").tag(Color.blue)
                                Text("红色").tag(Color.red)
                                Text("橙色").tag(Color.orange)
                                Text("黄色").tag(Color.yellow)
                                Text("绿色").tag(Color.green)
                                Text("蓝色").tag(Color.blue)
                                Text("青色").tag(Color.cyan)
                                Text("紫色").tag(Color.purple)
                            }
                            .pickerStyle(.menu)
                            .fixedSize(horizontal: true, vertical: false)
                            .padding(.trailing, 28)
                            ColorPicker("", selection: $viewModel.secondary)
                        }
                        ZStack(alignment: .trailing) {
                            Picker("颜色", selection: $viewModel.tertiary) {
                                Text("自定义").tag(Color.random)
                                Text("无").tag(Color.clear)
                                Text("红色").tag(Color.red)
                                Text("橙色").tag(Color.orange)
                                Text("黄色").tag(Color.yellow)
                                Text("绿色").tag(Color.green)
                                Text("蓝色").tag(Color.blue)
                                Text("青色").tag(Color.cyan)
                                Text("紫色").tag(Color.purple)
                            }
                            .pickerStyle(.menu)
                            .fixedSize(horizontal: true, vertical: false)
                            .padding(.trailing, 28)
                            ColorPicker("", selection: $viewModel.tertiary)
                        }
                    }
                }
            }
            HStack {
                Image(systemName: "circle.circle.fill")
                Text("背景")
                Spacer()
                ZStack(alignment: .trailing) {
                    Picker("背景", selection: $viewModel.background) {
                        Text("自定义").tag(Color.random)
                        Text("默认").tag(Color.clear)
                        Text("红色").tag(Color.red)
                        Text("橙色").tag(Color.orange)
                        Text("黄色").tag(Color.yellow)
                        Text("绿色").tag(Color.green)
                        Text("蓝色").tag(Color.blue)
                        Text("青色").tag(Color.cyan)
                        Text("紫色").tag(Color.purple)
                    }
                    .pickerStyle(.menu)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.trailing, 28)
                    ColorPicker("", selection: $viewModel.background)
                }
            }
        }
    }
}

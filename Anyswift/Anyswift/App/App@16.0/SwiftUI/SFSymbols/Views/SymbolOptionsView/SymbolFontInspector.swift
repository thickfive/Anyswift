//
//  SymbolFontInspector.swift
//  Anyswift
//
//  Created by vvii on 2026/1/7.
//

import SwiftUI

// Symbol Font Inspector
struct SymbolFontInspector: View {
    @EnvironmentObject private var viewModel: SymbolDetailViewModel
    
    @State private var textStyle: Font.TextStyle = .body
    @State private var design: Font.Design = .default
    @State private var weight: Font.Weight = .regular
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "textformat.size")
                Text("TextStyle")
                Spacer()
                Picker("􀅐", selection: $viewModel.textStyle) {
                    Text("largeTitle").tag(Font.TextStyle.largeTitle)
                    Text("title").tag(Font.TextStyle.title)
                    Text("title2").tag(Font.TextStyle.title2)
                    Text("title3").tag(Font.TextStyle.title3)
                    Text("headline").tag(Font.TextStyle.headline)
                    Text("subheadline").tag(Font.TextStyle.subheadline)
                    Text("body").tag(Font.TextStyle.body)
                    Text("callout").tag(Font.TextStyle.callout)
                    Text("footnote").tag(Font.TextStyle.footnote)
                    Text("caption").tag(Font.TextStyle.caption)
                    Text("caption2").tag(Font.TextStyle.caption2)
                }
                .pickerStyle(.menu)
                .fixedSize(horizontal: true, vertical: false)
            }
            HStack {
                Image(systemName: "textformat.alt")
                Text("Design")
                Spacer()
                Picker("􀅑", selection: $viewModel.design) {
                    Text("default").tag(Font.Design.default)
                    Text("serif").tag(Font.Design.serif)
                    Text("rounded").tag(Font.Design.rounded)
                    Text("monospaced").tag(Font.Design.monospaced)
                }
                .pickerStyle(.menu)
                .fixedSize(horizontal: true, vertical: false)
            }
            HStack {
                Image(systemName: "textformat.subscript")
                Text("Weight")
                Spacer()
                Picker("􀓡", selection: $viewModel.weight) {
                    Text("ultraLight").tag(Font.Weight.ultraLight)
                    Text("thin").tag(Font.Weight.thin)
                    Text("light").tag(Font.Weight.light)
                    Text("regular").tag(Font.Weight.regular)
                    Text("medium").tag(Font.Weight.medium)
                    Text("semibold").tag(Font.Weight.semibold)
                    Text("bold").tag(Font.Weight.bold)
                    Text("heavy").tag(Font.Weight.heavy)
                    Text("black").tag(Font.Weight.black)
                }
                .pickerStyle(.menu)
                .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
}

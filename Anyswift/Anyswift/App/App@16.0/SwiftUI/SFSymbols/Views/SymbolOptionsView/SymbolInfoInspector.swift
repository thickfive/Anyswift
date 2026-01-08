//
//  SymbolInfoInspector.swift
//  Anyswift
//
//  Created by vvii on 2026/1/7.
//

import SwiftUI

/// Symbol Info
struct SymbolInfoInspector: View {
    @EnvironmentObject private var viewModel: SymbolDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "apple.logo")
                Text("适用于")
                Spacer()
            }
            VStack {
                ForEach(viewModel.availabilityInfos) { info in
                    HStack {
                        Text("\(info.platform) \(info.version)+")
                        Spacer()
                    }
                }
            }
            .padding(40)
            .background(Color.gray.opacity(0.15))
            .cornerRadius(8)
            HStack {
                Button {
                    UIPasteboard.general.string = viewModel.symbol.key
                } label: {
                    HStack {
                        Image(systemName: "doc.on.doc")
                        Text("复制")
                    }
                }
                Spacer()
            }
        }
    }
}

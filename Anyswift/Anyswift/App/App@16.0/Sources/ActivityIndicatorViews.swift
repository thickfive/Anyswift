//
//  ActivityIndicatorViews.swift
//  Anyswift
//
//  Created by vvii on 2026/1/17.
//

import SwiftUI
import ActivityIndicatorView

struct ActivityIndicatorViews: View {
    @State var isVisible = true
    private let columns = Array(repeating: GridItem(.fixed(100), spacing: 10, alignment: .center), count: 2)
    
    var body: some View {
        LazyVGrid(columns: columns) {
            Group {
                ActivityIndicatorView(isVisible: $isVisible, type: .default())
                ActivityIndicatorView(isVisible: $isVisible, type: .arcs())
                ActivityIndicatorView(isVisible: $isVisible, type: .rotatingDots())
                ActivityIndicatorView(isVisible: $isVisible, type: .flickeringDots())
                ActivityIndicatorView(isVisible: $isVisible, type: .scalingDots())
                ActivityIndicatorView(isVisible: $isVisible, type: .opacityDots())
                ActivityIndicatorView(isVisible: $isVisible, type: .equalizer())
                ActivityIndicatorView(isVisible: $isVisible, type: .growingArc(.red))
                ActivityIndicatorView(isVisible: $isVisible, type: .growingCircle)
                ActivityIndicatorView(isVisible: $isVisible, type: .gradient([.white, .black], .round, lineWidth: 2))
            }
            .frame(width: 25, height: 25)
            .foregroundColor(.red)
            
            
        }
    }
}

//
//  TextTransiton.swift
//  Anyswift
//
//  Created by vvii on 2026/1/18.
//

#if AVAILABLE_IOS_16
import SwiftUI

struct ContentTransition: View {
    @State private var isTapped: Bool = false
    @State private var color: Color = .red
    
    var body: some View {
        VStack {
            // iOS 16 缺少文字滚动的效果, 转场动画比较简单
            Text(isTapped ? "❌ iOS 16" : "✅ >= iOS 17")
                .font(Font.size(30).system.medium)
                .foregroundStyle(color)
                .contentTransition(.numericText())
                .onTapGesture {
                    isTapped.toggle()
                    color = .random
                }
        }
        .animation(.easeInOut(duration: 1), value: isTapped)
    }
}

struct MatchedGeometryEffect: View {
    @State private var isTapped: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            if isTapped {
                Image("icon-1024x1024")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .matchedGeometryEffect(id: "AppIcon", in: namespace)
                    .onTapGesture {
                        isTapped.toggle()
                    }
            } else {
                Text("icon-1024x1024")
                    // .resizable()
                    .frame(width: 200, height: 200)
                    .matchedGeometryEffect(id: "AppIcon", in: namespace)
                    .onTapGesture {
                        isTapped.toggle()
                    }
            }
        }
        .animation(.easeInOut(duration: 1), value: isTapped)
    }
}
#endif

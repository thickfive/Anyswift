//
//  NavigationBar.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI

public struct NavigationBar<LeadingView, CenterView, TrailingView>: View where LeadingView: View, CenterView: View, TrailingView: View {
    @ViewBuilder public var leadingItems: LeadingView
    @ViewBuilder public var centerItems: CenterView
    @ViewBuilder public var trailingItems: TrailingView
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            NavigationBarBackgroundView()
            NavigationBarContentView(leadingItems: leadingItems, centerItems: centerItems, trailingItems: trailingItems)
                .frame(height: Layout.navigationBarContentHeight)
        }
        .frame(height: Layout.navigationBarHeight)
    }
}

struct NavigationBarBackgroundView: View {
    var body: some View {
        Color.clear
    }
}

struct NavigationBarContentView<LeadingView, CenterView, TrailingView>: View where LeadingView: View, CenterView: View, TrailingView: View {
    var leadingItems: LeadingView
    var centerItems: CenterView
    var trailingItems: TrailingView
    private let coordinateSpaceName = "CoordinateSpaceName"
    @State private var leadingX: CGFloat = 0.0
    @State private var trailingX: CGFloat = Layout.screenWidth
    
    var body: some View {
        ZStack {
            HStack {
                AnyView(leadingItems)
                    .background(
                        GeometryReader { proxy in
                            Color.clear.onAppear {
                                leadingX = proxy.frame(in: .named(coordinateSpaceName)).maxX
                            }
                        }
                    )
                Spacer()
                AnyView(trailingItems)
                    .background(
                        GeometryReader { proxy in
                            Color.clear.onAppear {
                                trailingX = proxy.frame(in: .named(coordinateSpaceName)).minX
                            }
                        }
                    )
            }
            .coordinateSpace(name: coordinateSpaceName)
            AnyView(centerItems)
                .padding(8)
                .frame(maxWidth: maxWidth)
        }
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
        .background(
            Color.clear
                .frame(height: Layout.navigationBarContentHeight)
        )
    }
    
    private var maxWidth: CGFloat {
        let leadingWidth = leadingX
        let trailingWidth = Layout.screenWidth - trailingX
        let maxWidth = leadingWidth > trailingWidth ? (Layout.screenWidth - 2 * leadingWidth) : (Layout.screenWidth - 2 * trailingWidth)
        return max(0, maxWidth)
    }
}

//
//  NavigationPageView.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI

public struct NavigationPageView<Content: View>: View {
    /// navigationBar title
    var title: String?
    /// navigationBar leadingItems
    var leadingItems: (any View)?
    /// navigationBar centerItems
    var centerItems: (any View)?
    /// navigationBar trailingItems
    var trailingItems: (any View)?
    /// contentView
    @ViewBuilder var contentView: Content
    /// set navigationBar hidden or not
    var isNavigationBarHidden: Bool = false
    /// is dismiss keyboard on tap content
    var isDismissKeyboardOnTapContent: Bool = true
    /// use dismiss() to pop
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    public var body: some View {
        GeometryReader { _ in
            VStack(spacing: 0) {
                if !isNavigationBarHidden {
                    NavigationBar(
                        leadingItems: {
                            if let leadingItems = leadingItems {
                                AnyView(leadingItems)
                            } else {
                                Button {
                                    dismiss()
                                } label: {
                                    Image(systemName: "chevron.backward")
                                        .resizable()
                                        .foregroundStyle(Colors._000000.swiftUIColor)
                                        .padding(EdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3))
                                        .frame(width: 16, height: 24)
                                }
                            }
                        },
                        centerItems: {
                            if let centerItems = centerItems {
                                AnyView(centerItems)
                            } else {
                                Text(title ?? "")
                                    .font(Font.size(17).system.semibold)
                                    .foregroundStyle(Colors._000000.swiftUIColor)
                            }
                        },
                        trailingItems: {
                            if let trailingItems = trailingItems {
                                AnyView(trailingItems)
                            } else {
                                EmptyView()
                            }
                        }
                    )
                }
                Color.clear.opacity(1)
                    .overlay(alignment: .top) {
                        AnyView(contentView)
                            .frame(height: Layout.viewHeight(isNavigationBarHidden))
                    }
                    .applyIf(isDismissKeyboardOnTapContent, apply: { view in
                        view
                            .contentShape(Rectangle())
                            .dismissKeyboardOnTap()
                    })
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
    }
}

// /// SwiftUI隐藏返回按钮保留右滑手势方案
// /// https://blog.csdn.net/holybomb/article/details/148637799
extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

/// 不推荐: 系统页面也被影藏
/// https://stackoverflow.com/questions/59921239/hide-navigation-bar-without-losing-swipe-back-gesture-in-swiftui
// extension UINavigationController {
//     open override func viewWillLayoutSubviews() {
//         super.viewWillLayoutSubviews()
//         navigationBar.isHidden = true
//     }
// }


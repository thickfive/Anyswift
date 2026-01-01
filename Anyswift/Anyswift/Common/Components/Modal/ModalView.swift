//
//  ModalView.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI

/** ModalView
 ``` swift
 // 1. 创建 ModalView, 把 ModalViewModel 通过 environmentObject 传给子视图
 @main
 struct MyApp: App {
     @StateObject var modalViewModel = ModalViewModel()
  
     var body: some Scene {
         WindowGroup {
             ZStack {
                 NavigationView {
                     TestView()
                 }
                 .environmentObject(modalViewModel)
                 ModalView(viewModel: modalViewModel)
             }
         }
     }
 }
 // 2. 子视图中调用 ModalViewModel.show(entity: ModalEntity)
 struct TestView: View {
     @EnvironmentObject var modalViewModel: ModalViewModel
  
     var body: some View {
         Text(L10n.titleText)
             .onTapGesture {
                 modalViewModel.show(entity: ModalEntity(alignment: .top, insertionTransition: .move(edge: .top), removalTransition: .identity, content: {
                     Text("ModalViewModel.show(entity: ModalEntity)")
                 }))
             }
     }
 }
 ```
 */
public struct ModalView: View {
    @ObservedObject public var viewModel: ModalViewModel
    /// background color
    public var backgroundColor: Color = Color.black.opacity(0.2)
    /// background animation
    public var backgroundAnimation: Animation? = .spring(response: 0.5, dampingFraction: 0.825)
    /// ```
    /// .transition 只能作用于 ForEach 直系子视图, 而 ForEach 内包含多个子视图会用隐式 ZStack 排列, 正好解决多个 transition 无效的问题.
    /// 错误写法: ZStack { ForEach { ZStack { Color.transition() AnyView.transition() } } }.animation(), 只有 .opacity 生效.
    /// 正确写法: ZStack { ForEach { Color.transition() AnyView.transition() } }.animation()
    /// ```
    public var body: some View {
        ZStack {
            ForEach(Array(viewModel.entities.enumerated()), id: \.element) { (index, entityViewModel) in
                backgroundColor(for: entityViewModel)
                    .transition(.opacity)
                    .onTapGesture {
                        if viewModel.isAnimating == false && entityViewModel.entity.dismissOnTapOutside {
                            viewModel.dismiss()
                        }
                    }
                    .ignoresSafeArea()
                ModalEntityView(viewModel: entityViewModel)
                    .zIndex(Double(index)) // fix: removalTransition 被挡住的问题
            }
        }
        .transaction { _ in
            viewModel.isAnimating = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                viewModel.isAnimating = false
            }
        }
        .animation(backgroundAnimation, value: viewModel.entities)
    }
    
    func backgroundColor(for entityViewModel: ModalEntityViewModel) -> Color {
        entityViewModel.entity.backgroundColor ?? backgroundColor
    }
}

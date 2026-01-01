//
//  ModalEntity.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI

/// ModalEntity
///
/// - Parameters:
///   - backgroundColor: Color?, 自定义背景色
///   - alignment: Alignment, 自定义视图对齐方式
///   - animation: Animation, 自定义转场动画
///   - insertionTransition: AnyTransition, 不需要动画时使用 .identity
///   - removalTransition: AnyTransition, 不需要动画时使用 .identity
///   - dismissOnTapOutside: Bool, 是否需要点击空白区域消失
///   - content: @ViewBuilder, 自定义视图
///
public struct ModalEntity {
    public var backgroundColor: Color? = nil
    public var alignment: Alignment = .center
    public var animation: Animation? = .spring(response: 0.5, dampingFraction: 0.825)
    public var insertionTransition: AnyTransition = .scale(scale: 0.5).combined(with: .opacity)
    public var removalTransition: AnyTransition = .scale(scale: 0.5).combined(with: .opacity)
    public var dismissOnTapOutside: Bool = true
    @ViewBuilder public var content: any View
}

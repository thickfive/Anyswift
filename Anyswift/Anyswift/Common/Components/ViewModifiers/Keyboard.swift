//
//  Keyboard.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI

public extension View {
    func dismissKeyboardOnTap() -> some View {
        modifier(DismissKeyboardOnTap())
    }
}

public struct DismissKeyboardOnTap: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
    }
}

public extension View {
    /// Apply to full screen views
    /// - Parameters:
    ///   - margin: CGFloat, input bottom margin to keyboard
    /// - Returns: some View
    func adjustPositionOnKeyboardAppear(margin: CGFloat = 40) -> some View {
        modifier(KeyboardViewModifier(margin: margin, regions: .keyboard))
    }
    
    /// Apply to views that align bottom
    /// - Parameters:
    ///   - margin: CGFloat,  input bottom margin to keyboard
    ///   - alignment: Alignment, .bottom
    /// - Returns: some View
    func adjustPositionOnKeyboardAppear(margin: CGFloat = 40, alignment: Alignment) -> some View {
        ZStack(alignment: alignment) {
            Color.clear
            modifier(KeyboardViewModifier(margin: margin, regions: .all))
        }
        .ignoresSafeArea()
    }
}

public struct KeyboardViewModifier: ViewModifier {
    @State private var offset: CGFloat = 0
    @State private var shouldAdjustOffset: Bool = true
    public let margin: CGFloat
    public let regions: SafeAreaRegions
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                shouldAdjustOffset = true
            }
            .onDisappear {
                shouldAdjustOffset = false
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                if shouldAdjustOffset, let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    if let keyWindow = UIApplication.shared.keyWindow, let firstResponder = keyWindow.firstResponder {
                        let frame = firstResponder.convert(firstResponder.frame, to: keyWindow)
                        if frame.maxY + margin > keyboardFrame.minY {
                            // ignoresSafeArea(.keyboard) 模式下, 实际偏移值 != 计算偏移值
                            // 实际偏移值 = max(0, 计算偏移值 - Layout.safeAreaInsets.top)
                            // 因此需要加上额外的 Layout.safeAreaInsets.top
                            self.offset = frame.maxY + margin - keyboardFrame.minY + (regions == .keyboard ? Layout.safeAreaInsets.top : 0)
                        }
                    }
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                self.offset = 0
            }
            .animation(.easeOut(duration: 0.25), value: offset)
            .offset(y: -offset)
            .ignoresSafeArea(regions)
    }
}

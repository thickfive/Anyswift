//
//  ViewModifiers.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI

extension View {
    /// Applies a modification to the view only when the given condition is `true`.
    ///
    /// If `condition` is `true`, the `apply` closure is invoked with the current view (`self`)
    /// and its result is returned. Otherwise the original view is returned unchanged.
    ///
    /// This overload preserves the concrete `Self` type, making it ideal for type-safe
    /// chained modifications where you want to keep access to view-specific methods.
    ///
    /// - Parameters:
    ///   - condition: A Boolean value that determines whether the modification is applied.
    ///   - apply: A closure that receives the current view and returns a modified view of the same type.
    /// - Returns: The modified view if `condition` is `true`; otherwise the original view.
    public func applyIf(_ condition: Bool, apply: (Self) -> Self) -> Self {
        if condition {
            apply(self)
        } else {
            self
        }
    }
    
    /// Conditionally applies a view transformation, erasing the return type to `some View`.
    ///
    /// When `condition` is `true`, the `apply` closure is executed and its resulting view is returned.
    /// When `condition` is `false`, the original view is returned without any changes.
    ///
    /// Thanks to the `@ViewBuilder` attribute, the `apply` closure can contain complex SwiftUI
    /// view hierarchies (multiple statements, `if`, `ForEach`, etc.). This makes it perfect
    /// for conditionally wrapping a view with modifiers, overlays, backgrounds, custom modifiers, etc.
    ///
    /// - Parameters:
    ///   - condition: A Boolean value that determines whether the transformation is applied.
    ///   - apply: A closure that takes the current view and returns a new (potentially different) view.
    /// - Returns: The view returned by `apply(self)` when the condition is `true`; otherwise the original view.
    ///            The return type is type-erased to `some View`.
    @ViewBuilder
    public func applyIf(_ condition: Bool, apply: (Self) -> some View) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }
}

extension SafeAreaRegions {
    /// No safe area to ignore
    public static let none: SafeAreaRegions = SafeAreaRegions(rawValue: 0)
}

extension View {
    public func ignoresSafeArea(regions: SafeAreaRegions, edges: Edge.Set = .all) -> some View {
        self.applyIf(regions != .none) { view in
            view.ignoresSafeArea(regions, edges: edges)
        }
    }
}

extension View {
    public func hidden(_ hidden: Bool) -> some View {
        self.applyIf(hidden) { view in
            view.hidden()
        }
    }
}



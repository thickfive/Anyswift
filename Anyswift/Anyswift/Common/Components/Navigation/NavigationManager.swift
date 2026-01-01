//
//  NavigationManager.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation
import SwiftUI

public class NavigationManager {
    public static let shared = NavigationManager()
    
    private var closures: [AnyHashable: (AnyHashable) -> (any View)?] = [:]
    
    public func view(for destination: AnyHashable) -> AnyView {
        for closure in closures.values {
            if let view = closure(destination) {
                return AnyView(view)
            }
        }
        return AnyView(EmptyView())
    }
    
    /// Support multiple calls in different modules.
    /// If need to unregister a destination, provide an unique id.
    public func registerDestination(id: AnyHashable = UUID(), closure: @escaping (AnyHashable) -> (any View)?) {
        closures[id] = closure
    }
    
    public func unregisterDestination(id: AnyHashable) {
        closures[id] = nil
    }
}

public extension View {
    /// Register navigation destinations for views in NavigationStack
    /// - Returns: some View
    ///
    /// - Usage:
    /// 0. enum Destination: Hasable { case next }
    /// 1. NavigationManager.shared.registerDestination { if .next return NextView() else return nil }
    /// 2. NavigationStack(path: $navigationRouter.path) {
    ///     Group {
    ///        RootView()
    ///     }
    ///     .withNavigationDestinations()
    ///   }
    ///   .environmentObject(navigationRouter)
    /// 3. RootView { navigationRouter.navigate(to: .next) }
    /// 4. NextView { navigationRouter.navigateBack() }
    ///
    func withNavigationDestinations() -> some View {
        navigationDestination(for: AnyHashable.self) { destination in
            NavigationManager.shared.view(for: destination)
        }
    }
}

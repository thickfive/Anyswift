//
//  AppRouter.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI

public enum AppRouterDestination: Hashable {
    case login
    case home
}

extension NavigationManager {
    func setup() {
        NavigationManager.shared.registerDestination { destination in
            if let destination = destination as? AppRouterDestination {
                switch destination {
                case .login: return EmptyView()
                case .home: return EmptyView()
                }
            }
            return nil
        }
    }
}

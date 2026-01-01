//
//  AppScene16.swift
//  Anyswift
//
//  Created by vvii on 2026/1/1.
//

#if AVAILABLE_IOS_16
import SwiftUI

@available(iOS 16.0, *)
struct AppScene16: Scene {
    @StateObject private var modalViewModel = ModalViewModel()
    @StateObject private var navigationRouter = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack(path: $navigationRouter.path) {
                    Group {
                        ContentView16()
                    }
                    .withNavigationDestinations()
                }
                .environment(\.layoutDirection, .leftToRight)
                .environmentObject(modalViewModel)
                .environmentObject(navigationRouter)
                ModalView(viewModel: modalViewModel)
            }
        }
    }
}
#endif

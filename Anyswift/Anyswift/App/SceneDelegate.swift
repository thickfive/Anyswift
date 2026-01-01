//
//  SceneDelegate.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import UIKit

/// SceneDelegate
///
/// UIKit.UISceneDelegate 比 SwiftUI.ScenePhase 能获取到更多的信息
///
class SceneDelegate: NSObject, UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Log.verbose()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        Log.verbose()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        Log.verbose()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        Log.verbose()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        Log.verbose()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        Log.verbose()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        Log.verbose()
    }

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        Log.verbose()
        return nil
    }

    func scene(_ scene: UIScene, restoreInteractionStateWith stateRestorationActivity: NSUserActivity) {
        Log.verbose()
    }

    func scene(_ scene: UIScene, willContinueUserActivityWithType userActivityType: String) {
        Log.verbose()
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        Log.verbose()
    }

    func scene(_ scene: UIScene, didFailToContinueUserActivityWithType userActivityType: String, error: any Error) {
        Log.verbose()
    }

    func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity) {
        Log.verbose()
    }
}


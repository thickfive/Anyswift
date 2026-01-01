//
//  AppDelegate.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import UIKit
import DebugDependencies

@MainActor
class AppDelegate: NSObject, UIApplicationDelegate {
    private var _window: UIWindow?
    var window: UIWindow? {
        get { _window ?? UIApplication.shared.keyWindow }
        set { _window = newValue }
    }
    
    // setup
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        setupApplication()
        return true
    }
    
    func setupApplication() {
        DebugDependencies.shared.setup()
        LogManager.shared.setup(logger: SystemLogger())
        NetworkManager.shared.setup(config: networkConfig)
        PulseManager.shared.setup()
        CrashManager.shared.setup()
        NavigationManager.shared.setup()
    }
}

extension AppDelegate {
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        Log.verbose()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        Log.verbose()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication)  {
        Log.verbose()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        Log.verbose()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        Log.verbose()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Log.info("deviceToken = \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) {
        Log.error(error)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        Log.info(userInfo)
        return .failed
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self
        return config
    }
}

//
//  App.swift
//  Anyswift
//
//  Created by vvii on 2026/1/1.
//

import SwiftUI

@main
struct App: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
#if AVAILABLE_IOS_26
        if #available(iOS 26.0, *) {
            return AppScene26()
        }
#endif
        
#if AVAILABLE_IOS_18
        if #available(iOS 18.0, *) {
            return AppScene18()
        }
#endif
        
#if AVAILABLE_IOS_17
        if #available(iOS 17.0, *) {
            return AppScene17()
        }
#endif
        
#if AVAILABLE_IOS_16
        if #available(iOS 16.0, *) {
            return AppScene16()
        }
#endif
        
        return WindowGroup {
            VStack(alignment: .leading) {
                Text("修改宏定义:")
                Text("$PROJECT > Build Settings > Active Compilation Conditions")
                Text("AVAILABLE_IOS_{16/17/18/26}")
            }
            .padding(40)
        }
    }
}


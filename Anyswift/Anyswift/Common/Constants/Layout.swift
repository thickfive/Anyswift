//
//  Layout.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import UIKit

public struct Layout {
    /// iPhone SE: (20, 0, 0, 0)
    /// iPhone 15: (59, 0, 34, 0), safeAreaInsets.top 会比 statusBarFrame.height 稍微高一点
    /// 一般来说 灵动岛: (59, 0, 34, 0), 刘海: (44~48, 0, 34, 0), 无刘海: (20, 0, 0, 0)
    public static var safeAreaInsets: UIEdgeInsets {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.windows.first?.safeAreaInsets ?? .zero
        } else {
            return .zero
        }
    }
    
    /// iPhone SE: (0, 0, 375, 20)
    /// iPhone 15: (0, 0, 393, 54)
    public static var statusBarFrame: CGRect {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.statusBarManager?.statusBarFrame ?? .zero
        } else {
            return .zero
        }
    }
    
    public static var statusBarHeight: CGFloat {
        return statusBarFrame.height
    }
    
    public static var navigationBarContentHeight: CGFloat {
        return 44.0
    }
    
    public static var navigationBarHeight: CGFloat {
        return statusBarHeight + navigationBarContentHeight
    }
    
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    public static func viewHeight(_ isNavigationBarHidden: Bool) -> CGFloat {
        return screenHeight - (isNavigationBarHidden ? 0 : navigationBarHeight)
    }
}

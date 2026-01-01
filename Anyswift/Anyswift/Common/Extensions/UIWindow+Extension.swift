//
//  UIWindow+Extension.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import UIKit

public extension UIWindow {
    var firstResponder: UIView? {
        return enumerateSubviews(self) { $0.isFirstResponder }
    }
}

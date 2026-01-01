//
//  UIView+Extension.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import UIKit

public extension UIView {
    func enumerateSubviews(_ view: UIView, where conditon: (UIView) -> Bool) -> UIView? {
        if conditon(view) == true {
            return view
        }
        for view in view.subviews {
            if let view = enumerateSubviews(view, where: conditon) {
                return view
            }
        }
        return nil
    }
    
    func enumerateSubviews(_ view: UIView, action: (UIView) -> Void) {
        for view in view.subviews {
            enumerateSubviews(view, action: action)
        }
        action(view)
    }
}

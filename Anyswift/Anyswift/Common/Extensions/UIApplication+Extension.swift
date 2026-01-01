//
//  KeyWindow.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import UIKit

public extension UIApplication {
    /// UIApplication.shared.keyWindow
    var keyWindow: UIWindow? {
        connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene})
            .first?.windows
            .first(where: { $0.isKeyWindow })
    }
    
    /// UIApplication.shared.endEditing()
    /// UIApplication.shared.keyWindow?.endEditing(true)
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

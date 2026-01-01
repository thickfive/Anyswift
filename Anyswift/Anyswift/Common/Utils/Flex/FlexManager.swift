//
//  FlexManager.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

#if canImport(FLEX)
import Foundation
import FLEX

public class FlexManager {
    public static let shared = FlexManager()
    
    public func showExplorer() {
        FLEXManager.shared.showExplorer()
    }
}
#else
import Foundation

public class FlexManager {
    public static let shared = FlexManager()
    
    public func showExplorer() {
    }
}
#endif

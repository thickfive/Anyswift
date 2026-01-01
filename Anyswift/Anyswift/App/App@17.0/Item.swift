//
//  Item.swift
//  AnySwift
//
//  Created by vvii on 2026/1/1.
//

#if AVAILABLE_IOS_17
import Foundation
import SwiftData

@available(iOS 17, *)
@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
#endif

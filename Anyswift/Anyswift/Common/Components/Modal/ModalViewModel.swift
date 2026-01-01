//
//  ModalViewModel.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import SwiftUI
import Combine

public class ModalViewModel: NSObject, ObservableObject {
    @Published internal var entities: [ModalEntityViewModel] = []
    internal var isAnimating: Bool = false
    /// dismiss after delay
    public var dismissTimeInterval: TimeInterval?
    
    public init(dismissTimeInterval: TimeInterval? = nil) {
        self.dismissTimeInterval = dismissTimeInterval
    }
    
    public func show(entity: ModalEntity) {
        let entityViewModel = ModalEntityViewModel(entity: entity)
        entities.append(entityViewModel)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            entityViewModel.isInsertion = true
        }
        if let dismissTimeInterval = dismissTimeInterval {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(dismiss), object: nil)
            perform(#selector(dismiss), with: nil, afterDelay: dismissTimeInterval)
        }
    }
    
    @objc public func dismiss() {
        if let entityViewModel = entities.last {
            entityViewModel.isInsertion = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.entities.removeLast()
            }
            if let dismissTimeInterval = dismissTimeInterval {
                perform(#selector(dismiss), with: nil, afterDelay: dismissTimeInterval)
            }
        }
    }
}


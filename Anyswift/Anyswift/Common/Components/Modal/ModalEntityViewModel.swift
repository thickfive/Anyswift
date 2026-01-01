//
//  ModalEntityViewModel.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation
import Combine

public class ModalEntityViewModel: ObservableObject, Identifiable, Hashable {
    public var entity: ModalEntity
    /// Provides a composite transition that uses a different transition for insertion versus removal.
    @Published public var isInsertion: Bool = false
    public var id: UUID = UUID()
    
    public init(entity: ModalEntity) {
        self.entity = entity
    }
    
    /// Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: ModalEntityViewModel, rhs: ModalEntityViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

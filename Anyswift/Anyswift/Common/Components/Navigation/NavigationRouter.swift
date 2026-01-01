//
//  NavigationRouter.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation
import Combine

/// NavigationStack(path: $NavigationRouter.path) {...}
///
/// 为什么要用 AnyHashable 而不是 any Hashable 或者其他协议类型?
/// AnyHashable is A type-erased hashable value, 可以同时支持多个不同的 Hashable 类型.
/// AnyHashable 支持 Combine, 而 any Hashable 不支持.
///
/// enum: Hashable { } 天然支持 Hashable 不需要具体实现方法, 比自定义类型或者协议简洁.
/// e.g. enum RouterDestination: Hashable { case pageA; case pageB }
public class NavigationRouter: ObservableObject {
    @Published public var path: [AnyHashable] = []
    
    /// [HashableA, HashableA] -> Array<HashableA> -> AnyHashable
    public func navigate(to destination: AnyHashable) {
        if let destinations = destination as? Array<AnyHashable> {
            navigate(to: destinations)
        } else {
            navigate(to: [destination])
        }
    }
    
    /// [HashableA, HashableB] -> [AnyHashable]
    public func navigate(to destinations: [AnyHashable]) {
        path.append(contentsOf: destinations)
    }
    
    public func navigateBack() {
        path.removeLast()
    }
    
    public func navigateBack(_ destination: AnyHashable) {
        var k: Int = 0
        for p in path.reversed() {
            if p == destination { break }
            k += 1
        }
        path.removeLast(k)
    }
    
    public func navigateBack(_ k: Int) {
        path.removeLast(k)
    }
    
    public func navigateBackToRoot() {
        path.removeAll()
    }
    
    /// [HashableA, HashableA] -> Array<HashableA> -> AnyHashable
    public func replace(with destination: AnyHashable) {
        if let destinations = destination as? Array<AnyHashable> {
            replace(with: destinations)
        } else {
            replace(with: [destination])
        }
    }
    
    /// [HashableA, HashableB] -> [AnyHashable]
    public func replace(with destinations: [AnyHashable]) {
        if path.endIndex > 0 {
            path.replaceSubrange((path.endIndex - 1)..., with: destinations)
        }
    }
    
    public func replaceSubrange(_ subrange: Range<Int>, with destinations: [AnyHashable]) {
        path.replaceSubrange(subrange, with: destinations)
    }
}

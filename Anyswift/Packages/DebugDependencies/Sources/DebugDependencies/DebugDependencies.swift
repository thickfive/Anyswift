// The Swift Programming Language
// https://docs.swift.org/swift-book

#if DEBUG
import Foundation
#if canImport(LookinServer)
import LookinServer
#endif

public final class DebugDependencies: Sendable {
    public static let shared = DebugDependencies()

    public func setup() {
        print("⚠️ Please run `Product > Clean Build Folder (⇧⌘K)` after edit scheme!")
        print("$CONFIGURATION = Debug")
#if canImport(LookinServer)
        print("DebugDependencies - LookinServer")
#endif
    }
}
#else
import Foundation

public final class DebugDependencies: Sendable {
    public static let shared = DebugDependencies()

    public func setup() {
        print("⚠️ Please run `Product > Clean Build Folder (⇧⌘K)` after edit scheme!")
        print("$CONFIGURATION = Release")
    }
}
#endif

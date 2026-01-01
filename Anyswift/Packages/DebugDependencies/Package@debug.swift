// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DebugDependencies",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DebugDependencies",
            targets: ["DebugDependencies"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/QMUI/LookinServer/", .upToNextMajor(from: "1.2.8"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        //
        // dependencies: [.product(name: "LookinServer", package: "LookinServer")] // 这样写有时候找不到 LookinServer, 不稳定
        // dependencies: ["LookinServer"]
        .target(
            name: "DebugDependencies",
            dependencies: ["LookinServer"]
        ),
        .testTarget(
            name: "DebugDependenciesTests",
            dependencies: ["DebugDependencies"]
        ),
    ]
)

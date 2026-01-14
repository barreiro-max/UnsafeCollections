// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UnsafeCollections",
    products: [
        // Main Modules.
        .library(
            name: "UnsafeTree",
            targets: ["UnsafeTree"]
        ),
        .library(
            name: "UnsafeList",
            targets: ["UnsafeList"]
        ),
        .library(
            name: "UnsafeQueue",
            targets: ["UnsafeQueue"]
        ),
        .library(
            name: "UnsafeStack",
            targets: ["UnsafeStack"]
        ),
        
        // The library of all modules.
        .library(
            name: "UnsafeCollections",
            targets: ["UnsafeCollections"]
        ),
    ],
    targets: [
        
        // MARK: - Main target that allows importing UnsafeCollections as a single module.
        .target(
            name: "UnsafeCollections",
            dependencies: [
                "UnsafeTree",
                "UnsafeList",
                "UnsafeQueue",
                "UnsafeStack",
            ]
        ),
        
        // Core Module.
        .target(
            name: "UnsafeCollectionsCore",
            dependencies: [],
            path: "Core/UnsafeCollectionsCore"
        ),
        
        // UnsafeTree Module.
        .target(
            name: "UnsafeTree",
            dependencies: ["UnsafeCollectionsCore"]
        ),
        .testTarget(
            name: "UnsafeTreeTests",
            dependencies: ["UnsafeTree"]
        ),
        
        // UnsafeList Module.
        .target(
            name: "UnsafeList",
            dependencies: ["UnsafeCollectionsCore"]
        ),
        .testTarget(
            name: "UnsafeListTests",
            dependencies: ["UnsafeList"]
        ),
        
        // UnsafeQueue Module.
        .target(
            name: "UnsafeQueue",
            dependencies: ["UnsafeCollectionsCore"]
        ),
        .testTarget(
            name: "UnsafeQueueTests",
            dependencies: ["UnsafeQueue"]
        ),

        // UnsafeStack Module.
        .target(
            name: "UnsafeStack",
            dependencies: ["UnsafeCollectionsCore"]
        ),
        .testTarget(
            name: "UnsafeStackTests",
            dependencies: ["UnsafeStack"]
        ),
    ]
)


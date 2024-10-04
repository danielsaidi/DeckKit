// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "DeckKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "DeckKit",
            targets: ["DeckKit"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DeckKit",
            dependencies: []
        ),
        .testTarget(
            name: "DeckKitTests",
            dependencies: ["DeckKit"]
        )
    ]
)

// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "DeckKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
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

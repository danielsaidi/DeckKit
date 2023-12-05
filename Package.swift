// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "DeckKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "DeckKit",
            targets: ["DeckKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DeckKit",
            dependencies: []),
        .testTarget(
            name: "DeckKitTests",
            dependencies: ["DeckKit"]),
    ]
)

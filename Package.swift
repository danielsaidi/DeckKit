// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "DeckKit",
    platforms: [.iOS(.v13), .watchOS(.v6), .tvOS(.v13), .macOS(.v11)],
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

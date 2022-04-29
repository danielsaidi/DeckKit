// swift-tools-version:5.6

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
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "DeckKit",
            dependencies: []),
        .testTarget(
            name: "DeckKitTests",
            dependencies: ["DeckKit"]),
    ]
)

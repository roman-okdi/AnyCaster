// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnyCaster",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
        .watchOS(.v4),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "AnyCaster",
            targets: ["AnyCaster"]),
    ],
    targets: [
        .target(
            name: "AnyCaster"),
        .testTarget(
            name: "AnyCasterTests",
            dependencies: ["AnyCaster"]),
    ],
    swiftLanguageVersions: [.v4]
)

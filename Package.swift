// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "eec",
    products: [
        .executable(
            name: "eec",
            targets: ["EEC"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0"),
    ],
    targets: [
        .target(name: "Utils"),
        .target(name: "Models"),
        .target(
            name: "Modules",
            dependencies: [
                "Models",
                "Utils"
            ],
            resources: [.copy("Resources")]
        ),
        .executableTarget(
            name: "EEC",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Models",
                "Modules",
                "Utils",
            ]
        ),
        .testTarget(
            name: "EECTests",
            dependencies: ["EEC"]
        ),
    ]
)

// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NSFeatureProductsMock",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "NSFeatureProductsMock",
            targets: ["NSFeatureProductsMock"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/simplex-tech-apps/ns-core-design-system.git",
            from: "3.0.3"
        )
    ],
    targets: [
        .target(
            name: "NSFeatureProductsMock",
            dependencies: [
                .product(name: "NammaAppUI", package: "ns-core-design-system")
            ]
        )
    ]
)

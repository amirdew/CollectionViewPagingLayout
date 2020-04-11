// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "CollectionViewPagingLayout",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(
            name: "CollectionViewPagingLayout",
            targets: ["CollectionViewPagingLayout"]),
    ],
    targets: [
        .target(
            name: "CollectionViewPagingLayout",
            dependencies: [],
            path: "Lib",
            exclude: ["Samples"]),
    ]
)

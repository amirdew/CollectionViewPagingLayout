// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "CollectionViewPagingLayout",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "CollectionViewPagingLayout",
            targets: ["CollectionViewPagingLayout"])
    ],
    targets: [
        .target(
            name: "CollectionViewPagingLayout",
            path: "Lib",
            exclude: ["Samples"])
    ]
)

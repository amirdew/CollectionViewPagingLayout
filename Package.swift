// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "CollectionViewPagingLayout",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "CollectionViewPagingLayout",
            targets: ["CollectionViewPagingLayout"])
    ],
    targets: [
        .target(
            name: "CollectionViewPagingLayout",
            path: "Lib")
    ]
)

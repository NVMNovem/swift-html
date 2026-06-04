// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-html",
    platforms: [.macOS(.v13), .iOS(.v16), .watchOS(.v9), .tvOS(.v16)],
    products: [
        .library(name: "SwiftHTML", targets: ["SwiftHTML"]),
    ],
    targets: [
        .target(
            name: "SwiftHTML"
        ),
        .testTarget(
            name: "SwiftHTMLTests",
            dependencies: ["SwiftHTML"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "TypedHTMLTreeSpike",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "TypedHTMLTreeSpike", targets: ["TypedHTMLTreeSpike"]),
        .executable(name: "TypedHTMLTreeSpikeDemo", targets: ["TypedHTMLTreeSpikeDemo"]),
    ],
    targets: [
        .target(name: "TypedHTMLTreeSpike"),
        .executableTarget(
            name: "TypedHTMLTreeSpikeDemo",
            dependencies: ["TypedHTMLTreeSpike"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

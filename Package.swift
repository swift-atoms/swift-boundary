// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-boundary",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Boundary", targets: ["Boundary"]),
        .library(name: "Boundary Hash", targets: ["Boundary Hash"]),
        .library(
            name: "Boundary Comparison",
            targets: ["Boundary Comparison"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-hash.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-comparison.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(name: "Boundary", dependencies: []),

        .target(
            name: "Boundary Hash",
            dependencies: [
                .target(name: "Boundary"),
                .product(name: "Hash Protocol", package: "swift-hash"),
            ]
        ),
        .target(
            name: "Boundary Comparison",
            dependencies: [
                .target(name: "Boundary"),
                .product(name: "Comparison Protocol", package: "swift-comparison"),
            ]
        ),
        .testTarget(
            name: "Boundary Tests",
            dependencies: [.target(name: "Boundary")]
        ),
        .testTarget(
            name: "Boundary Hash Tests",
            dependencies: [.target(name: "Boundary Hash")]
        ),
        .testTarget(
            name: "Boundary Comparison Tests",
            dependencies: [.target(name: "Boundary Comparison")]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
    let package: [SwiftSetting] = []
    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}

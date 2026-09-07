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
        .library(name: "Boundary Standard Library Integration", targets: ["Boundary Standard Library Integration"]),
        .library(name: "Boundary Foundation Library Integration", targets: ["Boundary Foundation Library Integration"]),
        .library(name: "Boundary Test Support", targets: ["Boundary Test Support"]),
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
        .target(
            name: "Boundary",
            dependencies: [
                .product(name: "Hash", package: "swift-hash"),
                .product(name: "Comparison", package: "swift-comparison"),
            ],
            path: "Sources/Boundary"
        ),
        .target(
            name: "Boundary Standard Library Integration",
            dependencies: [
                .target(name: "Boundary"),
            ],
            path: "Sources/Boundary Standard Library Integration"
        ),
        .target(
            name: "Boundary Foundation Library Integration",
            dependencies: [
                .target(name: "Boundary"),
                .target(name: "Boundary Standard Library Integration"),
            ],
            path: "Sources/Boundary Foundation Library Integration"
        ),
        .target(
            name: "Boundary Test Support",
            dependencies: [
                .target(name: "Boundary"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Boundary Tests",
            dependencies: [
                .target(name: "Boundary"),
                .target(name: "Boundary Test Support"),
                .target(name: "Boundary Standard Library Integration"),
                .target(name: "Boundary Foundation Library Integration"),
            ],
            path: "Tests/Boundary Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}

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

        .library(name: "Boundary Foundation Integration", targets: ["Boundary Foundation Integration"]),
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
            name: "Boundary Foundation Integration",
            dependencies: [
                .target(name: "Boundary"),
            ],
            path: "Sources/Boundary Foundation Integration"
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
                .target(name: "Boundary Foundation Integration"),
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

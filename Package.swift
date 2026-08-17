// swift-tools-version: 6.3.3
import PackageDescription

let package = Package(
    name: "swift-boundary-primitives",
    platforms: [
        .macOS("27"),
        .iOS("27"),
        .tvOS("27"),
        .watchOS("27"),
        .visionOS("27"),
    ],
    products: [
        .library(name: "Boundary Primitive", targets: ["Boundary Primitive"]),
        .library(name: "Boundary Equation Primitives", targets: ["Boundary Equation Primitives"]),
        .library(name: "Boundary Hash Primitives", targets: ["Boundary Hash Primitives"]),
        .library(name: "Boundary Comparison Primitives", targets: ["Boundary Comparison Primitives"]),
        .library(name: "Boundary Primitives", targets: ["Boundary Primitives"]),
        .library(name: "Boundary Primitives Test Support", targets: ["Boundary Primitives Test Support"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-equation-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-hash-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-comparison-primitives.git", branch: "main"),
    ],
    targets: [
        // MARK: - Namespace (zero external dependencies — [MOD-017]; CaseIterable is stdlib)
        .target(name: "Boundary Primitive", dependencies: []),

        // MARK: - Sub-namespace targets (per [MOD-031]): institute twins
        .target(
            name: "Boundary Equation Primitives",
            dependencies: [
                "Boundary Primitive",
                .product(name: "Equation Primitives", package: "swift-equation-primitives"),
            ]
        ),
        .target(
            name: "Boundary Hash Primitives",
            dependencies: [
                "Boundary Primitive",
                .product(name: "Hash Primitives", package: "swift-hash-primitives"),
            ]
        ),
        .target(
            name: "Boundary Comparison Primitives",
            dependencies: [
                "Boundary Primitive",
                .product(name: "Comparison Primitives", package: "swift-comparison-primitives"),
            ]
        ),

        // MARK: - Umbrella
        .target(
            name: "Boundary Primitives",
            dependencies: [
                "Boundary Primitive",
                "Boundary Equation Primitives",
                "Boundary Hash Primitives",
                "Boundary Comparison Primitives",
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Boundary Primitives Test Support",
            dependencies: ["Boundary Primitives"],
            path: "Tests/Support"
        ),

        // MARK: - Tests
        .testTarget(
            name: "Boundary Primitives Tests",
            dependencies: ["Boundary Primitives", "Boundary Primitives Test Support"]
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
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]
    let package: [SwiftSetting] = []
    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}

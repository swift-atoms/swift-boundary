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
        .library(name: "Boundary Primitive", targets: ["Boundary Primitive"]),
        .library(name: "Boundary Equation", targets: ["Boundary Equation"]),
        .library(name: "Boundary Hash", targets: ["Boundary Hash"]),
        .library(
            name: "Boundary Comparison",
            targets: ["Boundary Comparison"]
        ),
        .library(name: "Boundary", targets: ["Boundary"]),
        .library(
            name: "Boundary Test Support",
            targets: ["Boundary Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-equation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-hash.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-comparison.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(name: "Boundary Primitive", dependencies: []),

        .target(
            name: "Boundary Equation",
            dependencies: [
                "Boundary Primitive",
                .product(name: "Equation", package: "swift-equation"),
            ]
        ),
        .target(
            name: "Boundary Hash",
            dependencies: [
                "Boundary Primitive",
                .product(name: "Hash", package: "swift-hash"),
            ]
        ),
        .target(
            name: "Boundary Comparison",
            dependencies: [
                "Boundary Primitive",
                .product(name: "Comparison", package: "swift-comparison"),
            ]
        ),

        .target(
            name: "Boundary",
            dependencies: [
                "Boundary Primitive",
                "Boundary Equation",
                "Boundary Hash",
                "Boundary Comparison",
            ]
        ),

        .target(
            name: "Boundary Test Support",
            dependencies: ["Boundary"],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Boundary Tests",
            dependencies: ["Boundary", "Boundary Test Support"]
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

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
        .library(
            name: "Boundary Standard Library Integration",
            targets: ["Boundary Standard Library Integration"]
        ),
        .library(
            name: "Boundary Apple Foundation Integration",
            targets: ["Boundary Apple Foundation Integration"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Boundary",
            dependencies: []
        ),
        .target(
            name: "Boundary Standard Library Integration",
            dependencies: ["Boundary"]
        ),
        .target(
            name: "Boundary Apple Foundation Integration",
            dependencies: [
                "Boundary",
                "Boundary Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Boundary Tests",
            dependencies: ["Boundary"]
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

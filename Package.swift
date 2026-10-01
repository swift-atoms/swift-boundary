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
    traits: [
        .trait(name: "Facet", description: "Facet integration"),
        .trait(name: "Orthant", description: "Orthant integration"),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-facet.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-axis.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-direction.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-orthant.git", branch: "main"),


    ],
    targets: [
        .target(
            name: "Boundary",
            dependencies: [
                .product(name: "Facet", package: "swift-facet", condition: .when(traits: ["Facet"])),
                .product(name: "Axis", package: "swift-axis", condition: .when(traits: ["Facet"])),
                .product(name: "Direction", package: "swift-direction", condition: .when(traits: ["Facet"])),
                .product(name: "Orthant", package: "swift-orthant", condition: .when(traits: ["Orthant"])),

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
        .testTarget(
            name: "Boundary Facet Tests",
            dependencies: [
                .target(name: "Boundary"),
                .product(name: "Facet", package: "swift-facet", condition: .when(traits: ["Facet"])),
                .product(name: "Axis", package: "swift-axis", condition: .when(traits: ["Facet"])),
                .product(name: "Direction", package: "swift-direction", condition: .when(traits: ["Facet"])),
            ],
            path: "Tests/Boundary Facet Tests"
        ),
        .testTarget(
            name: "Boundary Orthant Tests",
            dependencies: [
                .target(name: "Boundary"),
                .product(name: "Orthant", package: "swift-orthant", condition: .when(traits: ["Orthant"])),
            ],
            path: "Tests/Boundary Orthant Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableExperimentalFeature("Lifetimes"),
        .treatAllWarnings(as: .error),
    ]
}

# Boundary

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Named boundary views of an axis-aligned 2D box for Swift — the `Boundary.Edge` and `Boundary.Corner` enums, each a distinct identity over its `Facet<2>` / `Orthant<2>` carrier, with no platform dependencies.

---

## Quick Start

`Boundary` is a small vocabulary for the named parts of an axis-aligned box: `Boundary.Edge` is the four edges (over the `Facet<2>` carrier) and `Boundary.Corner` is the four corners (over the `Orthant<2>` carrier). Each case carries its own identity — a box edge is *not* a compass bearing and a box corner is *not* a plane quadrant — so the type cannot be confused with `Compass.Cardinal` or `Sector.Quadrant`, which share the same carriers.

```swift
import Boundary

// The four edges in canonical order, each paired with its opposite face.
for edge in Boundary.Edge.allCases {
    print(edge, "↔", edge.opposite)
}
// top ↔ bottom
// left ↔ right
// bottom ↔ top
// right ↔ left

// Corners are vertices with their own identity and adjacency.
let corner = Boundary.Corner.topLeft
print(corner.opposite)              // bottomRight
print(corner.isTop, corner.isLeft)  // true true
```

Both enums are `CaseIterable`, totally ordered (`Comparable` by declaration rank), `Hashable`, and `Codable`, so they drop straight into `Set`, `Dictionary` keys, `sorted()`, and serialization:

```swift
import Boundary

let edges: Set<Boundary.Edge> = [.right, .top, .top]   // {top, right}
let sorted = [Boundary.Corner.bottomRight, .topLeft].sorted()
// [topLeft, bottomRight]
```

The lossless carrier projections (`Edge.facet`, `Corner.orthant`) live in the per-carrier bridge packages `swift-boundary-facet` and `swift-boundary-orthant`. The institute-twin protocol conformances (`Equation.Protocol`, `Hash.Protocol`, `Comparison.Protocol`) ship as separate products so a consumer pays only for the witnesses it imports.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-molecules/swift-boundary.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Boundary", package: "swift-boundary"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

Six library products. The root namespace has zero external dependencies; each institute-twin target adds one conformance over its matching primitive.

| Product | Target | Purpose |
|---------|--------|---------|
| `Boundary Primitive` | `Sources/Boundary Primitive/` | The `Boundary` namespace: `Boundary.Edge` (four edges over `Facet<2>`) and `Boundary.Corner` (four corners over `Orthant<2>`), with `opposite`, corner `isTop` / `isLeft`, total ordering, hashing, and `Codable`. |
| `Boundary Equation` | `Sources/Boundary Equation/` | Conforms `Edge` and `Corner` to the institute `Equation.Protocol`. |
| `Boundary Hash` | `Sources/Boundary Hash/` | Conforms `Edge` and `Corner` to the institute `Hash.Protocol`. |
| `Boundary Comparison` | `Sources/Boundary Comparison/` | Conforms `Edge` and `Corner` to the institute `Comparison.Protocol`. |
| `Boundary` | `Sources/Boundary/` | Umbrella that re-exports the root namespace and all three institute-twin conformances. |
| `Boundary Test Support` | `Tests/Support/` | Re-exports the umbrella for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).

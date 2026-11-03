# swift-boundary

Use this package when you need to name one side or one corner of a rectangle: start from `Boundary.Edge` for sides and `Boundary.Corner` for corners. For faces and sign patterns of an n-dimensional box, use the siblings swift-facet (`Facet`) and swift-orthant (`Orthant`) instead; the `Facet` and `Orthant` traits connect this package's types to the two-dimensional cases of those.

## Laws

- `opposite` is an involution on both types: `x.opposite.opposite == x`.
- `Boundary.Edge` is ordered `top < left < bottom < right`, which is also the order of `allCases`.
- `Boundary.Corner` is ordered `topLeft < topRight < bottomLeft < bottomRight` (row by row from the top), which is also the order of `allCases`.
- The axes point right and up: the primary axis runs left to right, and the secondary axis runs bottom to top. So `top` is the positive face on the secondary axis, `right` is the positive face on the primary axis, and `topLeft` has a negative primary sign and a positive secondary sign.
- `Boundary.Edge(facet:)` inverts `facet`, and `Boundary.Corner(orthant:)` inverts `orthant`.
- Both projections commute with opposition: `edge.opposite.facet == edge.facet.opposite` and `corner.opposite.orthant == corner.orthant.opposite`.

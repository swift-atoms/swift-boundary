// Boundary.Edge.swift
// The four edges of an axis-aligned 2D box.

extension Boundary {
    /// The four edges of an axis-aligned 2D box, over the `Facet<2>` carrier.
    ///
    /// A box edge — deliberately distinct from `Compass.Cardinal`, which shares the `Facet<2>`
    /// carrier but means a compass bearing. The lossless `.facet` projection lives in
    /// `swift-boundary-facet-primitives`.
    public enum Edge: Sendable, CaseIterable {
        /// The top edge (+Y face).
        case top
        /// The left edge (−X face).
        case left
        /// The bottom edge (−Y face).
        case bottom
        /// The right edge (+X face).
        case right
    }
}

// MARK: - Semantics

extension Boundary.Edge {
    /// The opposite edge (top ↔ bottom, left ↔ right).
    @inlinable
    public var opposite: Boundary.Edge {
        switch self {
        case .top: .bottom
        case .bottom: .top
        case .left: .right
        case .right: .left
        }
    }
}

// MARK: - Equality, Hashing, Ordering

extension Boundary.Edge {
    @usableFromInline
    var _rank: Int {
        switch self {
        case .top: 0
        case .left: 1
        case .bottom: 2
        case .right: 3
        }
    }

    /// Two edges are equal when they name the same face of the box.
    @inlinable public static func == (lhs: Boundary.Edge, rhs: Boundary.Edge) -> Bool {
        lhs._rank == rhs._rank
    }
    /// Orders edges by their declaration rank: top, left, bottom, right.
    @inlinable public static func < (lhs: Boundary.Edge, rhs: Boundary.Edge) -> Bool {
        lhs._rank < rhs._rank
    }
    /// Whether this edge precedes or equals the other in declaration rank.
    @inlinable public static func <= (lhs: Boundary.Edge, rhs: Boundary.Edge) -> Bool {
        lhs._rank <= rhs._rank
    }
    /// Whether this edge follows the other in declaration rank.
    @inlinable public static func > (lhs: Boundary.Edge, rhs: Boundary.Edge) -> Bool {
        lhs._rank > rhs._rank
    }
    /// Whether this edge follows or equals the other in declaration rank.
    @inlinable public static func >= (lhs: Boundary.Edge, rhs: Boundary.Edge) -> Bool {
        lhs._rank >= rhs._rank
    }
    /// Hashes the edge by its declaration rank.
    @inlinable public func hash(into hasher: inout Hasher) { hasher.combine(_rank) }
}

// MARK: - Codable

#if !hasFeature(Embedded)
    extension Boundary.Edge: Codable {}
#endif

// Boundary.Corner.swift
// The four corners of an axis-aligned 2D box.

extension Boundary {
    /// The four corners of an axis-aligned 2D box, over the `Orthant<2>` carrier.
    ///
    /// A box vertex — deliberately distinct from `Sector.Quadrant`, which shares the
    /// `Orthant<2>` carrier but means a plane quadrant. The lossless `.orthant` projection
    /// lives in `swift-boundary-orthant-primitives`. (Supersedes the prior
    /// `Region.Corner` `{ horizontal, vertical }` struct with a thin enum.)
    public enum Corner: Sendable, CaseIterable {
        /// The top-left corner (−X, +Y).
        case topLeft
        /// The top-right corner (+X, +Y).
        case topRight
        /// The bottom-left corner (−X, −Y).
        case bottomLeft
        /// The bottom-right corner (+X, −Y).
        case bottomRight
    }
}

// MARK: - Semantics

extension Boundary.Corner {
    /// The diagonally-opposite corner (top-left ↔ bottom-right, top-right ↔ bottom-left).
    @inlinable
    public var opposite: Boundary.Corner {
        switch self {
        case .topLeft: .bottomRight
        case .bottomRight: .topLeft
        case .topRight: .bottomLeft
        case .bottomLeft: .topRight
        }
    }

    /// Whether this corner is on the top edge.
    @inlinable
    public var isTop: Bool { self == .topLeft || self == .topRight }

    /// Whether this corner is on the left edge.
    @inlinable
    public var isLeft: Bool { self == .topLeft || self == .bottomLeft }
}

// MARK: - Equality, Hashing, Ordering

extension Boundary.Corner {
    @usableFromInline
    var _rank: Int {
        switch self {
        case .topLeft: 0
        case .topRight: 1
        case .bottomLeft: 2
        case .bottomRight: 3
        }
    }

    /// Two corners are equal when they name the same vertex of the box.
    @inlinable public static func == (lhs: Boundary.Corner, rhs: Boundary.Corner) -> Bool {
        lhs._rank == rhs._rank
    }
    /// Orders corners by their declaration rank: top-left, top-right, bottom-left, bottom-right.
    @inlinable public static func < (lhs: Boundary.Corner, rhs: Boundary.Corner) -> Bool {
        lhs._rank < rhs._rank
    }
    /// Whether this corner precedes or equals the other in declaration rank.
    @inlinable public static func <= (lhs: Boundary.Corner, rhs: Boundary.Corner) -> Bool {
        lhs._rank <= rhs._rank
    }
    /// Whether this corner follows the other in declaration rank.
    @inlinable public static func > (lhs: Boundary.Corner, rhs: Boundary.Corner) -> Bool {
        lhs._rank > rhs._rank
    }
    /// Whether this corner follows or equals the other in declaration rank.
    @inlinable public static func >= (lhs: Boundary.Corner, rhs: Boundary.Corner) -> Bool {
        lhs._rank >= rhs._rank
    }
    /// Hashes the corner by its declaration rank.
    @inlinable public func hash(into hasher: inout Hasher) { hasher.combine(_rank) }
}

// MARK: - Codable

#if !hasFeature(Embedded)
    extension Boundary.Corner: Codable {}
#endif

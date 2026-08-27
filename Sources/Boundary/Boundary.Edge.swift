extension Boundary {

    public enum Edge: Sendable, CaseIterable {

        case top

        case left

        case bottom

        case right
    }
}

extension Boundary.Edge {

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

    @inlinable public static func == (lhs: Boundary.Edge, rhs: Boundary.Edge) -> Bool {
        lhs._rank == rhs._rank
    }

    @inlinable public static func < (lhs: Boundary.Edge, rhs: Boundary.Edge) -> Bool {
        lhs._rank < rhs._rank
    }

    @inlinable public static func <= (lhs: Boundary.Edge, rhs: Boundary.Edge) -> Bool {
        lhs._rank <= rhs._rank
    }

    @inlinable public static func > (lhs: Boundary.Edge, rhs: Boundary.Edge) -> Bool {
        lhs._rank > rhs._rank
    }

    @inlinable public static func >= (lhs: Boundary.Edge, rhs: Boundary.Edge) -> Bool {
        lhs._rank >= rhs._rank
    }

    @inlinable public func hash(into hasher: inout Hasher) { hasher.combine(_rank) }
}

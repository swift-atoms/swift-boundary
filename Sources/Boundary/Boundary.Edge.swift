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

#if !hasFeature(Embedded)
    extension Boundary.Edge: Swift::Codable {}
#endif

#if Facet
    public import Axis
    public import Direction
    public import Facet

    extension Boundary.Edge {

        @inlinable
        public var facet: Facet<2> {
            switch self {
            case .top: Facet(axis: .secondary, direction: .positive)
            case .left: Facet(axis: .primary, direction: .negative)
            case .bottom: Facet(axis: .secondary, direction: .negative)
            case .right: Facet(axis: .primary, direction: .positive)
            }
        }

        @inlinable
        public init(facet: Facet<2>) {
            switch (facet.axis.underlying, facet.direction) {
            case (1, .positive): self = .top
            case (0, .negative): self = .left
            case (1, .negative): self = .bottom
            default: self = .right
            }
        }
    }
#endif

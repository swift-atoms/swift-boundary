extension Boundary {

    public enum Corner: Sendable, CaseIterable {

        case topLeft

        case topRight

        case bottomLeft

        case bottomRight
    }
}

extension Boundary.Corner {

    @inlinable
    public var opposite: Boundary.Corner {
        switch self {
        case .topLeft: .bottomRight
        case .bottomRight: .topLeft
        case .topRight: .bottomLeft
        case .bottomLeft: .topRight
        }
    }

    @inlinable
    public var isTop: Bool { self == .topLeft || self == .topRight }

    @inlinable
    public var isLeft: Bool { self == .topLeft || self == .bottomLeft }
}

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

    @inlinable public static func == (lhs: Boundary.Corner, rhs: Boundary.Corner) -> Bool {
        lhs._rank == rhs._rank
    }

    @inlinable public static func < (lhs: Boundary.Corner, rhs: Boundary.Corner) -> Bool {
        lhs._rank < rhs._rank
    }

    @inlinable public static func <= (lhs: Boundary.Corner, rhs: Boundary.Corner) -> Bool {
        lhs._rank <= rhs._rank
    }

    @inlinable public static func > (lhs: Boundary.Corner, rhs: Boundary.Corner) -> Bool {
        lhs._rank > rhs._rank
    }

    @inlinable public static func >= (lhs: Boundary.Corner, rhs: Boundary.Corner) -> Bool {
        lhs._rank >= rhs._rank
    }

    @inlinable public func hash(into hasher: inout Hasher) { hasher.combine(_rank) }
}

#if !hasFeature(Embedded)
    extension Boundary.Corner: Swift::Codable {}
#endif

#if Orthant
    public import Orthant

    extension Boundary.Corner {

        @inlinable
        public var orthant: Orthant<2> {
            switch self {
            case .topLeft: Orthant { $0 == 0 ? .negative : .positive }
            case .topRight: Orthant { _ in .positive }
            case .bottomLeft: Orthant { _ in .negative }
            case .bottomRight: Orthant { $0 == 0 ? .positive : .negative }
            }
        }

        @inlinable
        public init(orthant: Orthant<2>) {
            switch (orthant.directions[0], orthant.directions[1]) {
            case (.negative, .positive): self = .topLeft
            case (.positive, .positive): self = .topRight
            case (.negative, .negative): self = .bottomLeft
            default: self = .bottomRight
            }
        }
    }
#endif

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

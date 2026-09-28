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

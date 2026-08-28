import Boundary
import Testing

@Suite
struct `Boundary Tests` {
    @Test
    func `opposites are involutive`() {
        for edge in Boundary.Edge.allCases {
            #expect(edge.opposite.opposite == edge)
        }
        for corner in Boundary.Corner.allCases {
            #expect(corner.opposite.opposite == corner)
        }
    }
}

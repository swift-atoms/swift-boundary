import Boundary
import Testing

@Suite
struct `Boundary edges preserve their structure under opposition` {
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

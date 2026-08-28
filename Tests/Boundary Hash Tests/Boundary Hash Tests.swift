import Boundary_Hash
import Testing

@Suite
struct `Boundary Hash Tests` {
    @Test
    func `edges are distinct set elements`() {
        #expect(Set(Boundary.Edge.allCases).count == 4)
    }
}

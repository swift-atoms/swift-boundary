import Boundary
import Testing

@Suite
struct `Boundary edges remain distinct in sets` {
    @Test
    func `edges are distinct set elements`() {
        #expect(Set(Boundary.Edge.allCases).count == 4)
    }
}

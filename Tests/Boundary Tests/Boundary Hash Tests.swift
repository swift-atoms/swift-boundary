import Boundary
import Testing

enum `Boundary Hash Tests` {}

extension `Boundary Hash Tests` {
    @Suite
    struct `Boundary edges remain distinct in sets` {
        @Test
        func `edges are distinct set elements`() {
            #expect(Set(Boundary.Edge.allCases).count == 4)
        }
    }
}

import Boundary
import Boundary_Comparison
import Testing

@Suite
struct `Boundary Comparison Tests` {
    @Test
    func `boundaries retain rank ordering`() {
        #expect(Boundary.Edge.allCases.sorted() == Boundary.Edge.allCases)
        #expect(Boundary.Corner.allCases.sorted() == Boundary.Corner.allCases)
    }
}

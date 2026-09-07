import Boundary
import Testing

@Suite
struct `Boundary edges compare according to their rank` {
    @Test
    func `boundaries retain rank ordering`() {
        #expect(Boundary.Edge.allCases.sorted() == Boundary.Edge.allCases)
        #expect(Boundary.Corner.allCases.sorted() == Boundary.Corner.allCases)
    }
}

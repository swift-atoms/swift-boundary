import Boundary
import Testing

@Suite
struct `Boundary Comparison` {
    @Test
    func `Boundary types satisfy Comparison Protocol`() {
        func acceptsComparisonProtocol<T: Comparison.`Protocol`>(_ value: T) -> T {
            value
        }

        #expect(acceptsComparisonProtocol(Boundary.Edge.left) == .left)
        #expect(acceptsComparisonProtocol(Boundary.Corner.bottomRight) == .bottomRight)
    }

    @Test
    func `Comparison preserves edge rank`() {
        #expect(Comparison(Boundary.Edge.top, .left) == .less)
        #expect(Comparison(Boundary.Edge.bottom, .bottom) == .equal)
        #expect(Comparison(Boundary.Edge.right, .bottom) == .greater)
    }

    @Test
    func `Comparison preserves corner rank`() {
        #expect(Comparison(Boundary.Corner.topLeft, .topRight) == .less)
        #expect(Comparison(Boundary.Corner.bottomLeft, .bottomLeft) == .equal)
        #expect(Comparison(Boundary.Corner.bottomRight, .bottomLeft) == .greater)
    }
}

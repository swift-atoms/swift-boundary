import Boundary
import Testing

private func acceptsEquation<Value: Equation.`Protocol`>(_ value: Value) -> Value {
    value
}

@Suite
struct `Boundary Equation` {

    @Test func `edge satisfies Equation Protocol through the compatibility umbrella`() {
        let edge = acceptsEquation(Boundary.Edge.top)
        #expect(edge == .top)
        #expect(edge != .bottom)
    }

    @Test func `corner satisfies Equation Protocol through the compatibility umbrella`() {
        let corner = acceptsEquation(Boundary.Corner.topLeft)
        #expect(corner == .topLeft)
        #expect(corner != .bottomRight)
    }
}

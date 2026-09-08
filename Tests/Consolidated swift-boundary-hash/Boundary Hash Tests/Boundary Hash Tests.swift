import Boundary
import Hash
import Testing

@Suite
struct `Boundary Hash` {

    @Test
    func `Edge supplies Hash's domain-typed value`() {
        let first: Hash.Value = hash(Boundary.Edge.top)
        let second: Hash.Value = hash(Boundary.Edge.top)

        #expect(first == second)
    }

    @Test
    func `Corner supplies Hash's domain-typed value`() {
        let first: Hash.Value = hash(Boundary.Corner.topLeft)
        let second: Hash.Value = hash(Boundary.Corner.topLeft)

        #expect(first == second)
    }
}

private func hash<T: Hash.`Protocol`>(_ value: borrowing T) -> Hash.Value {
    value.hashValue
}

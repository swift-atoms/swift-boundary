import Boundary_Primitives
import Testing

@Suite
struct `Boundary.Edge` {
    @Suite struct Unit {
        @Test
        func `opposite swaps each pair`() {
            #expect(Boundary.Edge.top.opposite == .bottom)
            #expect(Boundary.Edge.bottom.opposite == .top)
            #expect(Boundary.Edge.left.opposite == .right)
            #expect(Boundary.Edge.right.opposite == .left)
        }

        @Test
        func `allCases and ordering`() {
            #expect(Boundary.Edge.allCases == [.top, .left, .bottom, .right])
            #expect(Boundary.Edge.top < .left)
            #expect(
                [Boundary.Edge.right, .top, .bottom, .left].sorted() == [
                    .top, .left, .bottom, .right,
                ]
            )
        }

        @Test
        func `Hashable`() {
            let set: Set<Boundary.Edge> = [.top, .left, .bottom, .right, .top]
            #expect(set.count == 4)
        }
    }

    @Suite struct `Edge Case` {}

    @Suite struct Integration {}
}

@Suite
struct `Boundary.Corner` {
    @Suite struct Unit {
        @Test
        func `opposite is the diagonal`() {
            #expect(Boundary.Corner.topLeft.opposite == .bottomRight)
            #expect(Boundary.Corner.topRight.opposite == .bottomLeft)
            for c in Boundary.Corner.allCases { #expect(c.opposite.opposite == c) }
        }

        @Test
        func `edge membership`() {
            #expect(Boundary.Corner.topLeft.isTop)
            #expect(Boundary.Corner.topLeft.isLeft)
            #expect(!Boundary.Corner.bottomRight.isTop)
            #expect(!Boundary.Corner.bottomRight.isLeft)
        }

        @Test
        func `allCases and Hashable`() {
            #expect(Boundary.Corner.allCases == [.topLeft, .topRight, .bottomLeft, .bottomRight])
            let set: Set<Boundary.Corner> = [
                .topLeft, .topRight, .bottomLeft, .bottomRight, .topLeft,
            ]
            #expect(set.count == 4)
        }
    }

    @Suite struct `Edge Case` {}

    @Suite struct Integration {}
}

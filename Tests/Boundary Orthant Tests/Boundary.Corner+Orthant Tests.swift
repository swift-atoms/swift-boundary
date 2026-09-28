#if Orthant
import Boundary
import Testing

@Suite
struct `Boundary.Corner Orthant projection` {
    @Suite struct Unit {
        @Test
        func `corner maps to its orthant signs`() {
            #expect(Boundary.Corner.topRight.orthant == Orthant<2>(repeating: .positive))
            #expect(Boundary.Corner.bottomLeft.orthant == Orthant<2>(repeating: .negative))
            #expect(Boundary.Corner.topLeft.orthant.directions[0] == .negative)
            #expect(Boundary.Corner.topLeft.orthant.directions[1] == .positive)
        }

        @Test
        func `projection round-trips`() {
            for corner in Boundary.Corner.allCases {
                #expect(Boundary.Corner(orthant: corner.orthant) == corner)
            }
        }

        @Test
        func `opposite corner is opposite orthant`() {
            for corner in Boundary.Corner.allCases {
                #expect(corner.opposite.orthant == corner.orthant.opposite)
            }
        }
    }

}
#endif

#if Facet
    import Axis
    import Boundary
    import Direction
    import Testing

    @Suite
    struct `Boundary.Edge Facet projection` {
        @Suite struct Unit {
            @Test
            func `facet maps each edge to its box face`() {
                #expect(Boundary.Edge.top.facet == Facet<2>(axis: .secondary, direction: .positive))
                #expect(Boundary.Edge.right.facet == Facet<2>(axis: .primary, direction: .positive))
            }

            @Test
            func `projection round-trips`() {
                for edge in Boundary.Edge.allCases {
                    #expect(Boundary.Edge(facet: edge.facet) == edge)
                }
            }

            @Test
            func `opposite edge is opposite facet`() {
                for edge in Boundary.Edge.allCases {
                    #expect(edge.opposite.facet == edge.facet.opposite)
                }
            }
        }

    }
#endif

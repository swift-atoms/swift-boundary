import Boundary

#if !hasFeature(Embedded)
    extension Boundary.Corner: Codable {}
#endif

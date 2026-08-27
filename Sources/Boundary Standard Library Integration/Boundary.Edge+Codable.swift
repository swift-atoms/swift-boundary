import Boundary

#if !hasFeature(Embedded)
    extension Boundary.Edge: Codable {

        @usableFromInline
        var _codingValue: String {
            switch self {
            case .top: "top"
            case .left: "left"
            case .bottom: "bottom"
            case .right: "right"
            }
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            switch value {
            case "top": self = .top
            case "left": self = .left
            case "bottom": self = .bottom
            case "right": self = .right
            default:
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Unknown Boundary.Edge value: \(value)"
                )
            }
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(_codingValue)
        }
    }
#endif

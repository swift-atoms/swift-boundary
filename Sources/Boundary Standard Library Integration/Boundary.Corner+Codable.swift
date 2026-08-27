import Boundary

#if !hasFeature(Embedded)
    extension Boundary.Corner: Codable {

        @usableFromInline
        var _codingValue: String {
            switch self {
            case .topLeft: "topLeft"
            case .topRight: "topRight"
            case .bottomLeft: "bottomLeft"
            case .bottomRight: "bottomRight"
            }
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            switch value {
            case "topLeft": self = .topLeft
            case "topRight": self = .topRight
            case "bottomLeft": self = .bottomLeft
            case "bottomRight": self = .bottomRight
            default:
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Unknown Boundary.Corner value: \(value)"
                )
            }
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(_codingValue)
        }
    }
#endif

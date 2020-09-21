import Foundation

// MARK: - FazerMenu
struct FazerMenu: Codable {
    let restaurantName: String
    let restaurantURL: String
    let priceHeader: JSONNull?
    let footer: String
    let menusForDays: [MenusForDay]
    let errorText: JSONNull?

    enum CodingKeys: String, CodingKey {
        case restaurantName = "RestaurantName"
        case restaurantURL = "RestaurantUrl"
        case priceHeader = "PriceHeader"
        case footer = "Footer"
        case menusForDays = "MenusForDays"
        case errorText = "ErrorText"
    }
}

// MARK: - MenusForDay
struct MenusForDay: Codable {
    let date: String
    let lunchTime: String?
    let setMenus: [SetMenu]

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case lunchTime = "LunchTime"
        case setMenus = "SetMenus"
    }
}

// MARK: - SetMenu
struct SetMenu: Codable {
    let sortOrder: Int
    let name: String?
    let price: JSONNull?
    let components: [String]

    enum CodingKeys: String, CodingKey {
        case sortOrder = "SortOrder"
        case name = "Name"
        case price = "Price"
        case components = "Components"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

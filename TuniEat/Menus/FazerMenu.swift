import Foundation

// MARK: - FazerMenu
struct FazerMenu: Codable {
    let restaurantName: String
    let restaurantURL: String
    let footer: String
    let menusForDays: [MenusForDay]

    enum CodingKeys: String, CodingKey {
        case restaurantName = "RestaurantName"
        case restaurantURL = "RestaurantUrl"
        case footer = "Footer"
        case menusForDays = "MenusForDays"
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
    let price: String?
    let components: [String]

    enum CodingKeys: String, CodingKey {
        case sortOrder = "SortOrder"
        case name = "Name"
        case price = "Price"
        case components = "Components"
    }
}

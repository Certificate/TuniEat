// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let finnMedi = try? newJSONDecoder().decode(FinnMedi.self, from: jsonData)

import Foundation

// MARK: - FinnMediElement
struct FinnMediElement: Codable {
    let kitchenName: String?
    let kitchenID: Int?
    let address, city, email, phone: String?
    let info: String?
    let menuTypes: [FinnMediMenuType]?

    enum CodingKeys: String, CodingKey {
        case kitchenName
        case kitchenID = "kitchenId"
        case address, city, email, phone, info, menuTypes
    }
}

// MARK: - MenuType
struct FinnMediMenuType: Codable {
    let menuTypeID: Int?
    let menuTypeName: String?
    let menus: [FinnMediMenu]?

    enum CodingKeys: String, CodingKey {
        case menuTypeID = "menuTypeId"
        case menuTypeName, menus
    }
}

// MARK: - Menu
struct FinnMediMenu: Codable {
    let menuName, menuAdditionalName: String?
    let menuID: Int?
    let days: [FinnMediDay]?

    enum CodingKeys: String, CodingKey {
        case menuName, menuAdditionalName
        case menuID = "menuId"
        case days
    }
}

// MARK: - Day
struct FinnMediDay: Codable {
    let date, weekday: Int?
    let mealoptions: [FinnMediMealoption]?
}

// MARK: - Mealoption
struct FinnMediMealoption: Codable {
    let name: String?
    let orderNumber, id: Int?
    let menuItems: [FinnMediMenuItem]?
}

// MARK: - MenuItem
struct FinnMediMenuItem: Codable {
    let name: String?
    let orderNumber, portionSize: Int?
    let diets, ingredients: String?
}

typealias FinnMedi = [FinnMediElement]

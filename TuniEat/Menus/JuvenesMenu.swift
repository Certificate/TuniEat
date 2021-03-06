//
//  JuvenesMenu.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 20.9.2020.
//  Copyright © 2020 Valtteri Vuori. All rights reserved.
//

import Foundation

// MARK: - JuvenesMenuElement
struct JuvenesMenuElement: Codable {
    let kitchenName: String?
    let kitchenID: Int?
    let address, city, email, phone: String?
    let info: String?
    let menuTypes: [MenuType]?

    enum CodingKeys: String, CodingKey {
        case kitchenName
        case kitchenID
        case address, city, email, phone, info, menuTypes
    }
}

// MARK: - MenuType
struct MenuType: Codable {
    let menuTypeID: Int?
    let menuTypeName: String?
    let menus: [Menu]?

    enum CodingKeys: String, CodingKey {
        case menuTypeID
        case menuTypeName, menus
    }
}

// MARK: - Menu
struct Menu: Codable {
    let menuName, menuAdditionalName: String?
    let menuID: Int?
    let days: [Day]?

    enum CodingKeys: String, CodingKey {
        case menuName, menuAdditionalName
        case menuID
        case days
    }
}

// MARK: - Day
struct Day: Codable {
    let date, weekday: Int?
    let mealoptions: [Mealoption]?
}

// MARK: - Mealoption
struct Mealoption: Codable {
    let name: String?
    let orderNumber, id: Int?
    let menuItems: [MenuItem]?
}

// MARK: - MenuItem
struct MenuItem: Codable {
    let name: String?
    let orderNumber, portionSize: Int?
    let diets, ingredients: String?
}

typealias JuvenesMenu = [JuvenesMenuElement]

//
//  JuvenesMenu.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 18.2.2020.
//  Copyright © 2020 Valtteri Vuori. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let juvenesMenu = try? newJSONDecoder().decode(JuvenesMenu.self, from: jsonData)

import Foundation

// MARK: - JuvenesMenu
struct JuvenesMenu: Codable {
    let additionalName, kitchenName: String
    let mealOptions: [MealOption]
    let menuDateISO: String
    let menuID, menuTypeID: Int
    let menuTypeName, name: String
    let week, weekday: Int

    enum CodingKeys: String, CodingKey {
        case additionalName = "AdditionalName"
        case kitchenName = "KitchenName"
        case mealOptions = "MealOptions"
        case menuDateISO = "MenuDateISO"
        case menuID = "MenuId"
        case menuTypeID = "MenuTypeId"
        case menuTypeName = "MenuTypeName"
        case name = "Name"
        case week = "Week"
        case weekday = "Weekday"
    }
}

// MARK: - MealOption
struct MealOption: Codable {
    let alsoAvailable: String
    let externalGroupID: Int
    let extraItems, forceMajeure: String
    let mealOptionID: Int
    let menuDate: String
    let menuItems: [MenuItem]
    let name, nameEN, nameFI, nameSV: String
    let price: Int

    enum CodingKeys: String, CodingKey {
        case alsoAvailable = "AlsoAvailable"
        case externalGroupID = "ExternalGroupId"
        case extraItems = "ExtraItems"
        case forceMajeure = "ForceMajeure"
        case mealOptionID = "MealOptionId"
        case menuDate = "MenuDate"
        case menuItems = "MenuItems"
        case name = "Name"
        case nameEN = "Name_EN"
        case nameFI = "Name_FI"
        case nameSV = "Name_SV"
        case price = "Price"
    }
}

// MARK: - MenuItem
struct MenuItem: Codable {
    let diets: String
    let displayStyle: Int
    let hideInPrint: Bool
    let ingredients, menuItemID, name, nameEN: String
    let nameFI, nameSV: String
    let nutritiveValues: [NutritiveValue]
    let orderNumber: Int
    let price: Double

    enum CodingKeys: String, CodingKey {
        case diets = "Diets"
        case displayStyle = "DisplayStyle"
        case hideInPrint = "HideInPrint"
        case ingredients = "Ingredients"
        case menuItemID = "MenuItemID"
        case name = "Name"
        case nameEN = "Name_EN"
        case nameFI = "Name_FI"
        case nameSV = "Name_SV"
        case nutritiveValues = "NutritiveValues"
        case orderNumber = "OrderNumber"
        case price = "Price"
    }
}

// MARK: - NutritiveValue
struct NutritiveValue: Codable {
    let dailyAmount: Int
    let name: String
    let units: [UnitElement]

    enum CodingKeys: String, CodingKey {
        case dailyAmount = "DailyAmount"
        case name = "Name"
        case units = "Units"
    }
}

// MARK: - UnitElement
struct UnitElement: Codable {
    let unit: UnitEnum
    let value: Double

    enum CodingKeys: String, CodingKey {
        case unit = "Unit"
        case value = "Value"
    }
}

enum UnitEnum: String, Codable {
    case g = "g"
    case kJ = "kJ"
    case kcal = "kcal"
    case kg = "kg"
}

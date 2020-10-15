//
//  RestaurantParser.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 20.9.2020.
//  Copyright © 2020 Valtteri Vuori. All rights reserved.
//

import Foundation

enum RestaurantParseError: Error {
    case noDateFound
    case invalidInfo
}

class RestaurantParser {

    private let jsonDecoder = JSONDecoder()

    func generateEmptyMeal() -> Meal {
        Meal(0, "Ei ruokatietoja tälle päivälle", " ")
    }

    func generateErrorMeal() -> Meal {
        Meal(0, "Virhe ruokatietoja hakiessa.", " ")
    }
    
    func parseSodexo(_ data: Data, _ restaurant:Restaurant) -> [Meal] {
        var meals: [Meal] = []
        do {
            let linnaMenus = try jsonDecoder.decode(LinnaMenu.self, from: data)
            if let courses = linnaMenus.courses {
                for menu in courses{
                    // Sometimes an empty meal is presented. Only let through values with real data.
                    if(!menu.value.titleFi.isEmpty){
                        let sortOrder = Int(menu.key) ?? 99
                        let price = !menu.value.price.isEmpty ? MenuTools.parseSodexoPrices(menu.value.price) : "Hintatietoja ei saatavilla"
                        meals.append(Meal(sortOrder, menu.value.titleFi, price))
                    }
                }
            }
            else{
                print("No meals available. Appending filler.")
                meals.append(generateEmptyMeal())
            }
        } catch {
            meals.append(generateErrorMeal())
            print("Error while parsing \(restaurant) meals: \(error)")
        }
        return meals
    }

    func parseFazer(_ data: Data, _ restaurant:Restaurant) -> [Meal] {
        var meals: [Meal] = []
        do {
            let fazerMenus = try jsonDecoder.decode(FazerMenu.self, from: data)
            let fazerTodaysMenus = MenuTools.extractFazerMenus(menusForDays: fazerMenus.menusForDays)
            if !fazerTodaysMenus.isEmpty {
                for menu in fazerTodaysMenus{
                    if let menuName = menu.name {
                        let (price, order) = MenuTools.parseFazerPricesAndOrder(mealName: menuName, restaurant: restaurant)
                        meals.append(MenuTools.generateFazerMeal(components: menu.components, price: price, order: order))
                    }
                    else {
                        let (price, order) = MenuTools.parseFazerPricesAndOrder(mealName: "Unknown", restaurant: restaurant)
                        meals.append(MenuTools.generateFazerMeal(components: menu.components, price: price, order: order))
                    }
                }
            }
            else {
                meals.append(generateEmptyMeal())
            }
        } catch {
            meals.append(generateErrorMeal())
            print("Error while parsing Fazer meals for \(restaurant): \(error)")
        }
        return meals
    }

    func parseJuvenes(_ data: Data, _ restaurant: Restaurant) -> [Meal] {
        var meals: [Meal] = []
        do {
            let yrMenus = try jsonDecoder.decode(JuvenesMenu.self, from: data)
            
            
            if let menuTypes = yrMenus[0].menuTypes {
                for menuType in menuTypes {
                    guard let menuName = menuType.menuTypeName else {
                        return [generateErrorMeal()]
                    }
                    
                    if !menuName.contains("Lounas"){
                        continue
                    }
                    
                    guard let days = menuType.menus?[0].days else {
                        return [generateErrorMeal()]
                    }

                    let mealOptions = try MenuTools.extractJuvenesMeals(days)

                    for meal in mealOptions {
                        guard let mealName = meal.name else{
                            throw RestaurantParseError.invalidInfo
                        }

                        guard let menuItemsList = meal.menuItems else {
                            throw RestaurantParseError.invalidInfo
                        }

                        try meals.append(MenuTools.generateJuvenesMeal(name: mealName, orderNumber: meal.orderNumber ?? 99, menuItems: menuItemsList, restaurantType: restaurant))
                    }
                }
            }
            
            
            
        } catch {
            meals.append(generateErrorMeal())
            print("Error while parsing Juvenes meals: \(error)")
        }
        
        return meals
    }
    
    func parseFinnMedi(_ data: Data, _ restaurant:Restaurant) -> [Meal] {
        var meals: [Meal] = []
        do {
            let finnMediMenus = try jsonDecoder.decode(FinnMedi.self, from: data)
            
            if let menuTypes = finnMediMenus[0].menuTypes {
                for menuType in menuTypes {

                    guard let days = menuType.menus?[0].days else {
                        return [generateErrorMeal()]
                    }

                    let mealOptions = try MenuTools.extractFinnMediMeals(days)

                    for meal in mealOptions {
                        
                        guard let mealName = meal.name else{
                            throw RestaurantParseError.invalidInfo
                        }
                        
                        // "Lounas" && "Lounas OP" contain the same information. We only need either.
                        if mealName == "Lounas"{
                            continue
                        }

                        guard let menuItemsList = meal.menuItems else {
                            throw RestaurantParseError.invalidInfo
                        }

                        try meals.append(MenuTools.generateFinnMediMeal(name: mealName, orderNumber: meal.orderNumber ?? 99, menuItems: menuItemsList, restaurantType: restaurant))
                    }
                }
            }
            
        } catch {
            meals.append(generateErrorMeal())
            print("Error while parsing FinnMedi meals for \(restaurant): \(error)")
        }
        return meals
    }
    
    
    
}

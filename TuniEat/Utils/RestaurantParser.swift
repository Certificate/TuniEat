//
//  RestaurantParser.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 20.9.2020.
//  Copyright © 2020 Valtteri Vuori. All rights reserved.
//

import Foundation

class RestaurantParser {

    private let jsonDecoder = JSONDecoder()

    func generateEmptyMeal() -> Meal {
        Meal(0, "Ei ruokatietoja tälle päivälle", " ")
    }

    func generateErrorMeal() -> Meal {
        Meal(0, "Virhe ruokatietoja hakiessa.", " ")
    }
    
    func parseLinna(_ data: Data) -> [Meal] {
        var meals: [Meal] = []
        do {
            let linnaMenus = try jsonDecoder.decode(LinnaMenu.self, from: data)
            if let courses = linnaMenus.courses {
                for menu in courses{
                    // Sometimes an empty meal is presented. Only let through values with real data.
                    if(!menu.value.titleFi.isEmpty){
                        let sortOrder = Int(menu.key) ?? 99
                        let price = !menu.value.price.isEmpty ? menu.value.price : "Hintatietoja ei saatavilla"
                        meals.append(Meal(sortOrder, menu.value.titleFi, price))
                    }
                }
            }
            else{
                print("No meals available. Appending filler.")
                meals.append(generateErrorMeal())
            }
        } catch {
            meals.append(generateErrorMeal())
            print("Error while parsing Linna meals: \(error)")
        }
        return meals
    }

    func parseMinerva(_ data: Data) -> [Meal] {
        var meals: [Meal] = []
        do {
            let minervaMenus = try jsonDecoder.decode(MinervaMenu.self, from: data)
            let minervaTodaysMenus = MenuTools.extractMenus(menusForDays: minervaMenus.menusForDays)
            if !minervaTodaysMenus.isEmpty {
                for menu in minervaTodaysMenus{
                    let (price, order) = MenuTools.parseMinervaPricesAndOrder(mealName: menu.name)
                    meals.append(MenuTools.generateMinervaMeal(components: menu.components, price: price, order: order))
                }
            }
            else {
                meals.append(generateEmptyMeal())
            }
        } catch {
            meals.append(generateErrorMeal())
            print("Error while parsing Minerva meals: \(error)")
        }
        return meals
    }

    func parseYliopistonRavintola(_ data: Data) -> [Meal] {
        var meals: [Meal] = []
        do {
            let minervaMenus = try jsonDecoder.decode(YRMenu.self, from: data)
            
            meals.append(generateEmptyMeal())
        } catch {
            meals.append(generateErrorMeal())
            print("Error while parsing Yliopiston Ravintola meals: \(error)")
        }
        

        return meals
    }
}
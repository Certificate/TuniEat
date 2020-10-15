//
//  MenuTools.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 4.2.2020.
//  Copyright © 2020 Valtteri Vuori. All rights reserved.
//

import Foundation


class MenuTools{

    
    // MARK: General
    
    class func GetCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: Date())
        //return "2020-09-18"
        return result
    }

    class func compareDateToToday(_ strDate: String) -> Bool{

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:strDate)!

        // Date -> String
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)

        // Compare today's date and recently converted date in "yyyy-MM-dd" format
        return MenuTools.GetCurrentDate() == result
    }
    
    // MARK: Fazer
    
    // It ain't pretty but it works
    class func parseFazerPricesAndOrder(mealName:String, restaurant:Restaurant) -> (String, Int){
        var price = ""
        var sortOrder = 0

        switch mealName {
        case let str where str.lowercased().contains("kasviskeitto"):
            price = restaurant == Restaurant.Minerva ? "2,30€ / 4,90€" : "1,80€ / 4,15€"
            sortOrder = 1
        case let str where str.lowercased().contains("kasvislounas"):
            price = restaurant == Restaurant.Minerva ? "3,06€ / 6,10€" : "3,06€ / 5,36€"
            sortOrder = 2
        case let str where str.lowercased().contains("lounas"):
            price = restaurant == Restaurant.Minerva ? "3,06€ / 6,10€" : "3,06€ / 5,36€"
            sortOrder = 3
        case let str where str.lowercased().contains("salaattibuffet"):
            price = restaurant == Restaurant.Minerva ? "3,75€ / 6,50€" : "1,80€ / 4,15€"
            sortOrder = 4
        case let str where str.lowercased().contains("bistro"):
            price = restaurant == Restaurant.Minerva ? "4,95€ / 7,75€" : "1,80€ / 4,15€"
            sortOrder = 5
        case let str where str.lowercased().contains("proteiiniosa"):
            price = restaurant == Restaurant.Minerva ? "1,20€ / 2,20€" : "1,80€ / 4,01€"
            sortOrder = 6
        case let str where str.lowercased().contains("jälkiruoka"):
            price = restaurant == Restaurant.Minerva ? "1,20€ / 2,20€" : "1,80€ / 4,15€"
            sortOrder = 10
        default:
            price = "-€"
            sortOrder = 99
        }
        return (price, sortOrder)
    }
    
    class func generateFazerMeal(components: [String], price: String, order: Int) -> Meal {
        
        switch components.count {
        case 0:
            
            var title = ""
            
            switch (order){
            case 1:
                title = "Kasviskeitto"
            case 2:
                title = "Kasvislounas"
            case 3:
                title = "Lounas"
            case 4:
                title = "Salaattibuffet"
            case 5:
                title = "Bistro"
            case 6:
                title = "Jälkiruoka"
            default:
                title = "Tietoja ei saatavilla"
            }

            return Meal(order, price, [title])
        default:
            let title = cleanMinerva(fullName: components[0])
            
            var componentList: [String] = []
            for component in components {
                componentList.append(cleanMinerva(fullName: component))
            }
            
            return Meal(order, price, componentList)
        }
        
    }
    
    class func cleanMinerva(fullName:String) -> String{
        let strArray = fullName.components(separatedBy: "(")
        return strArray[0]
    }

    class func extractFazerMenus(menusForDays: [MenusForDay]) -> [SetMenu]{
        var arr: [SetMenu] = []
        for menu in menusForDays{
            if(compareDateToToday(menu.date)){
                arr = menu.setMenus
            }
        }
        return arr
    }
    
    // MARK: Sodexo
    
    class func parseSodexoPrices(_ prices:String) -> String {
        let strArray = prices.components(separatedBy: "/")
        return "\(strArray[0].components(separatedBy: " ")[0])€ / \(strArray[1].components(separatedBy: " ")[1])€"
    }
    
    // MARK: Juvenes
    class func extractJuvenesMeals(_ days: [Day]) throws -> [Mealoption] {
        let currentDateWithDashes = GetCurrentDate()
        let currentDate = currentDateWithDashes.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        for day in days {
            if let date = day.date {
                if String(date) == currentDate{
                    if let mealOptions = day.mealoptions{
                        return mealOptions
                    }
                }
            }
        }
    
        // If no correct date and/or meal option is found, throw an error.
        throw RestaurantParseError.noDateFound
    }
    
    class func generateJuvenesMeal(name: Name, orderNumber: Int, menuItems:[MenuItem], restaurantType: Restaurant) throws -> Meal{
        
        // Different Juvenes restaurants have different lunch prices.
        var lunchPrice = ""
        switch restaurantType {
        case .YliopistonRavintola:
            lunchPrice = "3,06€ / 5,70€"
        case .Newton:
            lunchPrice = "3,06€ / 5,93€"
        case .Arvo:
            lunchPrice = "3,06€ / 5,70€"
        default:
            lunchPrice = "-€"
        }
        
        
        var price = ""
        switch name {
        case .aamiainen:
            price = "2,95€"
        case .lounasI, .lounasIi, .lounasKasvis:
            price = lunchPrice
        default:
            price = "-€"
        }
        
        switch menuItems.count {
        case 0:
            var title = ""
            switch name {
            case .aamiainen:
                title = "Aamiainen"
            case .lounasI, .lounasIi:
                title = "Lounas"
            case .lounasKasvis:
                title = "Kasvislounas"
            case .pizza:
                title = "Pizza"
            case .salaatti:
                title = "Salaatti"
            case .välipala:
                title = "Välipala"
            }
            return Meal(orderNumber, price, [title])
        default:
            var components: [String] = []
            for menuItem in menuItems {
                guard let component = menuItem.name else {
                    throw RestaurantParseError.invalidInfo
                }
                components.append(component)
            }
            return Meal(orderNumber, price, components)
        }
    }
    
    // MARK: Finn-Medi
    
    class func extractFinnMediMeals(_ days: [FinnMediDay]) throws -> [FinnMediMealoption] {
        let currentDateWithDashes = GetCurrentDate()
        let currentDate = currentDateWithDashes.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        for day in days {
            if let date = day.date {
                if String(date) == currentDate{
                    if let mealOptions = day.mealoptions{
                        return mealOptions
                    }
                }
            }
        }
    
        // If no correct date and/or meal option is found, throw an error.
        throw RestaurantParseError.noDateFound
    }
    
    class func generateFinnMediMeal(name: String, orderNumber: Int, menuItems:[FinnMediMenuItem], restaurantType: Restaurant) throws -> Meal{
        
        var price = ""
        switch name {
        case "Keittolounas":
            price = "6,30€"
        case "Lounas OP":
            price = "3,05€ / 9,50€"
        case "Jälkiruoka":
            price = "1,50€"
        default:
            price = "-€"
        }
        
        switch menuItems.count {
        case 0:
            return Meal(orderNumber, price, [name])
        default:
            guard let title = menuItems[0].name else {
                throw RestaurantParseError.invalidInfo
            }

            var components: [String] = []
            for menuItem in menuItems {
                guard let component = menuItem.name else {
                    throw RestaurantParseError.invalidInfo
                }
                components.append(component)
            }
            return Meal(orderNumber, price, components)
        }
    }
    
}

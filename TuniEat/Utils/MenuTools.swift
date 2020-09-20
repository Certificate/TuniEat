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
    
    // MARK: Minerva
    
    // It ain't pretty but it works
    class func parseMinervaPricesAndOrder(mealName:String) -> (String, Int){
        var price = ""
        var sortOrder = 0
        
        if (mealName.lowercased().contains("bistro")){
            price = "4,95€ / 7,75€"
            sortOrder = 5
        }
        
        if (mealName.lowercased().contains("kasvislounas")){
            price = "2,60€ / 6,00€"
            sortOrder = 2
        }
        
        if (mealName.lowercased().contains("kasviskeitto")){
            price = "2,27€ / 4,80€"
            sortOrder = 1
        }
        
        if (mealName.lowercased().contains("lounas")){
            price = "2,60€ / 6,00€"
            sortOrder = 3
        }
        
        if (mealName.lowercased().contains("salaattibuffet")){
            price = "3,75€ / 6,50€"
            sortOrder = 4
        }
        
        if (mealName.lowercased().contains("jälkiruoka")){
            price = "1,05€ / 1,95€"
            sortOrder = 6
        }
        
        return (price, sortOrder)
    }
    
    class func generateMinervaMeal(components: [String], price: String, order: Int) -> Meal {
        
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

            return Meal(order, title, price)
        case 2:
            let title = cleanMinerva(fullName: components[0])
            let component1 = cleanMinerva(fullName: components[1])
            return Meal(order, title, price, comp1: component1)
        case 3:
            let title = cleanMinerva(fullName: components[0])
            let component1 = cleanMinerva(fullName: components[1])
            let component2 = cleanMinerva(fullName: components[2])
            return Meal(order,title, price, comp1: component1, comp2: component2)
        case 4:
            let title = cleanMinerva(fullName: components[0])
            let component1 = cleanMinerva(fullName: components[1])
            let component2 = cleanMinerva(fullName: components[2])
            let component3 = cleanMinerva(fullName: components[3])
            return Meal(order,title, price, comp1: component1, comp2: component2, comp3: component3)
        default:
            let title = cleanMinerva(fullName: components[0])
            return Meal(order,title, price)
        }
        
    }
    
    class func cleanMinerva(fullName:String) -> String{
        let strArray = fullName.components(separatedBy: "(")
        return strArray[0]
    }

    class func extractMinervaMenus(menusForDays: [MenusForDay]) -> [SetMenu]{
        var arr: [SetMenu] = []
        for menu in menusForDays{
            if(compareDateToToday(menu.date)){
                arr = menu.setMenus
            }
        }
        return arr
    }
    
    // MARK: Linna
    
    // MARK: Juvenes
    class func extractJuvenesMeals(_ days: [Day]) throws -> [MealOption] {
        let currentDateWithDashes = GetCurrentDate()
        let currentDate = "20200921"//currentDateWithDashes.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
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
    
    class func generateJuvenesMeal(name: Name, orderNumber: Int, menuItems:[MenuItem]) throws -> Meal{
        
        var price = ""
        switch name {
        case .aamiainen:
            price = "2,95€"
        case .lounasI:
            price = "3,06€ / 5,70€ / 7,35€"
        case .lounasIi:
            price = "3,06€ / 5,70€ / 7,35€"
        case .lounasKasvis:
            price = "3,06€ / 5,70€ / 7,35€"
        }
        
        switch menuItems.count {
        case 1:
            if let title = menuItems[0].name {
                return Meal(orderNumber, title, price)
            }
        case 2:
            
            guard let title = menuItems[0].name else {
                throw RestaurantParseError.invalidInfo
            }
            
            guard let component1 = menuItems[1].name else {
                throw RestaurantParseError.invalidInfo
            }

            return Meal(orderNumber, title, price, comp1: component1)
            
        case 3:
            guard let title = menuItems[0].name else {
                throw RestaurantParseError.invalidInfo
            }
            
            guard let component1 = menuItems[1].name else {
                throw RestaurantParseError.invalidInfo
            }
            
            guard let component2 = menuItems[2].name else {
                throw RestaurantParseError.invalidInfo
            }
            
            return Meal(orderNumber, title, price, comp1: component1, comp2: component2)
        case 4:
            guard let title = menuItems[0].name else {
                throw RestaurantParseError.invalidInfo
            }
            
            guard let component1 = menuItems[1].name else {
                throw RestaurantParseError.invalidInfo
            }
            
            guard let component2 = menuItems[2].name else {
                throw RestaurantParseError.invalidInfo
            }
            
            guard let component3 = menuItems[3].name else {
                throw RestaurantParseError.invalidInfo
            }
            
            return Meal(orderNumber, title, price, comp1: component1, comp2: component2, comp3: component3)
        default:
            
            var title = ""
            switch name {
            case .aamiainen:
                title = "Aamiainen"
            case .lounasI:
                title = "Lounas"
            case .lounasIi:
                title = "Lounas"
            case .lounasKasvis:
                title = "Kasvislounas"
            }
            return Meal(orderNumber, title, price)
        }
        
        return Meal(orderNumber, "Tietojen hakemisessa häikkää", "")
    }
    
}

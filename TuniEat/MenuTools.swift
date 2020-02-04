//
//  MenuTools.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 4.2.2020.
//  Copyright © 2020 Valtteri Vuori. All rights reserved.
//

import Foundation

class MenuTools{
    
    // It ain't pretty but it works
    class func parseMinervaPricesAndOrder(mealName:String) -> (String, Int){
        var price = ""
        var sortOrder = 0
        
        if (mealName.contains("BISTRO")){
            price = "4,95€ / 7,75€"
            sortOrder = 5
        }
        
        if (mealName.contains("Kasvislounas")){
            price = "2,60€ / 6,00€"
            sortOrder = 2
        }
        
        if (mealName.contains("Kasviskeitto")){
            price = "2,27€ / 4,80€"
            sortOrder = 1
        }
        
        if (mealName.contains("Lounas")){
            price = "2,60€ / 6,00€"
            sortOrder = 3
        }
        
        if (mealName.contains("Fresh salaattibuffet")){
            price = "3,75€ / 6,50€"
            sortOrder = 4
        }
        
        if (mealName.contains("Jälkiruoka")){
            price = "1,05€ / 1,95€"
            sortOrder = 6
        }
        
        return (price, sortOrder)
    }
    
    class func generateMinervaMeal(components: [String], price: String, order: Int) -> Meal {
        
        switch components.count {
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
    
}

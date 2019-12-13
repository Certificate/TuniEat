//
//  MenuDownloader.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import Foundation

class MenuDownloader{
    
    let LinnaMenuAddress = "https://www.sodexo.fi/ruokalistat/output/daily_json/116/"
    let MinervaMenuJSON = "https://www.fazerfoodco.fi/modules/json/json/Index?costNumber=0815&language=fi"
    
    func GetCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: Date())
        return result
    }
    
    func GetMenu(_ restaurantName: String, finished: @escaping(_ mealList: [Meal]) -> Void){
        switch restaurantName {
        case "Linna":
            let address = LinnaMenuAddress + GetCurrentDate()
            print("Starting menu download process for \(restaurantName)!")
            print("Trying to download orders from \(address)")
            
            if let url = URL(string: address) {
               let task = URLSession.shared.dataTask(with: url) { data, response, error in
                  if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        var meals: [Meal] = []
                        let linnaMenus = try jsonDecoder.decode(LinnaMenu.self, from: data)
                        
                        for menu in linnaMenus.courses{
                            meals.append(Meal(menu.value.titleEn, menu.value.price))
                        }
                        print("Order download successful")
                        finished(meals)
                    } catch {
                        print(error)
                    }
                    
                   }
               }
               task.resume()
            }
        default:
            print("No such restaurant in knowledgebase. Aborting.")
        }
    }
    

    
}



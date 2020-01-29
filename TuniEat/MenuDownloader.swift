//
//  MenuDownloader.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import Foundation

protocol MenuDownloaderDelegate: AnyObject {
    func didFinishLinnaDownload(sender: MenuDownloader)
    
    func didFinishMinervaDownload(sender: MenuDownloader)
}

class MenuDownloader{
    
    weak var delegate:MenuDownloaderDelegate?
    
    let LinnaMenuJSON = "https://www.sodexo.fi/ruokalistat/output/daily_json/116/"
    let MinervaMenuJSON = "https://www.fazerfoodco.fi/modules/json/json/Index?costNumber=0815&language=fi"
    
    var linnaMenu: [Meal] = []
    var minervaMenu: [Meal] = []
    
    func DownloadMenus(){
        self.GetMenu("Minerva", MinervaMenuJSON, finished: { mealList in
            print("Got \(mealList.count) of Minerva meals.")
            self.minervaMenu = mealList
            print("[Delegate]: Minerva menu ready.")
            self.delegate?.didFinishMinervaDownload(sender: self)
        })
        
        self.GetMenu("Linna", LinnaMenuJSON, finished: { mealList in
            print("Got \(mealList.count) of Linna meals.")
            
            self.linnaMenu = mealList
            print("[Delegate]: Linna menu ready.")
            self.delegate?.didFinishLinnaDownload(sender: self)
        })
        
    }
    
    func GetCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: Date())
        return result
    }
    
    private func GetMenu(_ RestaurantName: String, _ requestURL: String, finished: @escaping(_ mealList: [Meal]) -> Void){
        
        let address = RestaurantName == "Linna" ? requestURL + GetCurrentDate() : requestURL
        
        print("Downloading menu from \(address)")
        
        if let url = URL(string: address) {
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                print("\(RestaurantName) order download successful. Starting parse.")
                let jsonDecoder = JSONDecoder()
                do {
                    var meals: [Meal] = []
                    
                    switch RestaurantName {
                    case "Linna":
                        let linnaMenus = try jsonDecoder.decode(LinnaMenu.self, from: data)
                        
                        for menu in linnaMenus.courses{
                            // Sometimes an empty meal is presented. Only let through values with real data.
                            if(!menu.value.titleEn.isEmpty && !menu.value.price.isEmpty){
                                meals.append(Meal(menu.value.titleFi, menu.value.price))
                            }
                        }
                    case "Minerva":
                        let minervaMenus = try jsonDecoder.decode(MinervaMenu.self, from: data)
                        let minervaTodaysMenus = self.extractMenus(menusForDays: minervaMenus.menusForDays)
                        
                        for menu in minervaTodaysMenus{
                            let price = self.parseMinervaPrices(mealName: menu.name)
                            meals.append(self.generateMinervaMeal(components: menu.components, price: price))
                        }
                    default:
                        print("No such restaurant found.")
                    }

                    finished(meals)
                } catch {
                    print(error)
                }
                
               }
           }
           task.resume()
        }
    }
    
    // It ain't pretty but it works
    private func parseMinervaPrices(mealName:String) -> String{
        var price = ""
        
        if (mealName.contains("BISTRO")){
            price = "4,95€ / 7,75€"
        }
        
        if (mealName.contains("Kasvislounas") || mealName.contains("Lounas")){
            price = "2,60€ / 6,00€"
        }
        
        if (mealName.contains("Kasviskeitto")){
            price = "2,27€ / 4,80€"
        }
        
        if (mealName.contains("Kasviskeitto")){
            price = "2,27€ / 4,80€"
        }
        
        if (mealName.contains("Fresh salaattibuffet")){
            price = "3,75€ / 6,50€"
        }
        
        if (mealName.contains("Jälkiruoka")){
            price = "1,05€ / 1,95€"
        }
        
        return price
    }
    
    private func generateMinervaMeal(components: [String], price: String) -> Meal {
        
        switch components.count {
        case 2:
            let title = cleanMinerva(fullName: components[0])
            let component1 = cleanMinerva(fullName: components[1])
            return Meal(title, price, comp1: component1)
        case 3:
            let title = cleanMinerva(fullName: components[0])
            let component1 = cleanMinerva(fullName: components[1])
            let component2 = cleanMinerva(fullName: components[2])
            return Meal(title, price, comp1: component1, comp2: component2)
        case 4:
            let title = cleanMinerva(fullName: components[0])
            let component1 = cleanMinerva(fullName: components[1])
            let component2 = cleanMinerva(fullName: components[2])
            let component3 = cleanMinerva(fullName: components[3])
            return Meal(title, price, comp1: component1, comp2: component2, comp3: component3)
        default:
            let title = cleanMinerva(fullName: components[0])
            return Meal(title, price)
        }
        
    }
    
    private func cleanMinerva(fullName:String) -> String{
        let strArray = fullName.components(separatedBy: "(")
        return strArray[0]
    }
    
    private func extractMenus(menusForDays: [MenusForDay]) -> [SetMenu]{
        var arr: [SetMenu] = []
        for menu in menusForDays{
            if(compareDateToToday(menu.date)){
                arr = menu.setMenus
            }
        }
        return arr
    }
    
    private func compareDateToToday(_ strDate: String) -> Bool{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:strDate)!
        
        // Date -> String
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        
        // Compare today's date and recently converted date in "yyyy-MM-dd" format
        return GetCurrentDate() == result
    }
    

    
}

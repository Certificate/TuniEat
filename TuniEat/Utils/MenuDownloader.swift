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
    
    func didFinishJuvenesDownload(sender: MenuDownloader)
}

enum Restaurant {
    // City centre campus
    case YliopistonRavintola
    case Linna
    case Minerva

    // Hervanta campuis
    case Reaktori
    case Newton
    case Hertsi

    // TAYS
    case Arvo
}

class MenuDownloader{
    weak var delegate:MenuDownloaderDelegate?
    let restaurantParser = RestaurantParser()
    

    var linnaMenu: [Meal] = []
    var juvenesMenu: [Meal] = []
    var minervaMenu: [Meal] = []
    
    func DownloadMenus(){
        
        print("Downloading new menus!")
        
        self.GetMenu(.Minerva, URLStorage.getRestaurantUrl(.Minerva), finished: { mealList in
            print("Got \(mealList.count) of Minerva meals.")
            self.minervaMenu = mealList
            self.minervaMenu.sort(by: { $0.sortOrder < $1.sortOrder })
            print("[Delegate]: Minerva menu ready.")
            self.delegate?.didFinishMinervaDownload(sender: self)
        })
        
        self.GetMenu(.Linna, URLStorage.getRestaurantUrl(.Linna), finished: { mealList in
            print("Got \(mealList.count) of Linna meals.")
            self.linnaMenu = mealList
            self.linnaMenu.sort(by: { $0.sortOrder < $1.sortOrder })
            print("[Delegate]: Linna menu ready.")
            self.delegate?.didFinishLinnaDownload(sender: self)
        })
        
        self.GetMenu(.YliopistonRavintola, JuvenesUrlGenerator.GenerateUrl(.YliopistonRavintola), finished: { mealList in
            print("Got \(mealList.count) of Juvenes meals.")
            self.juvenesMenu = mealList
            self.juvenesMenu.sort(by: { $0.sortOrder < $1.sortOrder })
            print("[Delegate]: Juvenes menu ready.")
            self.delegate?.didFinishJuvenesDownload(sender: self)
        })

    }
    
    private func GetMenu(_ RestaurantName: Restaurant, _ requestURL: String, finished: @escaping(_ mealList: [Meal]) -> Void){
        
        print("Downloading menu from \(requestURL)")
        if let url = URL(string: requestURL) {
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                print("\(RestaurantName) order download successful. Starting parse.")

                do {
                    var meals: [Meal] = []
                    
                    switch RestaurantName {
                    case .YliopistonRavintola:
                        meals = self.restaurantParser.parseYliopistonRavintola(data)
                    case .Linna:
                        meals = self.restaurantParser.parseLinna(data)
                    case .Minerva:
                        meals = self.restaurantParser.parseMinerva(data)
                    default:
                        print("No such restaurant found.")
                    }

                    finished(meals)
                } catch {
                    print("Error parsing \(RestaurantName) meals: \(error)")
                }
                
               }
           }
           task.resume()
        }
    }

    

    
}

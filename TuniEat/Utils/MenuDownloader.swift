//
//  MenuDownloader.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import Foundation

protocol CityCentreMenuDownloaderDelegate: AnyObject {
    // City Centre
    func didFinishLinnaDownload(sender: CityCentreMenuDownloader)
    func didFinishMinervaDownload(sender: CityCentreMenuDownloader)
    func didFinishJuvenesDownload(sender: CityCentreMenuDownloader)
}

protocol HervantaMenuDownloaderDelegate: AnyObject {
    
    // Hervanta
    func didFinishHertsiDownload(sender: HervantaMenuDownloader)
    func didFinishReaktoriDownload(sender: HervantaMenuDownloader)
    func didFinishNewtonDownload(sender: HervantaMenuDownloader)
}

protocol TAYSMenuDownloaderDelegate: AnyObject {
    
    // Hervanta
    func didFinishArvoDownload(sender: TAYSMenuDownloader)
    func didFinishFinnMediDownload(sender: TAYSMenuDownloader)
}

enum Restaurant {
    // City centre campus
    case YliopistonRavintola
    case Linna
    case Minerva

    // Hervanta campus
    case Reaktori
    case Newton
    case Hertsi

    // TAYS
    case Arvo
    case FinnMedi
}

class CityCentreMenuDownloader{
    weak var delegate:CityCentreMenuDownloaderDelegate?
    
    let restaurantParser = RestaurantParser()
    

    // City Centre
    var linnaMenu: [Meal] = []
    var juvenesMenu: [Meal] = []
    var minervaMenu: [Meal] = []
    
    func DownloadCityCentreMenus(){
        
        print("Downloading City Centre menus!")
        
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
            print("Got \(mealList.count) of Yliopiston Ravintola meals.")
            self.juvenesMenu = mealList
            self.juvenesMenu.sort(by: { $0.sortOrder < $1.sortOrder })
            print("[Delegate]: Yliopiston Ravintola menu ready.")
            self.delegate?.didFinishJuvenesDownload(sender: self)
        })

    }
    
    private func GetMenu(_ RestaurantName: Restaurant, _ requestURL: String, finished: @escaping(_ mealList: [Meal]) -> Void){
        
        print("Downloading menu from \(requestURL)")
        if let url = URL(string: requestURL) {
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                print("\(RestaurantName) order download successful. Starting parse.")

                var meals: [Meal] = []
                
                switch RestaurantName {
                case .YliopistonRavintola:
                    meals = self.restaurantParser.parseJuvenes(data, .YliopistonRavintola)
                case .Linna:
                    meals = self.restaurantParser.parseSodexo(data, .Linna)
                case .Minerva:
                    meals = self.restaurantParser.parseFazer(data, .Minerva)
                default:
                    print("No such restaurant found.")
                }

                finished(meals)

               }
           }
           task.resume()
        }
    }

    

    
}

class HervantaMenuDownloader{
    weak var delegate:HervantaMenuDownloaderDelegate?
    
    let restaurantParser = RestaurantParser()

    
    // Hervanta
    var hertsiMenu: [Meal] = []
    var newtonMenu: [Meal] = []
    var reaktoriMenu: [Meal] = []
    
    func DownloadHervantaMenus(){
        
        print("Downloading Hervanta menus!")
        
        self.GetMenu(.Hertsi, URLStorage.getRestaurantUrl(.Hertsi), finished: { mealList in
            print("Got \(mealList.count) of Hertsi meals.")
            self.hertsiMenu = mealList
            self.hertsiMenu.sort(by: { $0.sortOrder < $1.sortOrder })
            print("[Delegate]: Hertsi menu ready.")
            self.delegate?.didFinishHertsiDownload(sender: self)
        })
        
        self.GetMenu(.Newton, URLStorage.getRestaurantUrl(.Newton), finished: { mealList in
            print("Got \(mealList.count) of Newton meals.")
            self.newtonMenu = mealList
            self.newtonMenu.sort(by: { $0.sortOrder < $1.sortOrder })
            print("[Delegate]: Newton menu ready.")
            self.delegate?.didFinishNewtonDownload(sender: self)
        })
        
        self.GetMenu(.Reaktori, URLStorage.getRestaurantUrl(.Reaktori), finished: { mealList in
            print("Got \(mealList.count) of Reaktori meals.")
            self.reaktoriMenu = mealList
            self.reaktoriMenu.sort(by: { $0.sortOrder < $1.sortOrder })
            print("[Delegate]: Reaktori menu ready.")
            self.delegate?.didFinishReaktoriDownload(sender: self)
        })

    }
    
    private func GetMenu(_ RestaurantName: Restaurant, _ requestURL: String, finished: @escaping(_ mealList: [Meal]) -> Void){
        
        print("Downloading menu from \(requestURL)")
        if let url = URL(string: requestURL) {
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                print("\(RestaurantName) order download successful. Starting parse.")

                var meals: [Meal] = []
                
                switch RestaurantName {
                case .Newton:
                    meals = self.restaurantParser.parseJuvenes(data, .Newton)
                case .Hertsi:
                    meals = self.restaurantParser.parseSodexo(data, .Hertsi)
                case .Reaktori:
                    meals = self.restaurantParser.parseFazer(data, .Reaktori)
                default:
                    print("No such restaurant found.")
                }

                finished(meals)

               }
           }
           task.resume()
        }
    }
}

class TAYSMenuDownloader{
    weak var delegate:TAYSMenuDownloaderDelegate?
    
    let restaurantParser = RestaurantParser()

    
    // TAYS
    var finnMediMenu: [Meal] = []
    var arvoMenu: [Meal] = []
    
    func DownloadTAYSMenus(){
        
        print("Downloading TAYS menus!")
        
        self.GetMenu(.FinnMedi, URLStorage.getRestaurantUrl(.FinnMedi), finished: { mealList in
            print("Got \(mealList.count) of Finn-Medi meals.")
            self.finnMediMenu = mealList
            self.finnMediMenu.sort(by: { $0.sortOrder < $1.sortOrder })
            print("[Delegate]: Finn-Medi menu ready.")
            self.delegate?.didFinishFinnMediDownload(sender: self)
        })
        
        self.GetMenu(.Arvo, URLStorage.getRestaurantUrl(.Arvo), finished: { mealList in
            print("Got \(mealList.count) of Arvo meals.")
            self.arvoMenu = mealList
            self.arvoMenu.sort(by: { $0.sortOrder < $1.sortOrder })
            print("[Delegate]: Arvo menu ready.")
            self.delegate?.didFinishArvoDownload(sender: self)
        })
        
    }
    
    private func GetMenu(_ RestaurantName: Restaurant, _ requestURL: String, finished: @escaping(_ mealList: [Meal]) -> Void){
        
        print("Downloading menu from \(requestURL)")
        if let url = URL(string: requestURL) {
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                print("\(RestaurantName) order download successful. Starting parse.")

                var meals: [Meal] = []
                
                switch RestaurantName {
                case .Arvo:
                    meals = self.restaurantParser.parseJuvenes(data, .Arvo)
                case .FinnMedi:
                    meals = self.restaurantParser.parseJuvenes(data, .FinnMedi)
                default:
                    print("No such restaurant found.")
                }

                finished(meals)

               }
           }
           task.resume()
        }
    }
}

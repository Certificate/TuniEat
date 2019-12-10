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
    
    func GetMenu(_ restaurantName: String){
        switch restaurantName {
        case "Linna":
            let address = LinnaMenuAddress + GetCurrentDate()
            print("Starting menu download process for \(restaurantName)!")
            print("Trying to download orders from \(address)")
            
            
            if let url = URL(string: address) {
               URLSession.shared.dataTask(with: url) { data, response, error in
                  if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let parsedJSON = try jsonDecoder.decode(LinnaMenu.self, from: data)
                        print(parsedJSON)
                    } catch {
                        print(error)
                    }
                    
                   }
               }.resume()
            }
        default:
            print("No such restaurant in knowledgebase. Aborting.")
        }
        
        
    }
    
    func GetCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: Date())
        return result
    }
    
}



//
// Created by Valtteri Vuori on 20.9.2020.
// Copyright (c) 2020 Valtteri Vuori. All rights reserved.
//

import Foundation

class URLStorage {

    class func getRestaurantUrl(_ restaurant: Restaurant) -> String{

        switch restaurant{
        case .YliopistonRavintola:
            return JuvenesUrlGenerator.GenerateUrl(.YliopistonRavintola)
        case .Linna:
            return "https://www.sodexo.fi/ruokalistat/output/daily_json/116/" + MenuTools.GetCurrentDate()
        case .Minerva:
            return "https://www.fazerfoodco.fi/modules/json/json/Index?costNumber=0815&language=fi"
        case .Reaktori:
            return ""
        case .Newton:
            return ""
        case .Hertsi:
            return ""
        case .Arvo:
            return ""
        }
    }

}

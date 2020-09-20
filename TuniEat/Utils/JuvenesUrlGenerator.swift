//
//  JuvenesUrlGenerator.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 17.3.2020.
//  Copyright © 2020 Valtteri Vuori. All rights reserved.
//

import Foundation

class JuvenesUrlGenerator{
    
    private enum JuvenesKitchenID: Int{
        case YliopistonRavintola = 13
        case Newton = 6
        case Arvo = 5
        case Unknown = -1
    }
    
    class func GenerateUrl(_ restaurant: Restaurant) -> String {
        
        let kitchen = getKitchenId(restaurant)
    
        return "http://fi.jamix.cloud/apps/menuservice/rest/haku/menu/12347/\(kitchen.rawValue)?lang=fi"
    }
    
    private class func getKitchenId(_ restaurant: Restaurant) -> JuvenesKitchenID {
        switch restaurant {
        case .YliopistonRavintola:
            return JuvenesKitchenID.YliopistonRavintola
        case .Newton:
            return JuvenesKitchenID.Newton
        case .Arvo:
            return JuvenesKitchenID.Arvo
        default:
            return JuvenesKitchenID.Unknown
        }
    }
}

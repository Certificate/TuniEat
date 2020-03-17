//
//  JuvenesUrlGenerator.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 17.3.2020.
//  Copyright © 2020 Valtteri Vuori. All rights reserved.
//

import Foundation

class JuvenesUrlGenerator{
        
    enum Kitchen {
        case YliopistonRavintola
    }
    
    let MenuType = 60
    let JuvenesBaseUrl = "https://www.juvenes.fi/DesktopModules/Talents.LunchMenu/LunchMenuServices.asmx/GetMenuByWeekday?"
    
    func GenerateUrl(_ kitchen: Kitchen) -> String {
        let week = NSCalendar.current.component(.weekOfYear, from: Date())
        let weekday = getDayOfWeek(MenuTools.GetCurrentDate()) ?? 0
        
        return JuvenesBaseUrl + "KitchenId=\(GetKitchenId(kitchen))&MenuTypeId=\(MenuType)&Week=\(week)&Weekday=\(weekday)&lang=fi"
    }

    private func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay - 1
    }
    
    private func GetKitchenId(_ kitchen: Kitchen) -> Int {
        switch(kitchen){
        case .YliopistonRavintola:
            return 13
        default:
            return 0
        }
    }
}

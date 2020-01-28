//
//  MenuViewModel.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import UIKit
import os.log


class Meal: NSObject {
    
    //MARK: Properties
    var title: String
    var price: String
    var component1: String
    var component2: String
    
    init(_ name: String, _ price: String, comp1: String = "", comp2: String = "") {
        
        // Initialize stored properties.
        self.title = name
        self.price = price
        self.component1 = comp1
        self.component2 = comp2
        
    }
    
}

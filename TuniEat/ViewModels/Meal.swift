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
    var name: String
    var price: String
    
    
    init(_ name: String, _ price: String) {
        
        // Initialize stored properties.
        self.name = name
        self.price = price
        
    }
    
}

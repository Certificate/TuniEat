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
    var price: String
    var components: [String]
    var sortOrder: Int
    
    init(_ sortOrder: Int,_ price: String,_ components: [String] = []) {
        
        // Initialize stored properties.
        self.sortOrder = sortOrder
        self.price = price
        self.components = components
        
    }
    
}

//
//  CustomTabBarController.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import UIKit

class CustomTabBarController : UITabBarController{
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Switching!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Centrum"
        
        let centrum = CentrumViewController()
        centrum.title = "Centrum"
        centrum.navigationItem.title = "Centrum"
        centrum.tabBarItem.image = UIImage(named: "Banner")
        
        let hervanta = HervantaViewController()
        hervanta.title = "Hervanta"
        hervanta.tabBarItem.image = UIImage(named: "Hervanta")
        
        let tays = TAYSViewController()
        tays.title = "TAYS"
        tays.tabBarItem.image = UIImage(named: "Hospital")
        
        viewControllers = [centrum, hervanta, tays]
        
    }
}

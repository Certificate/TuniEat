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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Since we launch into Centrum, default title to that as well.
        self.navigationItem.title = "Keskustakampus"
        
        let centrum = CentrumViewController()
        centrum.title = "Keskustakampus"
        centrum.tabBarItem.image = UIImage(named: "Banner")
        
        let hervanta = HervantaViewController()
        hervanta.title = "Hervanta"
        hervanta.tabBarItem.image = UIImage(named: "Hervanta")
        
        let tays = TAYSViewController()
        tays.title = "TAYS"
        tays.tabBarItem.image = UIImage(named: "Hospital")
        
        viewControllers = [centrum, hervanta, tays]
        
    }
    
    // Change navigationcontroller title according to chosen tab
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title {
        case "Keskustakampus":
            self.navigationItem.title = "Keskustakampus"
        case "Hervanta":
            self.navigationItem.title = "Hervanta"
        case "TAYS":
            self.navigationItem.title = "TAYS"
        default:
            self.navigationItem.title = "What the..."
        }
    }
}

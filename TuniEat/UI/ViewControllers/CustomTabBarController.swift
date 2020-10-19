//
//  CustomTabBarController.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import UIKit

class CustomTabBarController : UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the settings button
        let barButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(setFavouriteLocation))
        if #available(iOS 13.0, *) {
            let settingsIcon = UIImage(systemName: "gearshape")
            barButtonItem.image = settingsIcon
        } else {
            let settingsIcon = UIImage(named: "SettingsWhite")
            barButtonItem.image = settingsIcon
        }
        navigationItem.rightBarButtonItem = barButtonItem
        
        // Setup viewcontrollers for tabs
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
    
    // Change navigation controller title according to chosen tab
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
    
//    @objc func setFavouriteLocation() {
//        // Set default landing page
//
//    }
    
    @objc func setFavouriteLocation(sender: AnyObject) {
        let defaults = UserDefaults.standard
        
        var current: String
        
        if let chosen = defaults.string(forKey: defaultsKeys.location){
            current = "Nykyinen valinta: \(chosen)"
        } else {
            current = "Sijaintia ei ole vielä valittu. Oletussijainti on Keskustakampus."
        }
        
        let alert = UIAlertController(title: "Aloitussivu", message: "Valitse lempisijaintisi listasta. Sovellus aukeaa tähän näkymään jatkossa. \(current)", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Keskustakampus", style: .default , handler:{ (UIAlertAction)in
            defaults.set(location.CityCentre, forKey: defaultsKeys.location)
        }))

        alert.addAction(UIAlertAction(title: "Hervanta", style: .default , handler:{ (UIAlertAction)in
            defaults.set(location.Hervanta, forKey: defaultsKeys.location)
        }))

        alert.addAction(UIAlertAction(title: "TAYS", style: .default , handler:{ (UIAlertAction)in
            defaults.set(location.TAYS, forKey: defaultsKeys.location)
        }))

        alert.addAction(UIAlertAction(title: "Peruuta", style: .cancel, handler:{ (UIAlertAction)in
        }))

        self.present(alert, animated: true, completion: {})
    }
}

struct defaultsKeys {
    static let location = "location"
}

struct location {
    static let CityCentre = "Keskustakampus"
    static let Hervanta = "Hervanta"
    static let TAYS = "TAYS"
}

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
        centrum.title = NSLocalizedString("CityCentre", comment: "")
        centrum.tabBarItem.image = UIImage(named: "Banner")
        
        let hervanta = HervantaViewController()
        hervanta.title = NSLocalizedString("Hervanta", comment: "")
        hervanta.tabBarItem.image = UIImage(named: "Hervanta")
        
        let tays = TAYSViewController()
        tays.title = NSLocalizedString("TAYS", comment: "")
        tays.tabBarItem.image = UIImage(named: "Hospital")
        
        viewControllers = [centrum, hervanta, tays]
    }
    
    // Change navigation controller title according to chosen tab
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title {
        case "Keskustakampus":
            self.navigationItem.title = NSLocalizedString("CityCentre", comment: "")
        case "Hervanta":
            self.navigationItem.title = NSLocalizedString("Hervanta", comment: "")
        case "TAYS":
            self.navigationItem.title = NSLocalizedString("TAYS", comment: "")
        default:
            self.navigationItem.title = "Error"
        }
    }
    
    @objc func setFavouriteLocation(sender: AnyObject) {
        let defaults = UserDefaults.standard
        
        var current: String
        
        if let chosen = defaults.string(forKey: defaultsKeys.location){
            current = NSLocalizedString("CurrentChoice", comment: "") + " \(chosen)"
        } else {
            current = NSLocalizedString("NoLocationSet", comment: "")
        }
        
        let alert = UIAlertController(
            title: "Aloitussivu",
            message: NSLocalizedString("ChooseFavouriteLocation", comment: "") + " \(current)",
            preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: NSLocalizedString("CityCentre", comment: ""), style: .default , handler:{ (UIAlertAction)in
            defaults.set(location.CityCentre, forKey: defaultsKeys.location)
        }))

        alert.addAction(UIAlertAction(title: NSLocalizedString("Hervanta", comment: ""), style: .default , handler:{ (UIAlertAction)in
            defaults.set(location.Hervanta, forKey: defaultsKeys.location)
        }))

        alert.addAction(UIAlertAction(title: NSLocalizedString("TAYS", comment: ""), style: .default , handler:{ (UIAlertAction)in
            defaults.set(location.TAYS, forKey: defaultsKeys.location)
        }))

        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler:{ (UIAlertAction)in
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

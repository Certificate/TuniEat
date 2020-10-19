//
//  AppDelegate.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let customTabBar = CustomTabBarController()
        UITabBar.appearance().tintColor = UIColor(named: "MainColor")
        let nav = UINavigationController(rootViewController: customTabBar)
        
        if #available(iOS 11.0, *) {
          nav.navigationBar.prefersLargeTitles = true
        }
        
        window?.rootViewController = nav
        
        if let tabBarViewController = nav.topViewController as? UITabBarController {
            setStartingTab(tabBarViewController, nav)
        }
        
        return true
    }
    
    func setStartingTab(_ vc: UITabBarController, _ nav: UINavigationController){

        // Get value from user defaults and select the correct tab and assign the correct title for said tab
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: defaultsKeys.location) {
            switch stringOne {
            case location.Hervanta:
                vc.selectedIndex = 1
                vc.navigationItem.title = "Hervanta"
            case location.TAYS:
                vc.selectedIndex = 2
                nav.navigationItem.title = "TAYS"
            // Also CityCentre
            default:
                vc.selectedIndex = 0
                nav.navigationItem.title = "Keskustakampus"
            }
        }
    }
}


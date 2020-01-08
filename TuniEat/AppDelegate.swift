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
        
        let navbar = setupNavBar()
        let mainView = CustomTabBarController()
        navbar.viewControllers = [mainView]
        
        window?.rootViewController = navbar
        
        // Override point for customization after application launch.
        return true
    }
    
    func setupNavBar() -> UINavigationController{
        let nav = UINavigationController()
        
        if #available(iOS 11.0, *) {
          nav.navigationBar.prefersLargeTitles = true
        }
        return nav
    }
}


//
//  AppDelegate.swift
//  Animation
//
//  Created by Андрей Зорькин on 22/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let secondViewController = FirstViewController()
        
        let itemSnow = UITabBarItem(title: "Снег", image: UIImage(named: "snow"), tag: 1)
        secondViewController.tabBarItem = itemSnow
        
        let tabBarController = TabBarController()
        tabBarController.viewControllers = [secondViewController]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}


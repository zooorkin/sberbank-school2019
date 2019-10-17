//
//  AppDelegate.swift
//  NavigationControllerDelegate
//
//  Created by Андрей Зорькин on 17/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let firstViewController = FirstViewController()
        let secondViewController = SecondViewController()
        
        let navigationViewController = NavigationViewController(rootViewController: firstViewController)
        
        let itemSun = UITabBarItem(title: "Солнце", image: UIImage(named: "sun"), tag: 0)
        navigationViewController.tabBarItem = itemSun

        let itemSnow = UITabBarItem(title: "Снег", image: UIImage(named: "snow"), tag: 1)
        secondViewController.tabBarItem = itemSnow
        
        let tabBarController = TabBarController()
        tabBarController.viewControllers = [navigationViewController, secondViewController]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}


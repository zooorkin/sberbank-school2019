//
//  AppDelegate.swift
//  Comics
//
//  Created by Андрей Зорькин on 29/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            let tabBarController = UITabBarController()
            let firstComicsVC = ComicsViewController()
            firstComicsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
            firstComicsVC.numberOfRows = 2
            firstComicsVC.numberOfColumns = 2
            firstComicsVC.image = UIImage(named: "comics2x2")
            
            let secondComicsVC = ComicsViewController()
            secondComicsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
            secondComicsVC.numberOfRows = 2
            secondComicsVC.numberOfColumns = 3
            secondComicsVC.image = UIImage(named: "comics2x3")
            
            let thirdComicsVC = ComicsViewController()
            thirdComicsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
            thirdComicsVC.numberOfRows = 3
            thirdComicsVC.numberOfColumns = 3
            thirdComicsVC.image = UIImage(named: "comics3x3")
            
            let fourthComicsVC = ComicsViewController()
            fourthComicsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)
            fourthComicsVC.numberOfRows = 5
            fourthComicsVC.numberOfColumns = 4
            fourthComicsVC.image = UIImage(named: "comics5x4")
            
            tabBarController.viewControllers = [firstComicsVC, secondComicsVC,
                                                thirdComicsVC, fourthComicsVC]
            
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


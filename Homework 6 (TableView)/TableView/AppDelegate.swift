//
//  AppDelegate.swift
//  Lesson12
//
//  Created by Андрей Зорькин on 18/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let tableViewController = TableViewController()
        let navigationController = UINavigationController(rootViewController: tableViewController)
        guard let window = window else {
            fatalError("AppDelegate: window was not created")
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return true
    }

}


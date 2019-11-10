//
//  AppDelegate.swift
//  AppWithFramework
//
//  Created by Андрей Зорькин on 10/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            let viewController = ViewController()
            window.rootViewController = UINavigationController(rootViewController: viewController)
            window.makeKeyAndVisible()
        } else {
            assertionFailure("[AppDelegate]: window не задан")
        }
        return true
    }

}


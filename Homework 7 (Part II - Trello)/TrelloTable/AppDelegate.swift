//
//  AppDelegate.swift
//  TrelloTable
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
            let trelloViewController = TrelloViewController()
            let navigationController = UINavigationController(rootViewController: trelloViewController)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        
        return true
    }


}


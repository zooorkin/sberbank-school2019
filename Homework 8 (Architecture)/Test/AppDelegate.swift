//
//  AppDelegate.swift
//  Test
//
//  Created by Antyshev Dmitriy on 20.10.2019.
//  Copyright © 2019 Antyshev Dmitriy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

    private let rootAssembly: IRootAssembly = RootAssembly()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            
            let controller = rootAssembly.presentationAssembly.view()
        window.rootViewController = rootAssembly.presentationAssembly.navigationController(rootViewController: controller)
        window.makeKeyAndVisible()
        } else {
            assertionFailure("[AppDelegate] window отсутствует")
        }
		return true
	}

}


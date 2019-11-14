//
//  AppDelegate.swift
//  UrlSessionLesson
//
//  Created by Константин Богданов on 06/11/2019.
//  Copyright © 2019 Константин Богданов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		window = UIWindow(frame: UIScreen.main.bounds)
        
        let session = SessionFactory().createDefaultSession()
		let service = NetworkService(session: session)
		let interactor = Interactor(networkService: service)
		let viewController = ViewController(interactor: interactor)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        if let window = window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        } else {
            assertionFailure("[AppDelegate]: window is nil")
        }

		return true
	}
}


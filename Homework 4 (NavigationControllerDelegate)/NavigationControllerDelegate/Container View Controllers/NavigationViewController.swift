//
//  NavigationViewController.swift
//  NavigationControllerDelegate
//
//  Created by Андрей Зорькин on 17/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    var navigationControllerDelegate: UINavigationControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = .black
        self.navigationControllerDelegate = NavigationControllerDelegate(navigationController: self)
        self.delegate = navigationControllerDelegate!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.tintColor = .yellow
        self.navigationBar.tintColor = .yellow
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow]
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

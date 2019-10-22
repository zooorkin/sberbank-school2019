//
//  TabBarController.swift
//  Animation
//
//  Created by Андрей Зорькин on 22/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = .black
        self.tabBar.tintColor = .yellow
        self.tabBar.unselectedItemTintColor = .lightGray
    }
    
}

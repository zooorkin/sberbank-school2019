//
//  ViewController.swift
//  AppWithFramework
//
//  Created by Андрей Зорькин on 10/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit
import SeaFramework

class ViewController: UIViewController {

    
    var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SeaFramework"
        view.backgroundColor = .groupTableViewBackground
        self.label = UILabel(frame: .zero)
        setupLabel()
    }
    
    private func setupLabel() {
        if let label = label {
            view.addSubview(label)
            label.numberOfLines = 0
            label.font = .preferredFont(forTextStyle: .title1)
            label.text = SeaFramework.blackSea.description + "\n\n" +
                SeaFramework.mediterraneanSea.description + "\n\n" +
                SeaFramework.caribbeanSea.description
        } else {
            print("[ViewController]: label не задан")
        }
    }

    override func viewWillLayoutSubviews() {
        label?.frame = view.frame.insetBy(dx: 32, dy: 32)
    }

}


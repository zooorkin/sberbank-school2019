//
//  ThirdViewController.swift
//  NavigationControllerDelegate
//
//  Created by Андрей Зорькин on 17/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

/// Третий View Controller
class ThirdViewController: UIViewController {

    var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createButton()
        self.view.backgroundColor = .orange
        self.title = "Закат"
    }
    
    /// Создание кнопки
    private func createButton() {
        self.button = UIButton(type: .custom)
        self.button.setTitle("Начать день", for: .normal)
        self.button.backgroundColor = .black
        self.button.setTitleColor(.orange, for: .normal)
        self.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    /// Layout кнопки
    private func layoutButton() {
        let center: CGPoint = {
            let x = self.view.center.x
            let y = self.view.frame.height * 0.9
            return CGPoint(x: x, y: y)
        }()
        let width = self.view.frame.width / 2
        let size = CGSize(width: width, height: width)
        self.button.frame = CGRect(origin: .zero, size: size)
        self.button.center = center
        self.button.layer.cornerRadius = width / 2
    }
    
    override func viewWillLayoutSubviews() {
        layoutButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.tintColor = .orange
        self.navigationController?.navigationBar.tintColor = .orange
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    /// Реакция кнопки
    @objc private func buttonTapped() {
        let sunRiseViewController = FirstViewController()
        self.navigationController?.pushViewController(sunRiseViewController, animated: true)
    }

}

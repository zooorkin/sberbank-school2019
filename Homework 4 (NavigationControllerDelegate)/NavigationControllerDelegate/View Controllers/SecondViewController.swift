//
//  SecondViewController.swift
//  NavigationControllerDelegate
//
//  Created by Андрей Зорькин on 17/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

/// Второй View Controller
class SecondViewController: UIViewController {

    var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createButton()
        self.view.backgroundColor = .cyan
        self.title = "Снег"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.tintColor = .cyan
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    /// Создание кнопки
    private func createButton() {
        self.button = UIButton(type: .custom)
        self.button.setTitle("Let It Snow", for: .normal)
        self.button.backgroundColor = .black
        self.button.setTitleColor(.cyan, for: .normal)
        self.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    /// Layout кнопки
    private func layoutButton() {
        let center: CGPoint = {
            let x = self.view.center.x
            let y = self.view.frame.height * 0.3
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
    
    /// Реакция кнопки
    @objc private func buttonTapped() {
        let alertController = UIAlertController(title: "Эта кнопка пока ничего не делает 🐱", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

}

//
//  NavigationControllerDelegate.swift
//  NavigationControllerDelegate
//
//  Created by Андрей Зорькин on 17/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

/// Класс, реализующий протокол UINavigationControllerDelegate
class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    /// Делегирующий NavigationController
    weak var navigationController: UINavigationController!
    
    /// Инициализатор
    ///
    /// - Parameter navigationController: Делегирующий NavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let className: String
        switch viewController {
        case is FirstViewController:
            className = String(describing: FirstViewController.self)
        case is SecondViewController:
            className = String(describing: SecondViewController.self)
        case is ThirdViewController:
            className = String(describing: ThirdViewController.self)
        case is NavigationViewController:
            className = String(describing: NavigationViewController.self)
        case is TabBarController:
            className = String(describing: TabBarController.self)
        default:
            className = String(describing: UIViewController.self)
        }
        let text = "Сейчас будет показан \(className) 🙈"
        print(text)
        showAlertController(with: text)
    }
    
    /// Вывести на экран уведомление с текстом
    ///
    /// - Parameter text: показываемый текст
    private func showAlertController(with text: String) {
        let alertController = UIAlertController(title: "Сообщение от созданного класса", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        navigationController.present(alertController, animated: true, completion: nil)
    }
    
}

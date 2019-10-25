//
//  DetailViewController.swift
//  Lesson12
//
//  Created by Андрей Зорькин on 22/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

/// Протокол делегата DetailViewController
protocol DetailViewControllerNewTitleDelegate {
    /// View Controller изменил заголовок ячейки
    ///
    /// - Parameters:
    ///   - newTitle: новый заголовок
    ///   - indexPath: индекс изменённой ячейки
    func detailViewControllerDidChangeTitle(newTitle: String, forRowAt indexPath: IndexPath)
}

/// View Controller для изменения заголовка ячейки
class DetailViewController: UIViewController, UINavigationControllerDelegate {

    var delegate: DetailViewControllerNewTitleDelegate?
    
    private var detailTitleString: String = "Название не задано"
    
    private var detailTextField = UITextField()
    
    
    var myIndexPath: IndexPath?
    
    var detailTitle: String {
        set {
            detailTitleString = newValue
            detailTextField.text = newValue
            title = newValue
        }
        get {
            return detailTitleString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        view.backgroundColor = .white
        detailTextField.borderStyle = .roundedRect
        view.addSubview(detailTextField)
    }
    
    override func viewWillLayoutSubviews() {
        let width = view.frame.width
        detailTextField.frame = CGRect(x: 32, y: 128 + 32, width: width - 2 * 32, height: 32)
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if let indexPath = myIndexPath {
            let text = detailTextField.text ?? ""
            if text != detailTitleString {
                delegate?.detailViewControllerDidChangeTitle(newTitle: text, forRowAt: indexPath)
            }
        }
    }
    
}

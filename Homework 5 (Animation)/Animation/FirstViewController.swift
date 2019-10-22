//
//  FirstViewController.swift
//  Animation
//
//  Created by Андрей Зорькин on 22/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

/// Второй View Controller
class FirstViewController: UIViewController {
    
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
        self.button.setTitle("Анимацию?", for: .normal)
        self.button.backgroundColor = .black
        self.button.setTitleColor(.cyan, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(48)
        self.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 5.0
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
        self.button.layer.cornerRadius = width / 2
        let size = CGSize(width: width, height: width)
        self.button.frame = CGRect(origin: .zero, size: size)
        self.button.center = center
    }
    
    override func viewWillLayoutSubviews() {
        layoutButton()
    }
    
    enum ButtonState {
        case circle
        case square
    }
    
    var buttonState: ButtonState = .circle
    
    /// Реакция кнопки
    @objc private func buttonTapped() {
        button.isEnabled = false
        
        let toBackgroundColor: CGColor
        let toCornerRadius: CGFloat
        let duration: CFTimeInterval
        let toTextColor: UIColor
        let toText: String
        
        switch buttonState {
        case .circle:
            toBackgroundColor = UIColor.white.cgColor
            toCornerRadius = button.frame.width / 8
            toTextColor = UIColor.black
            toText = "ДА!!!"
            buttonState = .square
        case .square:
            toBackgroundColor = UIColor.black.cgColor
            toCornerRadius = button.frame.width / 2
            toTextColor = UIColor.cyan
            toText = "Анимацию?"
            buttonState = .circle
        }
        duration = 0.3
        
        let animationBackgroundColor = CABasicAnimation(keyPath: "backgroundColor")
        animationBackgroundColor.fromValue = button.layer.backgroundColor ?? UIColor.clear.cgColor
        animationBackgroundColor.toValue = toBackgroundColor
        animationBackgroundColor.duration = duration
        
        let animationCornerRadius = CABasicAnimation(keyPath: "cornerRadius")
        animationCornerRadius.fromValue = button.layer.cornerRadius
        animationCornerRadius.toValue = toCornerRadius
        animationCornerRadius.duration = duration
        
        let animationScale = CABasicAnimation(keyPath: "transform.scale")
        animationScale.fromValue = 1.0
        animationScale.toValue = 0.5
        animationScale.autoreverses = true
        animationScale.repeatCount = 1
        animationScale.beginTime = 0
        animationScale.duration = duration / 2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animationBackgroundColor, animationCornerRadius, animationScale]
        animationGroup.duration = duration
        
        button.layer.add(animationGroup, forKey: "toSquare")
        button.layer.backgroundColor = toBackgroundColor
        button.layer.cornerRadius = toCornerRadius
        button.setTitle(toText, for: .normal)
        button.setTitleColor(toTextColor, for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration){
            self.button.isEnabled = true
        }
        
    }
    
    
}

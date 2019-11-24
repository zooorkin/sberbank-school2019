//
//  ViewController.swift
//  Test
//
//  Created by Antyshev Dmitriy on 20.10.2019.
//  Copyright © 2019 Antyshev Dmitriy. All rights reserved.
//

import UIKit


class View: UIViewController {
    
    
    var presenter: PresenterInput?
    
    init() {
        super.init(nibName: "View", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	@IBOutlet weak var currentImageView: UIImageView!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var cacheClearButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
        setupViews()
	}
    
    func setupViews() {
        title = "Архитектура"
        let cornerRadius: CGFloat = 16.0
        showButton.layer.cornerRadius = cornerRadius
        downloadButton.layer.cornerRadius = cornerRadius
        cacheClearButton.layer.cornerRadius = cornerRadius
        currentImageView.layer.cornerRadius = cornerRadius
        currentImageView.layer.masksToBounds = true
    }
    
    @IBAction func show(_ sender: UIButton) {
        if let output = presenter {
            output.show()
        } else {
            assertionFailure("[View]: presenter не задан")
        }
    }
    
    @IBAction func download(_ sender: UIButton) {
        if let output = presenter {
            output.download()
        } else {
            assertionFailure("[View]: presenter не задан")
        }
    }
    
    @IBAction func cacheClear(_ sender: UIButton) {
        if let output = presenter {
            output.cacheClear()
        } else {
            assertionFailure("[View]: presenter не задан")
        }
    }
    
}

extension View: PresenterOutput {
    
    func showImage(image: UIImage) {
        DispatchQueue.main.async {
            self.currentImageView.image = image
        }
    }
    
    func showAlert(text: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func removeImage() {
        DispatchQueue.main.async {
            self.currentImageView.image = nil
        }
    }
    
}


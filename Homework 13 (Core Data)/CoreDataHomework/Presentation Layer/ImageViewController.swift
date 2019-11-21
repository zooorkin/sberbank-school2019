//
//  ImageViewController.swift
//  CoreDataHomework
//
//  Created by Андрей Зорькин on 21/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    lazy var imageView: UIImageView = configuredImageView()
    
    var imageCellModel: ImageCellModel? {
        didSet {
            guard let imageCellModel = imageCellModel else {
                return
            }
            title = imageCellModel.description
            imageView.image = imageCellModel.image
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.imageView = configuredImageView()
        
    }
    
    private func configuredImageView() -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    override func viewWillLayoutSubviews() {
        imageView.frame = view.frame
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ImageService.swift
//  Test
//
//  Created by Андрей Зорькин on 31.10.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol ImageServiceProtocol {

    var delegate: ImageServiceDelegate? {get set}
    
    func downloadImageByURL(_ url: URL)
    
}


protocol ImageServiceDelegate {
    
    func imageServiceDidDownload(image: UIImage)
    
    func imageServiceDidNotDownloadImage()
    
}


class ImageService: ImageServiceProtocol, CoreNetworkDelegate {

    var delegate: ImageServiceDelegate?

    private var coreNetwork: CoreNetworkProtocol


    init(coreNetwork: CoreNetworkProtocol) {
        self.coreNetwork = coreNetwork
        self.coreNetwork.delegate = self
    }
    
    func downloadImageByURL(_ url: URL) {
        coreNetwork.downloadImage(url: url){ image, error in
            if let image = image {
                if let delegate = self.delegate {
                    delegate.imageServiceDidDownload(image: image)
                } else {
                    print("[ImageService]: delegate не задан")
                }
            } else {
                if let delegate = self.delegate {
                    delegate.imageServiceDidNotDownloadImage()
                } else {
                    print("[ImageService]: delegate не задан")
                }
            }
        }
    }

}

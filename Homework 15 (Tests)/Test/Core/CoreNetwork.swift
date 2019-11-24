//
//  CoreNetwork.swift
//  Test
//
//  Created by Андрей Зорькин on 31.10.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol ICoreNetwork {

    var delegate: ICoreNetworkDelegate? {get set}
    
    func downloadImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void)
    
}


protocol ICoreNetworkDelegate {

}


class CoreNetwork: ICoreNetwork {

    var delegate: ICoreNetworkDelegate?
    
    func downloadImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let currentError = error {
                completion(nil, currentError)
                return
            }
            
            guard let currentData = data else { return }
            let image = UIImage(data: currentData)
            completion(image, nil)
        }
        
        task.resume()
    }

}

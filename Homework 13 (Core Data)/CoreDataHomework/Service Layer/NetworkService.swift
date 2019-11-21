//
//  NetworkService.swift
//  CoreDataHomework
//
//  Created by Андрей Зорькин on 20/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

class NetworkService {
    
    private let session: URLSession
    
    internal init(session: URLSession) {
        self.session = session
    }
    
    internal func getData(at path: URL, completion: @escaping (Data?) -> Void) {
        let dataTask = session.dataTask(with: path) { data, _, _ in
            completion(data)
        }
        dataTask.resume()
    }
    
}

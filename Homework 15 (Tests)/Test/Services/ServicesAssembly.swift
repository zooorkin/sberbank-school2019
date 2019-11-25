//
//  ServicesAssembly.swift
//  Test
//
//  Created by Андрей Зорькин on 31.10.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol ServicesAssemblyProtocol {
    
    var imageService: ImageServiceProtocol {get}
    
}

class ServicesAssembly: ServicesAssemblyProtocol {
    
    private var coreAssembly: CoreAssemblyProtocol
    
    
    init(coreAssembly: CoreAssemblyProtocol) {
        self.coreAssembly = coreAssembly
    }
    
    
    lazy var imageService: ImageServiceProtocol =  {
        let coreNetwork = coreAssembly.coreNetwork
        return ImageService(coreNetwork: coreNetwork)
    }()
    
    
}

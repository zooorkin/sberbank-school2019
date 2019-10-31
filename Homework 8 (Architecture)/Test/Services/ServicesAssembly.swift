//
//  ServicesAssembly.swift
//  Test
//
//  Created by Андрей Зорькин on 31.10.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol IServicesAssembly {
    
    init(coreAssembly: ICoreAssembly)
    
    var imageService: IImageService {get}
    
    
}

class ServicesAssembly: IServicesAssembly {
    
    private var coreAssembly: ICoreAssembly
    
    
    required init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }
    
    
    lazy var imageService: IImageService =  {
        let coreNetwork = coreAssembly.coreNetwork
        return ImageService(coreNetwork: coreNetwork)
    }()
    
    
}

//
//  PresentationAssembly.swift
//  Test
//
//  Created by Андрей Зорькин on 31.10.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

protocol IPresentationAssembly {
    
    init(servicesAssembly: IServicesAssembly)
    
    
    func navigationController(rootViewController: UIViewController) -> UINavigationController
    
    func view() -> View
    
}

class PresentationAssembly: IPresentationAssembly {

    private var servicesAssembly: IServicesAssembly


    required init(servicesAssembly: IServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    

    func navigationController(rootViewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: rootViewController)
    }

    func view() -> View {
        let imageService = servicesAssembly.imageService
        
        let view = View()
        let presenter = Presenter()
        let interactor = Interactor(imageService: imageService)
        let router = Router()
        
        view.presenter = presenter
        presenter.output = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        
        return view
    }

}

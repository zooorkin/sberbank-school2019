//
//  RootAssembly.swift
//  Test
//
//  Created by Андрей Зорькин on 31.10.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol IRootAssembly {
    
    var presentationAssembly: IPresentationAssembly { get }
    
}

class RootAssembly: IRootAssembly {

    lazy var presentationAssembly: IPresentationAssembly = PresentationAssembly(servicesAssembly: servicesAssembly)

    private lazy var servicesAssembly: IServicesAssembly = ServicesAssembly(coreAssembly: coreAssembly)

    private lazy var coreAssembly: ICoreAssembly = CoreAssembly()

}

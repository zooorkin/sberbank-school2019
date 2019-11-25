//
//  RootAssembly.swift
//  Test
//
//  Created by Андрей Зорькин on 31.10.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol RootAssemblyProtocol {
    
    var presentationAssembly: PresentationAssemblyProtocol { get }
    
}

class RootAssembly: RootAssemblyProtocol {

    lazy var presentationAssembly: PresentationAssemblyProtocol = PresentationAssembly(servicesAssembly: servicesAssembly)

    private lazy var servicesAssembly: ServicesAssemblyProtocol = ServicesAssembly(coreAssembly: coreAssembly)

    private lazy var coreAssembly: CoreAssemblyProtocol = CoreAssembly()

}

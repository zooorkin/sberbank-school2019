//
//  CoreAssembly.swift
//  Test
//
//  Created by Андрей Зорькин on 31.10.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol CoreAssemblyProtocol {
    
    var coreNetwork: CoreNetworkProtocol {get}
    
}

class CoreAssembly: CoreAssemblyProtocol {

    lazy var coreNetwork: CoreNetworkProtocol = CoreNetwork()

}

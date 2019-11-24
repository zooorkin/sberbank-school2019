//
//  CoreAssembly.swift
//  Test
//
//  Created by Андрей Зорькин on 31.10.2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

protocol ICoreAssembly {
    
    var coreNetwork: ICoreNetwork {get}
    
}

class CoreAssembly: ICoreAssembly {

    lazy var coreNetwork: ICoreNetwork = CoreNetwork()

}

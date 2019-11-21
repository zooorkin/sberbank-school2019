//
//  RootAssembler.swift
//  CoreDataHomework
//
//  Created by Андрей Зорькин on 21/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

/// Сборщик
class Assembler {
    
    static func rootViewController() -> UIViewController {
        // Core Layer
        let session = SessionFactory.createDefaultSession()
        let coreDataStack = CoreDataStack.shared
        // Service Layer
        let networkService = NetworkService(session: session)
        let imagesPersistentStore = ImagesPersistentStore(coreDataStack: coreDataStack)
        let tableViewModel = TableViewModel(networkService: networkService,
                                            imagesPersistentStore: imagesPersistentStore)
        // Presentation Layer
        let tableViewController = TableViewController(style: .grouped, model: tableViewModel)
        let navigationController = UINavigationController(rootViewController: tableViewController)
        
        return navigationController
    }
    
}

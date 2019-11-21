//
//  CoreDataStack.swift
//  CoreDataHomework
//
//  Created by Андрей Зорькин on 20/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    /// Shared-instance of Core Data Stack
    static var shared: CoreDataStack = CoreDataStack()
    
    /// Контекст для чтения данных из Core Data
    internal let readContext: NSManagedObjectContext
    /// Контекст для записи данных в Core Data
    internal let writeContext: NSManagedObjectContext
    /// Модель данных Core Data
    private let model: NSManagedObjectModel
    /// Координатор Core Data
    private let coordinator: NSPersistentStoreCoordinator
    
    // Инициализатор по умолчанию
    init() {
        /// Настройка модели данных
        func configuredManagedObjectModel() -> NSManagedObjectModel {
            guard let modelURL = Bundle.main.url(forResource: "DataModel", withExtension: "momd") else {
                fatalError("Не удалось найти модель данных")
            }
            guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
                fatalError("Не удалось создать модель")
            }
            return model
        }
        /// Настройка координатора
        func configuredCoordinator(with model: NSManagedObjectModel) -> NSPersistentStoreCoordinator {
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
            let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
            let file = URL(string: "CoreData.sqlite", relativeTo: directory)
            do {
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: file, options: nil)
            } catch {
                fatalError("Не удалось настроить persistent store")
            }
            return coordinator
        }
        /// Настройка read context
        func configuredReadContext(with coordinator: NSPersistentStoreCoordinator) -> NSManagedObjectContext {
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.persistentStoreCoordinator = coordinator
            return context
        }
        /// Настройка write context
        func configuredWriteContext(with coordinator: NSPersistentStoreCoordinator) -> NSManagedObjectContext {
            let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            context.persistentStoreCoordinator = coordinator
            return context
        }
        
        let model = configuredManagedObjectModel()
        let coordinator = configuredCoordinator(with: model)
        let readContext = configuredReadContext(with: coordinator)
        let writeContext = configuredWriteContext(with: coordinator)
        
        self.model = model
        self.coordinator = coordinator
        self.readContext = readContext
        self.writeContext = writeContext
    }
    
}

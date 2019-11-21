//
//  ImagesPersistentStore.swift
//  CoreDataHomework
//
//  Created by Андрей Зорькин on 20/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

import CoreData

class ImagesPersistentStore {
    
    
    private let stack: CoreDataStack
    
    private lazy var fetchedResultsController: NSFetchedResultsController<MOImageModel> = configuredFRC()
    
    init(coreDataStack: CoreDataStack) {
        self.stack = coreDataStack
    }
    
    private func configuredFRC() -> NSFetchedResultsController<MOImageModel> {
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        let request = NSFetchRequest<MOImageModel>(entityName: "MOImageModel")
        request.sortDescriptors = [sortDescriptor]
        request.fetchBatchSize = 20
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: stack.readContext,
                                                              sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    func imageCellModel(at indexPath: IndexPath) -> ImageCellModel? {
        let imageModel = fetchedResultsController.object(at: indexPath)
        guard let data = imageModel.image else {
            print("[PersistentStore]: data is nil")
            return nil
        }
        guard let image = UIImage(data: data) else {
            print("[PersistentStore]: image is nil")
            return nil
        }
        return ImageCellModel(description: imageModel.title, image: image)
    }
    
    var numberOfSections: Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        } else {
            print("[ImagesPersistentStore]: sections is nil")
            return 0
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            print("[ImagesPersistentStore]: sections is nil")
            return 0
        }
    }
    
    func add(imageCellModel: ImageCellModel) {
        stack.writeContext.perform {
            let imageModel = MOImageModel(context: self.stack.writeContext)
            imageModel.image = imageCellModel.image.pngData()
            imageModel.title = imageCellModel.description
        }
    }
    
    func save() {
        stack.writeContext.performAndWait {
            do {
                try self.stack.writeContext.save()
            } catch {
                print("[PersistentStore]: " + error.localizedDescription)
            }
        }
    }
    
    func getImages(completion: @escaping (_ isEmpty: Bool) -> Void ) {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("[ImagesPersistentStore]: " + error.localizedDescription)
        }
        if numberOfSections != 0{
            let isEmpty = numberOfRows(in: 0) == 0
            completion(isEmpty)
        } else {
            completion(true)
        }
    }
    
}

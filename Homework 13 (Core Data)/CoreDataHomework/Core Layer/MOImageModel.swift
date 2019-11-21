//
//  MOImageModel.swift
//  CoreDataHomework
//
//  Created by Андрей Зорькин on 20/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import CoreData

@objc(MOImageModel)
internal class MOImageModel: NSManagedObject {
    
    @NSManaged var image: Data?
    
    @NSManaged var title: String
    
}

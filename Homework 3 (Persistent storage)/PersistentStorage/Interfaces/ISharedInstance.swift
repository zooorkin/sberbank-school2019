//
//  ISharedInstance.swift
//  PersistentStorage
//
//  Created by Андрей Зорькин on 10/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

/// Наличие синглтона
protocol ISharedInstance {
    
    /// Тип синглтона
    associatedtype T
    
    /// Синглтон
    static var sharedInstance: T { get }
}

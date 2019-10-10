//
//  Dog.swift
//  PersistentStorage
//
//  Created by Андрей Зорькин on 10/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

/// Собака
struct Dog {
    /// Кличка
    let name: String
}

extension Dog: Codable { }

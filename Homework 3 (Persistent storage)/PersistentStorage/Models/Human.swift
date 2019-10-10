//
//  Human.swift
//  PersistentStorage
//
//  Created by Андрей Зорькин on 10/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

/// Человек
struct Human {
    /// Имя
    let firstName: String
    /// Фамилия
    let lastName: String
    /// Возраст
    let age: Int
}

extension Human: Codable { }

//
//  House.swift
//  PersistentStorage
//
//  Created by Андрей Зорькин on 10/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

/// Дом
struct House {
    /// Почтовый индекс
    let index: String
    /// Страна
    let country: String
    /// Город
    let city: String
}

extension House: Codable { }

//
//  IPersistentStorage.swift
//  PersistentStorage
//
//  Created by Андрей Зорькин on 10/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

/// Интерфейс постоянного хранилища
protocol IPersistentStorage {
    
    /// Сохранение данных
    ///
    /// - Parameters:
    ///   - object: Объект для сохранения
    ///   - forName: Имя, под которым будет сохраняться объект
    func save<T>(_ object: T, forName: String) -> Result<Void, Error> where T: Codable
    
    /// Получение сохранённых данных
    ///
    /// - Parameters:
    ///   - ObjectType: Требуемый тип объекта
    ///   - forName: Имя, под которым сохранялся объект
    /// - Returns: В случае успеха – объект требуемого типа, иначе – nil.
    func get<T>(_ ObjectType: T.Type, forName: String) -> Result<T, Error> where T: Codable
}

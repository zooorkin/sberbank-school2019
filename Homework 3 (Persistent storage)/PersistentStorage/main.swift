//
//  main.swift
//  PersistentStorage
//
//  Created by Андрей Зорькин on 10/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

/// Интерфейс примера работы PersistentStorage
protocol IPersistentStorageExample {
    
    /// Сохранение некоторых данных
    static func saveSomeData()
    
    /// Получение некоторых сохранённых данных
    static func getSomeSavedData()
}


/// Пример работы PersistentStorage
class PersistentStorageExample: IPersistentStorageExample {
    
    static func saveSomeData() {

        print("1. Сохранение")
        
        let storage: IPersistentStorage = PersistentStorage()
        
        let andrew = Human(firstName: "Andrew", lastName: "Zooorkin", age: 23)
        switch storage.save(andrew, forName: "andrew") {
        case .success:
            print("Сохранение andrew прошло успешно, andrew = \(andrew)")
        case .failure(let error):
            print("Сохранение andrew не удалось. Ошибка: " + error.localizedDescription)
        }
        
        let house = House(index: "3500020", country: "Russian Federation", city: "Krasnodar")
        switch storage.save(house, forName: "house") {
        case .success:
            print("Сохранение house прошло успешно, house = \(house)")
        case .failure(let error):
            print("Сохранение house не удалось. Ошибка: " + error.localizedDescription)
        }
    }
    
    static func getSomeSavedData() {
        
        print("2. Чтение")
        
        let storage: IPersistentStorage = PersistentStorage()
        
        switch storage.get(Human.self, forName: "andrew") {
        case .success(let andrew):
            print("Чтение andrew прошло успешно, andrew = \(andrew)")
        case .failure(let error):
            print("Сохранение andrew не удалось. Ошибка: " + error.localizedDescription)
        }
    
        switch storage.get(House.self, forName: "house") {
        case .success(let house):
            print("Чтение house прошло успешно, house = \(house)")
        case .failure(let error):
            print("Сохранение house не удалось. Ошибка: " + error.localizedDescription)
        }

    }
    
}

// 1. Сохранение
PersistentStorageExample.saveSomeData()

// 2. Чтение
PersistentStorageExample.getSomeSavedData()

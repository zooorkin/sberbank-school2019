//
//  SafeCollection.swift
//  SafeCollection
//
//  Created by Андрей Зорькин on 11/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

// Потокобезопасная коллекция
public class SafeCollection<T> {
    
    // Последовательная очередь
    private let queue = DispatchQueue(label: "1")
    
    // Массив элементов типа T
    private var array: [T]
    
    // Инициализатор без параметров
    public init() {
        array = []
    }
    
    // Получение элемента по индексу
    public subscript (index: Int) -> T {
        get {
            return queue.sync {
                return array[index]
            }
        }
    }
    
    // Добавление нового элемента в конец
    public func append(_ newElement: T) {
        queue.async {
            self.array.append(newElement)
        }
    }
    
    // Удаление элемента по индексу
    public func remove(at index: Int) {
        queue.async {
            self.array.remove(at: index)
        }
    }
    
    // Удаление всеъ элементов
    public func removeAll() {
        queue.async {
            self.removeAll()
        }
    }
    
    // Вставка нового элемента по индексу
    public func insert(_ newElement: T, at index: Int) {
        queue.async {
            self.array.insert(newElement, at: index)
        }
    }
    
    // Получение первого элемента коллекции
    public var first: T? {
        return queue.sync {
            return array.first
        }
    }
    
    // Получение последнего элемент коллекции
    public var last: T? {
        return queue.sync {
            return array.last
        }
    }
    
    // Наличие элементов в коллекции
    public var isEmpty: Bool {
        return queue.sync {
            return array.isEmpty
        }
    }
    
    // Количество элементов в коллекции
    public var count: Int {
        return queue.sync {
            return array.count
        }
    }
    
    // Изменение значения элемента в коллекции на значение, зависящее от текущего
    //  - использовать в случаях, где GET и SET должны выполняться подряд
    public func perform(to index: Int, block: @escaping (T) -> T){
        queue.async {
            self.array[index] = block(self.array[index])
        }
    }
    
    // Получение коллекции, упорядоченной в обратном порядке
    public func reversed() -> [T] {
        return queue.sync {
            return array.reversed()
        }
    }
    
}

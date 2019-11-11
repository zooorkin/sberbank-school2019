//
//  main.swift
//  SafeCollection
//
//  Created by Андрей Зорькин on 11/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

// Создание concurrent очереди, потокобезопасной коллекции и DispatchGroup
// для синхронизации вывода реальных и ожидаемых значений
let queue = DispatchQueue.global()
let safeCollection = SafeCollection<Int>()
let group = DispatchGroup()

// Асинхронное добавление 1000 элементов в concurrent очереди
for _ in 0..<1000 {
    group.enter()
    queue.async {
        safeCollection.append(5)
        group.leave()
    }
}
group.wait()
print("count is \(safeCollection.count), expected \(1000)")

// Асинхронное удаление 500 элементов в concurrent очереди
for _ in 0..<500 {
    group.enter()
    queue.async {
        safeCollection.remove(at: 0)
        group.leave()
    }
}
group.wait()
print("count is \(safeCollection.count), expected \(500)")


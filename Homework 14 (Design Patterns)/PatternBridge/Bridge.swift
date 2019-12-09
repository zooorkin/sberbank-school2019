//
//  Bridge.swift
//  PatternBridge
//
//  Created by Андрей Зорькин on 09/12/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

protocol SetProtocol {
    
    func insert(_ newMember: Int)
    
    func contains(element: Int) -> Bool
    
    func count() -> Int
    
    func description()
    
}

class SetArray: SetProtocol {
    var array: [Int]
    init() {
        array = [Int]()
    }
    func insert(_ newMember: Int) {
        array.append(newMember)
    }
    func contains(element: Int) -> Bool {
        return array.contains(element)
    }
    func count() -> Int {
        return array.count
    }
    func description() {
        print("SetArray class")
    }
}

class SetStack: SetProtocol {
    
    var array: [Int]
    init() {
        array = [Int]()
    }
    func insert(_ newMember: Int) {
        array.append(newMember)
    }
    func contains(element: Int) -> Bool {
        return array.contains(element)
    }
    func count() -> Int {
        return array.count
    }
    func description(){
        print("SetStack class")
    }
}

class mySet: SetProtocol {
    
    var mySet: SetProtocol
    
    init(_ number: Int = 0) {
        switch abs(number) {
        case 0...9:     mySet = SetStack()
        case 10...99:   mySet = SetArray()
        case 100...999: mySet = SetArray()
        default:        mySet = SetArray()
        }
    }
    func insert(_ newMember: Int) {
        mySet.insert(newMember)
    }
    func contains(element: Int) -> Bool {
        return mySet.contains(element: element)
    }
    func count() -> Int {
        return mySet.count()
    }
    func description(){
        mySet.description()
    }
    
}


func testBridge() {
    
    let x = mySet(100)
    x.description()
    
    let y = mySet(3)
    y.description()
    
}

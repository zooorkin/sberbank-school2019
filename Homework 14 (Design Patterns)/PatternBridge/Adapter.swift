//
//  Adapter.swift
//  PatternBridge
//
//  Created by Андрей Зорькин on 09/12/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation


protocol StackProtocol {

    func push(value: Int)
    
    @discardableResult
    func pop() -> Int?
    
    func peek() -> Int?
    
}

class Stack: StackProtocol {
    
    var array: [Int] = []
    
    func push(value: Int) {
        array.append(value)
    }
    
    @discardableResult
    func pop() -> Int? {
        if let element = array.last {
            array.removeLast()
            return element
        } else {
            return nil
        }
    }
    
    func peek() -> Int? {
        return array.last
    }
}

func testAdapter() {
    let stack: StackProtocol = Stack()
    stack.push(value: 1)
    stack.push(value: 2)
    stack.push(value: 3)
    print("Top element is \(stack.peek()!)")
    stack.pop()
    print("Second element is \(stack.pop()!)")
    print("Last element is \(stack.pop()!)")
    print("Stack is empty, top element is \(String(describing: stack.peek()))")
}

//
//  QueueDoubleStack.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 30/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import Foundation

public struct QueueDoubleStack<T : Equatable> : Queue {
    private var leftStack = Array<T>()
    private var rightStack = Array<T>()
    
    public init() {}
    
    public mutating func enQueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    public mutating func deQueue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        return leftStack.popLast()
    }
    
    public mutating func deQueue( _ element : T) -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        leftStack.removeAll{ $0 == element}
        return element
    }
    
    public var isEmpty: Bool {
        return leftStack.isEmpty && rightStack.isEmpty
    }
    public var peek: T? {
        return !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
}

extension QueueDoubleStack : CustomStringConvertible {
    public var description: String {
        let printList = leftStack.reversed() + rightStack
        return String(describing: printList)
    }
}

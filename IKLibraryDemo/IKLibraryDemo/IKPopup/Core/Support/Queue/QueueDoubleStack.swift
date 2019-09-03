//
//  QueueDoubleStack.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 30/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

/*
 설명 블로그
 https://the-brain-of-sic2.tistory.com/entry/%ED%81%90
 
 참고 소스
 https://github.com/changSic/DataStructures-and-Algorithms-in-Swift
 */

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
        print("")
        leftStack.removeAll{ $0 == element}
        print("")
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

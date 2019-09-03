//
//  Queue.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 30/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import Foundation


protocol Queue {
    associatedtype Element
    
    mutating func enQueue( _ element : Element) -> Bool
    mutating func deQueue() -> Element?
    
    var isEmpty : Bool { get }
    var peek : Element? { get }
}

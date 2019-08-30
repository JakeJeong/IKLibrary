//
//  UIWindow_Extention.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 30/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import UIKit


extension UIWindow {
    func resignKeyAndUnvisible(){
        self.resignKey()
        self.isHidden = true
    }
    
    func show(){
        self.makeKeyAndVisible()
    }
    func dismiss(){
        self.resignKeyAndUnvisible()
    }
}

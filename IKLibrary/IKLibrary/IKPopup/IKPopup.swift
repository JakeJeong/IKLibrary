//
//  IKPopup.swift
//  IKLibrary
//
//  Created by JakeJeong on 28/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import Foundation

typealias ActionHandler = (IKPopup)

class IKPopup{
    
    init() {
        
    }
    class func Show(okHandler : ActionHandler, CancelHanlder : ActionHandler) {

    }
    
    func showPopup(okHandler : ActionHandler, CancelHanlder : ActionHandler) -> IKPopup {
     
        let popup = IKPopup.init()
        
        return popup;
    }
}

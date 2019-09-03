//
//  SheetPopup.swift
//  IKLibraryDemo
//
//  Created by ikjeong.amd on 03/09/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import UIKit

class SheetPopup: IKPopupView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func initFrame() {
        self.frame = CGRect(x: 0, y: 0, width: 200, height: 350)
    }

}

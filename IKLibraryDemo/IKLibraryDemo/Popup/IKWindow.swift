//
//  IKWindow.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 30/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import UIKit


class IKWindow: UIWindow {
    
    var view : IKPopupView?
    
    var popupVC : IKPopupVC? {
        get {
            return self.rootViewController as? IKPopupVC
        }
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("IKWindow : awakeFromNib");
    }
}

//
//  UIButton+Extention.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 28/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import UIKit

extension UIButton {
    var text : String?{
        set {
            self.setTitle(newValue, for: .normal)
        }
        get {
            return self.titleLabel?.text
        }
    }
}

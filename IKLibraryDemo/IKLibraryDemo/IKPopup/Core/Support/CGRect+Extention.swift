//
//  CGRect+Extention.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 04/09/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import UIKit


extension CGRect {
   static func rectCenter(frame : CGRect, width : CGFloat, height : CGFloat) -> CGRect{
        return CGRect(x: frame.size.width/2 - width/2, y: frame.size.height/2 - height/2, width: width, height: height)
    }
}

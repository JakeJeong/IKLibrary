//
//  IKProgressView.swift
//  IKLibraryDemo
//
//  Created by ikjeong.dev on 2020/01/01.
//  Copyright © 2020 JakeJeong. All rights reserved.
//

import UIKit

class IKProgressView: UIView {
    
    func initFrame() {
        
    }
    
    static func load() -> IKProgressView?{
        guard let view = Bundle.main.loadNibNamed("IKProgressView", owner: self, options: nil)?.first as? IKProgressView else {
            return nil;
        }
        view.initFrame()
        return view
    }
    
}

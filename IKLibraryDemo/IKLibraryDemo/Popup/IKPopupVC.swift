//
//  IKPopupVC.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 30/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import UIKit

class IKPopupVC: UIViewController {
   
    
    var popupView : IKPopupView?

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.popupView?.center = self.view.center
//        self.view.addSubview(self.popupView!)
    }
    
}

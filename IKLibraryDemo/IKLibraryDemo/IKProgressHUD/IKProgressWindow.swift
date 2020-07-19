//
//  IKProgressWindow.swift
//  IKLibraryDemo
//
//  Created by ikjeong.dev on 2020/01/01.
//  Copyright © 2020 JakeJeong. All rights reserved.
//

import UIKit

class IKProgressWindow: UIWindow {
    
    private var gesture : UITapGestureRecognizer?
    private var _view : IKProgressView?
    var view : IKProgressView {
        get {
            if (_view == nil) {
                _view = IKProgressView.load()
                self.addSubview(_view!)
                self.makeInit()
            }
            return _view!
        }
    }
    
    func makeInit() {
        if self.gesture == nil {
            self.gesture = UITapGestureRecognizer(target: self, action: #selector(didTouchAction(sender:)))
            self.addGestureRecognizer(self.gesture!)
        }
        self.gesture?.isEnabled = IKProgressHUD.isCanDismiss
    }
    
    @objc
    func didTouchAction(sender : Any) {
        IKProgressHUD.dismiss()
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

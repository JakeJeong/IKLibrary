//
//  IKProgressHUD.swift
//  IKLibraryDemo
//
//  Created by ikjeong.dev on 2020/01/01.
//  Copyright © 2020 JakeJeong. All rights reserved.
//

import UIKit

class IKProgressHUD: NSObject {
    
    static let shared = IKProgressHUD()
    private  let window = IKProgressWindow()
    
    private var isLoading = false
    
    private var _completion : (()->Void)?
    
    static func show() {
        show(dismissDelay: 0, completion: nil)
    }
    
    static func show(dismissDelay : TimeInterval) {
        show(dismissDelay: 0, completion: nil)
    }
    
    static func show(dismissDelay : TimeInterval, completion : (()->Void)?) {
        if (IKProgressHUD.shared.isLoading){
            return
        }
        IKProgressHUD.shared.isLoading = true
        IKProgressHUD.shared.window.windowLevel = .alert
        IKProgressHUD.shared.window.alpha = 0.0;
        IKProgressHUD.shared.window.view.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
        
        IKProgressHUD.shared.window.view.center = IKProgressHUD.shared.window.center
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .allowUserInteraction, animations: {
            IKProgressHUD.shared.window.view.alpha = 1.0;
            IKProgressHUD.shared.window.view.transform = CGAffineTransform.identity
            IKProgressHUD.shared.window.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            IKProgressHUD.shared.window.alpha = 1.0;
            IKProgressHUD.shared.window.makeKeyAndVisible()
        }) { (isCompleted) in
            print(CFGetRetainCount(self))
            print("is IKProgressHUD Windows is Key Window -> %@",IKProgressHUD.shared.window.isKeyWindow == true ? "True" : "False")
            if (completion != nil){
                completion!()
            }
        }
        if (dismissDelay != 0) {
            DispatchQueue.main.asyncAfter(deadline: .now() + dismissDelay) {
                dismiss()
            }
        }
    }
    
    static func dismiss() {
        IKProgressHUD.shared.window.view.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: .allowUserInteraction, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6/3, animations: {
                IKProgressHUD.shared.window.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            })
            UIView.addKeyframe(withRelativeStartTime: (0.6/3)*2, relativeDuration: (0.6/3)*2, animations: {
                IKProgressHUD.shared.window.view.alpha = 0.0;
                IKProgressHUD.shared.window.backgroundColor = UIColor.black.withAlphaComponent(0.0)
                IKProgressHUD.shared.window.view.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
            })
        }) { (isCompleted) in
            IKProgressHUD.shared.isLoading = false
            IKProgressHUD.shared.window.resignKeyAndUnvisible()
        }
    }
}

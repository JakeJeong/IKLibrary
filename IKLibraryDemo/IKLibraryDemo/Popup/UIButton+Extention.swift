//
//  UIButton+Extention.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 28/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import UIKit



extension UIButton {
    private struct AssociatedKeys {
        static var Cancelkey = "kCancelKey"
        static var ConfirmKey = "kConfirmKey"
        static var OtherKey = "kOtherKey"
    }
    
    var text : String?{
        set {
            self.setTitle(newValue, for: .normal)
        }
        get {
            return self.titleLabel?.text
        }
    }
    
    @IBInspectable var isCancelType: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.Cancelkey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.Cancelkey) else {
                return false
            }
            return value as! Bool
        }
    }
    
    @IBInspectable var isConfirmType: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ConfirmKey, NSNumber(booleanLiteral: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.ConfirmKey) else {
                return false
            }
            return value as! Bool
        }
    }
    
    @IBInspectable var isOtherType: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.OtherKey, NSNumber(booleanLiteral: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.OtherKey) else {
                return false
            }
            return value as! Bool
        }
    }
}

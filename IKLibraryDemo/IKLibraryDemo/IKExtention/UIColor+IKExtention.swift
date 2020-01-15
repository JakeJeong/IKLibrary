//
//  UIColor+IKExtention.swift
//  IKLibraryDemo
//
//  Created by ikjeong.MCC on 2020/01/15.
//  Copyright © 2020 JakeJeong. All rights reserved.
//

import UIKit

enum SystemTheme {
    case dark
    case light
    case old
}

extension UIColor {
    static let main = UIColor.color(
        color: UIColor.HEX(0xffdd33),
        dark: UIColor.blue,
        light: UIColor.red,
        old: UIColor.HEX(0xffdd33))
}

extension UIColor {
    
    private struct AssociatedKeys {
        static var dark = "#AssociatedKeys.dark"
        static var light = "#AssociatedKeys.light"
        static var old = "#AssociatedKeys.old"
    }
    
    var autoColor : UIColor? {
        get {
            switch UIColor.theme {
            case .dark:
                return self.dark
            case .light:
                return self.light
            default:
                return self.old
            }
        }
    }
    
    var dark : UIColor? {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.dark) as? UIColor)
        }
        set {
            if (newValue != nil) {
                objc_setAssociatedObject(self, &AssociatedKeys.dark, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    var light : UIColor? {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.light) as? UIColor)
        }
        set {
            if (newValue != nil) {
                objc_setAssociatedObject(self, &AssociatedKeys.light, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    var old : UIColor? {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.old) as? UIColor)
        }
        set {
            if (newValue != nil) {
                objc_setAssociatedObject(self, &AssociatedKeys.old, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
   
    class func color(color : UIColor, dark : UIColor?, light : UIColor?, old : UIColor?) -> UIColor{
        let color = UIColor.init()
        color.dark = dark
        color.light = light
        color.old = old
        return color;
    }
    
    class func HEX(_ rgb: UInt) -> UIColor {
        return UIColor(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: 1.0)
    }
    
    static var theme : SystemTheme {
        if #available(iOS 13, *) {
            switch UITraitCollection.current.userInterfaceStyle {
            case .dark:
                return .dark
            case .light:
                return .light
            default:
                return .light
            }
        } else {
            return .old
        }
    }
}

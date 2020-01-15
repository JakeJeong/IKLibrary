//
//  IKLocalization.swift
//  IKLibraryDemo
//
//  Created by ikjeong.MCC on 2020/01/10.
//  Copyright © 2020 JakeJeong. All rights reserved.
//

import Foundation
import UIKit


enum IKLanguage : String {
    case kor = "ko"
    case eng = "en"
    case idn = "id"
    case vie = "vnm"
}

func IKLocal( _ localizationKey: String) -> String{
    return ""
}
class IKLocalization: NSObject {
    
    static fileprivate let shared = IKLocalization()
    static let didChangedNotification = NSNotification.Name("IKLocalizationDidChangedNotification")
    private var lists : [String:((IKLanguage)->Void)?] = [:]
    
    fileprivate var bundle : Bundle? {
        get {
            guard let path = Bundle.main.path(forResource: _lanuage?.rawValue ?? "", ofType: "lproj") else {
                return nil
            }
            return Bundle.init(path:path)
        }
    }
    
    private var _lanuage : IKLanguage?
    static var language : IKLanguage? {
        set {
            IKLocalization.shared._lanuage = newValue
            IKLocalization.shared.didsetLanguage()
            NotificationCenter.default.post(name: IKLocalization.didChangedNotification, object: nil)
        }
        get {
            return IKLocalization.shared._lanuage
        }
    }
    
    private func didsetLanguage() {
        guard let lang = self._lanuage else {
            return
        }
        for model in lists {
            guard let listener = model.value else {
                continue
            }
            listener(lang)
        }
    }
    
    static func addObserverDidChanged( _ aClass : AnyClass, _ listener : ((IKLanguage)->Void)?) {
        if let block = listener {
            IKLocalization.shared.lists[String(describing: aClass)] = block
        }
        print(IKLocalization.shared.lists)
    }
    
    static func removeObserverDidChanged( _ aClass : AnyClass) {
        for model in IKLocalization.shared.lists {
            if (model.key == String(describing: aClass)) {
                IKLocalization.shared.lists.removeValue(forKey: String(describing: aClass))
            }
        }
        print(IKLocalization.shared.lists)
    }
}
extension String {
    var local : String {
        return IKLocalization.shared.bundle?.localizedString(forKey: self, value: nil, table: nil) ?? ""
    }
}

typealias IKLocalizationDidChangeClosure = (_ languge : IKLanguage) -> Void

protocol IKLocalizationProtocol {
    func LocalizationDidChanged(listener: IKLocalizationDidChangeClosure?)
}

extension UIViewController : IKLocalizationProtocol {
    fileprivate var onLocalizationDidChangeClosure: IKLocalizationDidChangeClosure? {
        get {
            let wrapper =
                objc_getAssociatedObject(self, &icAssociationKey) as? ClosureWrapper
            return wrapper?.closure
        }
        set(newValue) {
            objc_setAssociatedObject(self,
                                     &icAssociationKey,
                                     ClosureWrapper(newValue),
                                     .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension IKLocalizationProtocol where Self : UIViewController {
    func LocalizationDidChanged(listener: IKLocalizationDidChangeClosure?) {
        self.onLocalizationDidChangeClosure = listener
        if listener != nil {
            NotificationCenter.default.addObserver(forName: IKLocalization.didChangedNotification, object: nil, queue: OperationQueue.main) { (notification) in
                self.onLocalizationDidChangeClosure!(IKLocalization.language!)
            }
        }
    }
    func locaizationDidChangeObserver(notification : NotificationCenter) {
        
    }
}

private var icAssociationKey: UInt8 = 0

private class ClosureWrapper {
    var closure: IKLocalizationDidChangeClosure?

    init(_ closure: IKLocalizationDidChangeClosure?) {
        self.closure = closure
    }
}


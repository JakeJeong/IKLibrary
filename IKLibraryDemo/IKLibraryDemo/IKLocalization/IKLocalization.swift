//
//  IKLocalization.swift
//  IKLibraryDemo
//
//  Created by ikjeong.MCC on 2020/01/10.
//  Copyright © 2020 JakeJeong. All rights reserved.
//

import Foundation


enum IKLanguage {
    case kor
    case eng
    case idn
    case vie
}
class IKLocalization: NSObject {
    
    static private let shared = IKLocalization()
    static let didChangedNotification = NSNotification.Name("IKLocalizationDidChangedNotification")
    
    private var lists : [String:((IKLanguage)->Void)?] = [:]
    
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

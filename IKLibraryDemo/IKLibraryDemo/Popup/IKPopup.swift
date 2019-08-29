//
//  JIKPopup.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 28/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import Foundation
import UIKit

struct IKPopupComponent {
    var title : String?
    var mesage : String?
}

typealias handlerAction = (IKPopupAction, IKPopup) -> Void
struct IKPopupAction {
    enum style {
        case None
        case OK
        case Cancel
    }
    var title : String?
    var action : handlerAction?
    var style : IKPopupAction.style
    
    init(title : String?, style : IKPopupAction.style, action : handlerAction?) {
        self.title = title
        self.action = action
        self.style = style
    }
    
}
class IKPopup : Hashable {
    var hashValue: Int = 0
    static func == (lhs: IKPopup, rhs: IKPopup) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
    lazy var popupComponent = IKPopupComponent()
    var popupView : IKPopupView?
    
    private var _identifier : String? = nil
    var identifier : String? {
        if _identifier == nil {
            _identifier = UUID().uuidString
        }
        return _identifier
    }
    
    var okPopupAction : IKPopupAction?
    var cancelPopupAction : IKPopupAction?
    
    func create() -> IKPopup{
        self.popupView = IKPopupView.LoadView()
        return self
    }
    func bindComponent(_ component : IKPopupComponent) ->IKPopup{
        popupComponent = component
        print(CFGetRetainCount(self))
        return self;
    }
    func addAction(action : IKPopupAction) -> IKPopup{
        if action.style == .OK {
            self.okPopupAction = action
        } else if action.style == .Cancel {
            self.cancelPopupAction = action
        }
        print(CFGetRetainCount(self))
        return self
    }
    func addPopupAction(action : @escaping () -> IKPopupAction) -> IKPopup{
        let popupAction = action()
        if popupAction.style == .OK {
            self.okPopupAction = popupAction
        } else if popupAction.style == .Cancel {
            self.cancelPopupAction = popupAction
        }
        print(CFGetRetainCount(self))
        return self
    }
    func show() {
        IKPopupManager.shared.push(popup: self)
        
        guard let view = popupView else {
            return
        }
        view.titleLabel?.text = popupComponent.title
        view.mesageLabel?.text = popupComponent.mesage
        
        
        if let okAction = okPopupAction {
            view.okBtn?.text = okAction.title
            view.okAction { _ in
                okAction.action!(okAction, self)
            }
        }
        if let cancelAction = cancelPopupAction {
            view.cancelBtn?.text = cancelAction.title
            view.cancelAction { _ in
                cancelAction.action!(cancelAction, self)
            }
        }
        view.backgroundColor = UIColor.red
        guard let window =  UIApplication.shared.delegate?.window else {
            return;
        }
        
        window?.rootViewController?.view.addSubview(view)
        print(CFGetRetainCount(self))
    }
    func dismiss() {
        guard let view = self.popupView else {
            return
        }
        view.removeFromSuperview()
        print(CFGetRetainCount(self))
        IKPopupManager.shared.pop(popup: self)
        print(CFGetRetainCount(self))
    }
    func dismiss(completion : (() -> Void)? = nil) {
        guard let view = self.popupView else {
            return
        }
        view.removeFromSuperview()
        IKPopupManager.shared.pop(popup: self)
        if completion != nil {
            completion!()
        }
    }
    func clearAll() {
        self.popupView = nil
        self.popupComponent.title = nil
        self.popupComponent.mesage = nil
        self.okPopupAction = nil
        self.cancelPopupAction = nil
    }
    deinit {
        self.clearAll()
        print(CFGetRetainCount(self))
        print("IKPopup Class deinit ->\(self)")
        
    }
}
class IKPopupManager {
    static let shared = IKPopupManager()
    var list = [IKPopup]()
    
    func push(popup : IKPopup){
        list.append(popup)
        log();
    }
    func pop(popup : IKPopup){
        if let pp = list.first(where: {$0 == popup}) {
            list.removeAll{$0 == popup}
            print(CFGetRetainCount(pp))
        }
        log();
    }
    func lastPop(){
        if list.count == 0 {
            return
        }
        list.removeLast()
    }
    func getLastPop() -> IKPopup?{
        if list.count == 0 {
            return nil;
        }
        return list.first
    }
    func log(){
        print("===== START =====")
        for pop in list {
            print("popup.identifier : \(pop.identifier!)")
        }
        print("===== End =====")
    }
}

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
        case Confirm
        case Cancel
        case Other
    }
    var title : String?
    var style : IKPopupAction.style
    var action : handlerAction?
    
    init(title : String?, style : IKPopupAction.style, action : handlerAction?) {
        self.title = title
        self.action = action
        self.style = style
    }
}

protocol IKPopupProtocol {
    static func create() -> IKPopup?
    static func create(_ name : String) -> IKPopup?
    
    func show()
    func dismiss()
    func dismiss(completion : (() -> Void)?)
}

class IKPopup : NSObject, IKPopupProtocol, IKPopupViewBtnActionProtocol {

    
    private var isBlurBackground: Bool = false
    
    private lazy var window = IKWindow()
    private lazy var actions = [IKPopupAction]()
    
    static func create() -> IKPopup?{
        guard let view = create("IKPopupView") else {
            return nil
        }
        return view
    }
    static func create(_ name: String) -> IKPopup? {
        guard let popupView = IKPopupView.load(name) else {
            return nil
        }
        let popup = IKPopup()
        print(CFGetRetainCount(popupView))
        popup.window.rootViewController = IKPopupVC()
        popup.window.view = popupView
        print(CFGetRetainCount(popupView))
        popupView.delegate = popup as IKPopupViewBtnActionProtocol
        return popup
    }
    @objc fileprivate func didTouchBtnAction(_ sender : UIButton) {
        let actionResults = self.actions.filter { (action) -> Bool in
            if sender.isConfirmType == true {
                return action.style == .Confirm
            } else {
                if sender.isCancelType == true {
                    return action.style == .Cancel
                }
            }
            return false
        }
        for ac in actionResults {
            ac.action!(ac,self)
        }
    }
    
    func IKPopupViewDidTouchButtonAction(sender: UIButton) {
        didTouchBtnAction(sender)
    }
    
    func blurBackground() -> IKPopup {
        self.isBlurBackground = true
        return self
    }
    
    func addTitle(_ title : String?) -> IKPopup {
        self.window.view?.titleLabel?.text = title
        return self;
    }
    
    func addMessage(_ message : String?) -> IKPopup {
        self.window.view?.mesageLabel?.text = message
        return self;
    }
    func addTitle(_ title : String?, withMessage message : String?) -> IKPopup {
        self.window.view?.titleLabel?.text = title
        self.window.view?.mesageLabel?.text = message
        return self;
    }
    
    func addAction(action : @escaping () -> IKPopupAction) -> IKPopup{
        let popAction = action()
        self.actions.append(popAction)
        if let result =  self.window.view?.subviews
            .filter({ guard let btn = $0 as? UIButton else { return false }
                if popAction.style == .Cancel, btn.isCancelType == true {
                    return true
                } else if popAction.style == .Confirm, btn.isConfirmType == true{
                    return true
                } else { return false }})
            .map({$0 as? UIButton}) {
            for btn in result {
                btn?.setTitle(popAction.title, for: .normal)
            }
        }
        return self
    }
    
    func show() {
        if IKPopupManager.queue.enQueue(self.window) == false { return }
        self.window.makeKeyAndVisible()
        
        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: .allowUserInteraction, animations: {
            self.window.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            self.window.view?.alpha = 0.0;
            self.window.view?.center = (self.window.popupVC?.view.center)!
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6/3, animations: {
                self.window.popupVC?.view.addSubview(self.window.view!)
            })
            UIView.addKeyframe(withRelativeStartTime: (0.6/3)*2, relativeDuration: 0.6/3, animations: {
                self.window.view?.alpha = 0.6;
            })
            UIView.addKeyframe(withRelativeStartTime: (0.6/3)*3, relativeDuration: 0.6/3, animations: {
                self.window.view?.alpha = 1.0;
            })
        }) { (isCompleted) in
            
        }
    }
    
    func dismiss() {
        self.dismiss(completion: nil)
    }
    
    func dismiss(completion: (() -> Void)?) {
        if let window =  IKPopupManager.queue.deQueue(self.window), window == self.window {
            
            UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: .allowUserInteraction, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6/3, animations: {
                    self.window.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                    var point = (self.window.popupVC?.view.center)!
                    point.y -= ((self.window.frame.height) * 1.0)
                    self.window.view?.center = point
                })
                UIView.addKeyframe(withRelativeStartTime: (0.6/3)*2, relativeDuration: 0.6/3, animations: {
                    self.window.backgroundColor = UIColor.black.withAlphaComponent(0.25)
                })
                UIView.addKeyframe(withRelativeStartTime: (0.6/3)*3, relativeDuration: 0.6/3, animations: {
                    self.window.backgroundColor = UIColor.black.withAlphaComponent(0.0)
                })
            }) { (isCompleted) in
                window.resignKeyAndUnvisible()
            }
        }
    }
}
class IKPopupManager {
    static var queue = QueueDoubleStack<IKWindow>()
}

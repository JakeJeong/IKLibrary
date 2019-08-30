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

class IKPopup : IKPopupProtocol {
    
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
        return popup
    }
    func blurBackground() -> IKPopup {
        self.isBlurBackground = true
        return self
    }
    
    func addAction(action : @escaping () -> IKPopupAction) -> IKPopup{
        let popAction = action()
        self.actions.append(popAction)
        return self
    }
    
    func show() {
        if IKPopupManager.queue.enQueue(self.window) == false { return }
        self.window.makeKeyAndVisible()
        
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: .allowUserInteraction, animations: {
            self.window.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            self.window.view?.alpha = 0.0;
            self.window.view?.center = (self.window.popupVC?.view.center)!
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.8/3, animations: {
                self.window.popupVC?.view.addSubview(self.window.view!)
            })
            UIView.addKeyframe(withRelativeStartTime: (0.8/3)*2, relativeDuration: 0.8/3, animations: {
                self.window.view?.alpha = 0.6;
            })
            UIView.addKeyframe(withRelativeStartTime: (0.8/3)*3, relativeDuration: 0.8/3, animations: {
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
            UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: .allowUserInteraction, animations: {
                self.window.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            }) { (isCompleted) in
                window.resignKeyAndUnvisible()
                if completion != nil {
                    completion!()
                }
            }
        }
    }
}
class IKPopupManager {
    static var queue = QueueDoubleStack<IKWindow>()
}

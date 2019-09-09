//
//  Popup.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 09/09/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import Foundation
import UIKit

class Popup {
    class func openSheetPopup() {
        IKPopup.create("SheetPopup")?.addMessage("이건 뭘까요?")
            .addAction { () -> IKPopupAction in
                return IKPopupAction(
                    title: "Confirm",
                    style: .Confirm,
                    action: { (action, popup) in
                        print("action!!! -> \(action.title!)")
                        popup.dismiss()
                })
            }
            .addAction { () -> IKPopupAction in
                return IKPopupAction(
                    title: "Cancel",
                    style: .Cancel,
                    action: { (action, popup) in
                        popup.dismiss(completion: {
                            print("action!!! -> \(action.title!)")
                        })
                })
            }
            .addAction { () -> IKPopupAction in
                return IKPopupAction(
                    title: "ETC",
                    style: .Other,
                    action: { (action, popup) in
                        popup.dismiss(completion: {
                            print("action!!! -> \(action.title!)")
                        })
                })
            }
            .blurBackground()
            .show()
    }
    class func openCustomPopup() {
        IKPopup.create("CustomPopupView")?.addTitle("CustomPopupView", withMessage: "Custom Popup in Message")
            .addAction { () -> IKPopupAction in
                return IKPopupAction(
                    title: "Confirm",
                    style: .Confirm,
                    action: { (action, popup) in
                        print("action!!! -> \(action.title!)")
                        popup.dismiss()
                })
            }
            .addAction { () -> IKPopupAction in
                return IKPopupAction(
                    title: "Cancel",
                    style: .Cancel,
                    action: { (action, popup) in
                        popup.dismiss(completion: {
                            print("action!!! -> \(action.title!)")
                        })
                })
            }
            .blurBackground()
            .show()
    }
    class func openIKPopup() {
        IKPopup.create()?.addTitle("this is title", withMessage: "this is message")
            .addAction { () -> IKPopupAction in
                return IKPopupAction(
                    title: "OK",
                    style: .Confirm,
                    action: { (action, popup) in
                        print("action!!! -> \(action.title!)")
                        popup.dismiss()
                })
            }
            .addAction { () -> IKPopupAction in
                return IKPopupAction(
                    title: "Cancel",
                    style: .Cancel,
                    action: { (action, popup) in
                        popup.dismiss(completion: {
                            print("action!!! -> \(action.title!)")
                        })
                })
            }
            //            .blurBackground()
            .show()
    }
    class func openAttributedStringPopup() {
        IKPopup.create()?
            .addTitle(
                NSAttributedString.init(string: "Title",
                                        attributes:
                    [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22.0),
                     NSAttributedString.Key.foregroundColor:UIColor.darkGray])
            )
            //            .updateSize(width: 300, height: 200)
            .addAction { () -> IKPopupAction in
                return IKPopupAction(
                    title: "EditSize",
                    style: .Confirm,
                    action: { (action, popup) in
                        print("action!!! -> \(action.title!)")
                        
                        _ = popup.updateSize(width: 300, height: 200, animation: true)
                        self.openIKPopup()
                })
            }
            .addAction { () -> IKPopupAction in
                return IKPopupAction(
                    title: "Cancel",
                    style: .Cancel,
                    action: { (action, popup) in
                        popup.dismiss(completion: {
                            print("action!!! -> \(action.title!)")
                        })
                })
            }
            //            .blurBackground()
            .show()
    }
}

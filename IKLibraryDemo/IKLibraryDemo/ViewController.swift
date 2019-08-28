//
//  ViewController.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 28/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    weak var lastPopup : IKPopup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
     openPopup()
    }
    func openPopup() {
        IKPopup()
            .create()
            .bindComponent(IKPopupComponent(title: "Demo", mesage: "알려드립니다."))
            .addPopupAction { () -> IKPopupAction in
                return IKPopupAction.init(title: "확인", style: .OK, action: { (action, popup) in
                    print("OK Action")
                    popup.dismiss(completion: {
                        print("OK After Dismiss")
                        print("Popup - \(popup)")
                    })
                })
            }
            .addPopupAction { () -> IKPopupAction in
                return IKPopupAction.init(title: "취소", style: .Cancel, action: { (action, popup) in
                    print("Cancel Action")
                    popup.dismiss()
                })
            }
            .show()
    }
    
    @IBAction func didTouchPopupAction(sender : Any) {
       openPopup()
    }
}


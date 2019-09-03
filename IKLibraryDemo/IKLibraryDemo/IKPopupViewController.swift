//
//  ViewController.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 28/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import UIKit



class IKPopupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
      
    }
    func openPopup() {
        IKPopup.create()?.addTitle("제목", withMessage: "메세지")
            .addAction { () -> IKPopupAction in
                return IKPopupAction(
                    title: "확인",
                    style: .Confirm,
                    action: { (action, popup) in
                        print("action!!! -> \(action.title!)")
                        popup.dismiss()
                })
            }
            .addAction { () -> IKPopupAction in
                return IKPopupAction(
                    title: "취소",
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
    
    @IBAction func didTouchPopupAction(sender : Any) {
        openPopup()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


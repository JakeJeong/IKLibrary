//
//  ViewController.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 28/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        IKPopup.create()?
            .addAction { () -> IKPopupAction in
                return IKPopupAction(
                    title: "확인",
                    style: .OK,
                    action: { (action, popup) in
                        popup.dismiss(completion: {
                            print("dismiss")
                            print(IKPopupManager.queue)
                        })
                })
            }
            .blurBackground()
            .show()
    }
    func openPopup() {
        
    }
    
    @IBAction func didTouchPopupAction(sender : Any) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


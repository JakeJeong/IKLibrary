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
    
//     openPopup()
        
        IKPopupManager.shared.push(popup: IKPopup())
        IKPopupManager.shared.push(popup: IKPopup())
        IKPopupManager.shared.push(popup: IKPopup())
        IKPopupManager.shared.push(popup: IKPopup())
        
        // Do any additional setup after loading the view.
        
        // Add UIImageView on view
        self.view.addSubview(self.imageView)
        
        // Add UIButton on view
        self.view.addSubview(self.button)
        
        self.view.addSubview(self.button2)
        
        makeWindow()
        
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
       IKPopupManager.shared.lastPop()
    }
    
    
    lazy var window: UIWindow = {
        let w = UIWindow()
        // Set the background to white.
        w.backgroundColor = UIColor.white
        w.frame = CGRect(x: 0, y: 0, width: 200, height: 250)
        w.layer.position = CGPoint(x:self.view.frame.width/2, y:self.view.frame.height/2)
        w.alpha = 0.8
        w.layer.cornerRadius = 20
        
        // Set window to keyWindow.
        w.makeKey()
        
        // Display window.
        w.makeKeyAndVisible()
        
        w.isHidden = true
        
        return w
    }()
    
    lazy var windowButton: UIButton = {
        // Create a button.
        let b = UIButton()
        b.frame = CGRect(x: 0, y: 0, width: 100, height: 60)
        b.backgroundColor = UIColor.orange
        b.setTitle("Close", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.masksToBounds = true
        b.layer.cornerRadius = 20.0
        b.layer.position = CGPoint(x: self.window.frame.width/2, y: self.window.frame.height-50)
        b.addTarget(self, action: #selector(onClickButton(sender:)), for: .touchUpInside)
        
        return b
    }()
    
    lazy var button: UIButton = {
        // Create a button.
        let b = UIButton()
        b.frame = CGRect(x:0, y:0, width:60, height:60)
        b.backgroundColor = UIColor.red
        b.setTitle("Dialog", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.masksToBounds = true
        b.layer.cornerRadius = 30.0
        b.layer.position = CGPoint(x:self.view.frame.width/2, y:self.view.frame.height-100)
        b.addTarget(self, action: #selector(onClickButton(sender:)), for: .touchUpInside)
        return b
    }()
    
    lazy var button2: UIButton = {
        // Create a button.
        let b = UIButton()
        b.frame = CGRect(x:0, y:0, width:60, height:60)
        b.backgroundColor = UIColor.orange
        b.setTitle("Dialog", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.masksToBounds = true
        b.layer.cornerRadius = 30.0
        b.layer.position = CGPoint(x:(self.view.frame.width/2)+100, y:self.view.frame.height-100)
        b.addTarget(self, action: #selector(onClickButton(sender:)), for: .touchUpInside)
        
        return b
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView(image: self.image)
        // Calculate the scale of the image.
        let scale = self.view.frame.width / self.image.size.width
        iv.frame = CGRect(x: 0, y: 50, width: self.image.size.width*scale, height: self.image.size.height*scale)
        return iv
    }()
    
    // Set the image on the background.
    lazy var image: UIImage = UIImage(named: "vertical.jpeg")!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Create your own window
    func makeWindow(){
        // Create a TextView.
        let textView: UITextView = UITextView(frame: CGRect(x: 10, y: 10, width: self.window.frame.width - 20, height:150))
        textView.backgroundColor = UIColor.clear
        textView.text = "I won’t go into details about recording a video or taking a photo, this article focuses on the UI part of building a custom camera. Hopefully, I will write an article about recording videos and taking photos soon."
        textView.font = UIFont.systemFont(ofSize: 15.0)
        textView.textColor = UIColor.black
        textView.textAlignment = NSTextAlignment.left
        textView.isEditable = false
        
        self.window.addSubview(self.windowButton)
        self.window.addSubview(textView)
    }
    
    
    // Button event
    @objc func onClickButton(sender: UIButton) {
        if sender == self.windowButton {

            let vc = UIViewController.init()
            vc.loadViewIfNeeded()
            vc.view.backgroundColor = UIColor.yellow
            present(vc, animated: true, completion: nil)
        } else if sender == self.button {
            self.window.isHidden = false
            print(self.window)
        } else if sender == self.button2 {
            self.window.isHidden = true
            self.window.resignKey()
            print(self.window)
        }
    }

}


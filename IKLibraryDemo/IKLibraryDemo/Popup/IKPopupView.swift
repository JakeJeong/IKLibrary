//
//  IKPopupView.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 28/08/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import UIKit

typealias IKPopupViewTouchAction = (IKPopupView) -> Void

protocol IKPopupViewProtocol {
    static func load(_ name : String)-> IKPopupView?
    static func load()-> IKPopupView?
}

protocol IKPopupViewActionDelegate {
    func IKPopupViewDidTouchButtonAction(sender : UIButton)
}

class IKPopupView : UIView, IKPopupViewProtocol {
    @IBOutlet weak var titleLabel : UILabel?
    @IBOutlet weak var mesageLabel : UILabel?
    
    @IBOutlet weak var okBtn : UIButton?
    @IBOutlet weak var cancelBtn : UIButton?
    
//    var okAction : IKPopupViewTouchAction!
//    var cancelAction : IKPopupViewTouchAction!
    
    var delegate : IKPopupViewActionDelegate?
    
    private var _identifier : String? = nil
    var identifier : String {
        get {
            if _identifier == nil {
                _identifier = UUID.init().uuidString
            }
            return _identifier!
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let result =  self.subviews
            .filter{$0 is UIButton}
            .map{$0 as? UIButton}
        
        for btn in result {
            btn?.addTarget(self, action:#selector(didTouchBtnAction(sender:)), for: .touchUpInside)
        }
        
    }
    
    @objc fileprivate func didTouchBtnAction(sender : UIButton)  {
        self.delegate?.IKPopupViewDidTouchButtonAction(sender: sender)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
//    func okAction(action : @escaping IKPopupViewTouchAction) {
//        self.okAction = action
//    }
//    func cancelAction(action : @escaping IKPopupViewTouchAction) {
//        self.cancelAction = action
//    }
    
//    @IBAction func didTouchOKAction(sender : Any) {
//        guard let action = self.okAction else {
//            return;
//        }
//        action(self)
//    }
//    @IBAction func didTouchCancelAction(sender : Any) {
//        guard let action = self.cancelAction else {
//            return;
//        }
//        action(self)
//    }
    
    static func load(_ name: String) -> IKPopupView? {
        guard let view = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as? IKPopupView else {
            return nil;
        }
        return view
    }
    
    static func load() -> IKPopupView?{
        guard let view = Bundle.main.loadNibNamed("IKPopupView", owner: self, options: nil)?.first as? IKPopupView else {
            return nil;
        }
        return view
        
    }
}

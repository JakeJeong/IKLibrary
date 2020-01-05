//
//  String+IKExtention.swift
//  IKLibraryDemo
//
//  Created by ikjeong.dev on 2020/01/06.
//  Copyright © 2020 JakeJeong. All rights reserved.
//

import Foundation


extension String {
    var isEmpty : Bool {
        get {
            if (self.count == 0){
                return true
            }
            return false
        }
    }
    
    private static let koreanFormat = ".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*"
    var isKorean : Bool {
        get {
            if (self.count == 0){
                return false
            }
            let checkp = NSPredicate.init(format: "SELF MATCHES %@", String.koreanFormat)
            return checkp.evaluate(with: self)
        }
    }
    
    private static let onlyEnglishFormat = "^[a-zA-Z0-9 !@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?~`\\n]*$"
    var isOnlyEng : Bool {
        get {
            if (self.count == 0){
                return false
            }
            let checkp = NSPredicate.init(format: "SELF MATCHES %@", String.onlyEnglishFormat)
            return checkp.evaluate(with: self)
        }
    }
    
    
    var isURLType : Bool {
        get {
            if (self.count == 0){
                return false
            }
            var isFindReturnType = false
            do {
                let dataDetect = try NSDataDetector.init(types: NSTextCheckingResult.CheckingType.link.rawValue)
                let matchResults =  dataDetect.matches(in: self, options: .reportCompletion, range: NSRange.init(location: 0, length: self.count))
                for obj in matchResults {
                    if (obj.resultType == NSTextCheckingResult.CheckingType.link){
                        isFindReturnType = true
                    }
                }
            }
            catch {
                print(error)
            }
            return isFindReturnType
        }
    }
    
    var findURL : URL? {
        get {
            var _findURL : URL?
            if (self.count == 0){
                return _findURL
            }
            do {
                let dataDetect = try NSDataDetector.init(types: NSTextCheckingResult.CheckingType.link.rawValue)
                let matchResults =  dataDetect.matches(in: self, options: .reportCompletion, range: NSRange.init(location: 0, length: self.count))
                for obj in matchResults {
                    if (obj.resultType == NSTextCheckingResult.CheckingType.link){
                        _findURL = obj.url
                    }
                }
            }
            catch {
                print(error)
            }
            return _findURL
        }
    }
}

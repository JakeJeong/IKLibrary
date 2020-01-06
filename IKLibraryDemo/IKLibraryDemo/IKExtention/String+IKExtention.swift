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
    
    private static func checkRegex(string : String, format : String) -> Bool {
        let checkp = NSPredicate.init(format: "SELF MATCHES %@", format)
        return checkp.evaluate(with: string)
    }
    
    var isKorean : Bool {
        get {
            if (self.count == 0){
                return false
            }
            return String.checkRegex(string: self,
                                     format: ".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")
        }
    }
    
    var isOnlyEng : Bool {
        get {
            if (self.count == 0){
                return false
            }
             return String.checkRegex(string: self,
                                      format: "^[a-zA-Z0-9 !@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?~`\\n]*$")
        }
    }

    var isHTML : Bool {
        get {
            if (self.count == 0){
                return false
            }
            return String.checkRegex(string: self,
                                     format: "<s*[a-zA-Z0-9][^>]*>(.*?)<[/]+?s*[a-zA-Z0-9][^>]*>")
        }
    }
    
    var isValidKoreanPhoneNumber : Bool {
        get {
            if (self.count == 0){
                return false
            }
            let phoneNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
            var someRegex : String
            if (phoneNumber.hasPrefix("010")) {
                if (phoneNumber.count != 11) {
                    return false
                }
                someRegex = "^010+([0-9]{4})+([0-9]{4})$"
            } else {
                if phoneNumber.count < 10 {
                    return false
                }
                someRegex = "^01([1|6|7|8|9]?)+([0-9]{3,4})+([0-9]{4})$"
            }
            return String.checkRegex(string: phoneNumber,
                                     format: someRegex)
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
    
    var isNumeric : Bool {
        get {
            if (self.count == 0){
                return false
            }
            let sc = Scanner.init(string: self)
            sc.charactersToBeSkipped = .punctuationCharacters
            var value : Float = 0
            while sc.scanFloat(&value) {
                print(value)
            }
            return sc.isAtEnd
        }
    }
    
    static func PersonName(familyName : String?, givenName : String?) -> String {
        var components =  PersonNameComponents.init()
        components.familyName = familyName
        components.givenName = givenName
        return PersonNameComponentsFormatter.localizedString(from: components, style: .default, options: .init())
    }
    
    static func PersonName(firstName : String?, lastName : String?) -> String {
        return PersonName(familyName: lastName, givenName: firstName)
    }
}

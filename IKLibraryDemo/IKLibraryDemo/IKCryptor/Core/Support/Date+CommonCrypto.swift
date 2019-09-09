//
//  Date+CommonCrypto.swift
//  IKLibraryDemo
//
//  Created by JakeJeong on 09/09/2019.
//  Copyright © 2019 JakeJeong. All rights reserved.
//

import Foundation

import CommonCrypto

extension Data {
    func dataEncrypted(algorithm : CCAlgorithm, key : Any, error : CCCryptorStatus) -> Data {
        
    }
    
    func dataEncrypted(algorithm : CCAlgorithm, key : Any, initializationVector iv : Any, option : CCOptions , error : CCCryptorStatus) -> Data {
        var cryptor : CCCryptorRef? = nil
        var status : CCCryptorStatus = CCCryptorStatus(kCCSuccess)
        
        var keydata, ivData : NSMutableData
        
        if let data = key as? Data {
            keydata = NSMutableData.init(data: data)
        } else {
            keydata = NSMutableData.init(data: (key as! String).data(using: .utf8)!)
        }
        
        if let _iv = iv as? String {
            ivData = NSMutableData(data: _iv.data(using: .utf8)!)
        } else {
            ivData = NSMutableData(data: iv as! Data)
        }
        
        Data.FixKeyLengths(algorithm,keydata,ivData)
        
        status = CCCryptorCreate(CCOperation(kCCEncrypt), algorithm, option, keydata.bytes, keydata.length, ivData.bytes, &cryptor)
        
        
    }
    
    fileprivate func runCryptor(cryptor : CCCryptorRef, result : CCCryptorStatus) {
        
        
        var selfLength = (self as! NSMutableData)
        
        var bufSize = CCCryptorGetOutputLength(cryptor, selfLength.length, true)
        var buf = malloc(bufSize)
        var bufused : size_t = 0
        var byteTotal : size_t = 0
        
        result = CCCryptorUpdate(cryptor, selfLength.bytes, selfLength.length, buf, bufSize, &bufused)
        
        
    }
    
    
    static func FixKeyLengths( _ algorithm : CCAlgorithm, _ keydata : NSMutableData , _ ivData : NSMutableData ) {
        
        let keyLength = keydata.length
        
        switch Int(algorithm) {
        case kCCAlgorithmAES128:
            if keyLength < 16 {
                keydata.length = 16
            } else if keyLength < 24 {
                keydata.length = 24
            } else {
                keydata.length = 32
            }
            break
        case kCCAlgorithmDES :
            keydata.length = 8
            break
        case kCCAlgorithm3DES :
            keydata.length = 24
            break
        case kCCAlgorithmCAST :
            if keyLength < 5 {
                keydata.length = 5
            } else if keyLength > 16 {
                keydata.length = 16
            }
            break
        case kCCAlgorithmRC4 :
            if keyLength > 512 {
                keydata.length = 512
            }
            break
        default: break
        }
        ivData.length = keydata.length
    }
    
}

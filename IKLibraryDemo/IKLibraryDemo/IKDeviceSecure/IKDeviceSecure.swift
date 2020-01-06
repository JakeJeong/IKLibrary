//
//  IKDeviceSecure.swift
//  IKLibraryDemo
//
//  Created by ikjeong.MCC on 2020/01/06.
//  Copyright © 2020 JakeJeong. All rights reserved.
//

import Foundation

class IKDeviceSecure : NSObject {
    @inline(__always) static func check() {
        checkJailbreakSymlinks()
        checkJailbreakFiles()
        checkReadWritePermissions()
    }
    
    @inline(__always) private static func checkJailbreakSymlinks() {
        
    }
    
    @inline(__always) private static func checkJailbreakSymLink(checkPath : String) {
        
    }
   
    @inline(__always) private static func checkJailbreakFiles() {
        
    }
    
    @inline(__always) private static func checkJailbreakFile(checkPath : String) {
        
    }
    
    @inline(__always) private static func checkReadWritePermissions() {
        
    }
    
    @inline(__always) private static func foundJailbrokenDevice() {
        
    }
}

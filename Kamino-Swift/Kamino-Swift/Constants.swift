//
//  Constants.swift
//  Kamino-Swift
//
//  Created by Pero Sechkov on 3/10/20.
//  Copyright © 2020 ECHO. All rights reserved.
//

import Foundation


struct Constants {
    
    static let kApplicationJson = "application/json"
    
    
    struct Keys {
        static let kApiKey = "APIAccessKey"
        static let kAuthorization = "Authorization"
        static let kContentType = "Content-Type"
        
        static let kAdType = "AdType"
        static let kDeviceId = "DeviceId"
        static let kAdId = "AdId"
    }
    
    struct Endpoints {
        static let kGetAd = "GetAd"
        static let kRegisterAdClick = "RegisterAdClick"
        static let kRegisterAdImpression = "RegisterAdImpression"
    }
}

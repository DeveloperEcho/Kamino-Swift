//
//  Advertise.swift
//  Kamino-Swift
//
//  Created by Pero Sechkov on 3/10/20.
//  Copyright © 2020 ECHO. All rights reserved.
//

import Foundation

public typealias CompletitionCallBack = ((_ success: Bool, _ responseObject: [String:Any]?,_ statusCode : Int?)-> ())?

public class Advertise : NSObject {
    
    static let sharedInstance = Advertise()
    
    //BASE URL
    public var baseURl : String!
    
    // API ACCESSS KEY
    public var apiAccessKey : String!
    
    
    func makeRequest(url : URL,parameters : [String:Any],completition : CompletitionCallBack) {
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue(Constants.kApplicationJson, forHTTPHeaderField: Constants.Keys.kContentType)
        request.setValue(self.apiAccessKey, forHTTPHeaderField: Constants.Keys.kApiKey)
        
        do {
            request.httpBody =  try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            completition!(false,nil,nil)
        }
        
        let postDataTask = session.dataTask(with: request) { (responseData , response, error) in
            var statusCode : Int?
            if let httpResponse = response as? HTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            if let data = responseData {
                let responseDict : [String:Any] = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
                if statusCode != 200 {
                    completition!(false,responseDict,statusCode)
                } else {
                    completition!(true,responseDict,statusCode)
                }
            } else {
                completition!(false,nil,statusCode)
            }
        }
        postDataTask.resume()
    }
    
    public func getAdd(type : Int,deviceId : String,completition : CompletitionCallBack) {
        let urlString = String.init(format: "%@%@",self.baseURl,Constants.Endpoints.kGetAd)
        let url = URL(string: urlString)!
        let parameters : [String:Any] = [Constants.Keys.kAdType : type,Constants.Keys.kDeviceId:deviceId]
        self.makeRequest(url: url, parameters: parameters) { (sucess,responseDict, statusCode) in
            completition!(sucess,responseDict, statusCode)
        }
    }
    
    
    public func registerAddClick(adId : String,deviceId : String,completition : CompletitionCallBack) {
        let urlString = String.init(format: "%@%@",self.baseURl,Constants.Endpoints.kRegisterAdClick)
        let url = URL(string: urlString)!
        let parameters : [String:Any] = [Constants.Keys.kAdId : adId,Constants.Keys.kDeviceId:deviceId]
        self.makeRequest(url: url, parameters: parameters) { (sucess,responseDict, statusCode) in
            completition!(sucess,responseDict, statusCode)
        }
    }
    
    public func registerAdImpression(adId : String,deviceId : String,completition : CompletitionCallBack) {
        let urlString = String.init(format: "%@%@",self.baseURl,Constants.Endpoints.kRegisterAdImpression)
        let url = URL(string: urlString)!
        let parameters : [String:Any] = [Constants.Keys.kAdId : adId,Constants.Keys.kDeviceId:deviceId]
        self.makeRequest(url: url, parameters: parameters) { (sucess,responseDict, statusCode) in
            completition!(sucess,responseDict, statusCode)
        }
    }
}

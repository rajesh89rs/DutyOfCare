//
//  DOCRegistrationManager.swift
//  DutyOfCareSDK
//
//  Created by Rajesh RAMSHETTY SIDDARAJU on 12/12/18.
//  Copyright © 2018 cytric. All rights reserved.
//

import UIKit

class DOCRegistrationManager: NSObject {
    
    func registerUser(params: [String: String], _ completion: @escaping (_ success: Bool) -> Void) {
        if let userGuid = params["userGuid"], let userId = params["userId"], let clientId = params["clientId"] {
            getAuthToken(userGuid: userGuid, userId: userId, clientId: clientId, { (token) in
                if let token = token {
                    let registerParams = ["token": token, "userGuid": userGuid, "email": params["email"]]
                    DOCNetworkRequests().registerUser(params: registerParams as Parameters, completion: { (responseData) in
                        if let responseData = responseData, let responseObject = responseData.jsonData {
                            print(responseObject)
                            completion(true)
                            return
                        }
                        completion(false)
                        return
                    })
                }
            })
        } else {
            completion(false)
        }
    }
    
    func getAuthToken(userGuid: String, userId: String, clientId: String, _ completion: @escaping (_ token: String?) -> Void) {
        var params: [String: Any] = [:]
        params["User_GUID"] = userGuid;
        params["clientId"] = clientId;
        params["userId"] = userId;
        DOCNetworkRequests().getAuthToken(params: params) { (responseData) in
            if let responseData = responseData, let responseObject = responseData.jsonData, let token = responseObject["token"] as? String {
                print(responseObject)
                completion(token)
                return
            }
            completion(nil)
            return
        }
    }
}

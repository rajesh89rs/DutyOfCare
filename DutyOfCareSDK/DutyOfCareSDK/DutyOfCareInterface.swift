//
//  DutyOfCareInterface.swift
//  DutyOfCareSDK
//
//  Created by Rajesh RAMSHETTY SIDDARAJU on 06/12/18.
//  Copyright © 2018 cytric. All rights reserved.
//

import Foundation
//import Alamofire

@objc public class DutyOfCareInterface: NSObject {
    
    //To do : api to set server URL
    
    public func registerUser(userGuid: String, userId: String, clientId: String, email: String, _ completion: @escaping (_ success: Bool) -> Void) {
        DOCRegistrationManager().registerUser(params: ["userGuid": userGuid, "userId": userId, "clientId": clientId, "email":  email]) { (succ) in
            completion(succ)
        }
    }
    
}

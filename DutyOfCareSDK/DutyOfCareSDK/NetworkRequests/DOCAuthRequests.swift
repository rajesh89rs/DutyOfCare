//
//  DOCAuthRequests.swift
//  DutyOfCareSDK
//
//  Created by Rajesh RAMSHETTY SIDDARAJU on 12/12/18.
//  Copyright © 2018 cytric. All rights reserved.
//

import UIKit

extension DOCNetworkRequests {

    func registerUser(params: Parameters, completion: @escaping (_ response: DataResponse?) -> Void) {
        
        var requestParams = params
        var headers: [String: String] = [:]
        if let token = requestParams.removeValue(forKey: "token") as? String {
            headers["Authorization"] = token
        }
        self.postRequest(url: RegistrationItems.registrationUrl, params: requestParams, headers: headers) { (response) in
            completion(response)
        }
    }
    
    func testApi(params: Parameters, completion: @escaping (_ response: DataResponse?) -> Void) {
        self.postRequest(url: RegistrationItems.testRegistrationUrl, params: params) { (response) in
            completion(response)
            return
        }
    }
    
    func getAuthToken(params: Parameters, completion: @escaping (_ response: DataResponse?) -> Void) {
        self.postRequest(url: RegistrationItems.getTokenUrl, params: params) { (response) in
            completion(response)
            return
        }
    }
    
}

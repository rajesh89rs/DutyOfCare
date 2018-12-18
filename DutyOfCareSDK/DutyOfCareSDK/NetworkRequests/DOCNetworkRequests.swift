//
//  CMCNetworkRequests.swift
//  DutyOfCareSDK
//
//  Created by Rajesh RAMSHETTY SIDDARAJU on 11/12/18.
//  Copyright © 2018 cytric. All rights reserved.
//

import UIKit
//import Alamofire

/// A dictionary of parameters to apply to a `URLRequest`.
public typealias Parameters = [String: Any]

public enum NetworkError: Error {
    case serverError
}

public class DOCNetworkRequests: NSObject {
    
    
    let statementHeaders = [
        "Content-Type": "application/json",
        "cache-control": "no-cache"
    ]
    
    func postRequest(url:String, params: Parameters, headers: [String: String]? = [:], completion: @escaping (_ response: DataResponse?) -> Void) {
    
        guard let url = URL(string: url) else { return }
        print(url.absoluteString)
        print(params)
        var request = URLRequest(url: url)
        var requestHeaders = statementHeaders
        if let headers = headers, headers.count > 0 {
            requestHeaders = headers.merging(requestHeaders) { $1 }
        }
        print(requestHeaders)
        request.allHTTPHeaderFields = requestHeaders
        
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(nil)
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            let response = response as? HTTPURLResponse
            let dataresponse = DataResponse(request: request, response: response, data: responseData, error: responseError)
            completion(dataresponse)
            return
        }
        task.resume()
    }
    
}



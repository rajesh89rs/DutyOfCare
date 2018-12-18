//
//  Response.swift
//  DutyOfCareSDK
//
//  Created by Rajesh RAMSHETTY SIDDARAJU on 17/12/18.
//  Copyright © 2018 cytric. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case networkError
    case serverError
    case authError
    case unknownError
    case jsonParseError
    case badRequestError
}

public struct DataResponse {
    /// The URL request sent to the server.
    public let request: URLRequest?
    
    /// The server's response to the URL request.
    public let response: HTTPURLResponse?
    
    /// The data returned by the server.
    public let data: Data?
    
    public var jsonData: [String : Any]?
    
    public var error: Error?
    
    /// Creates a `DataResponse` instance with the specified parameters derived from response serialization.
    ///
    /// - parameter request:  The URL request sent to the server.
    /// - parameter response: The server's response to the URL request.
    /// - parameter data:     The data returned by the server.
    
    /// - returns: The new `DataResponse` instance.
    public init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?)
    {
        self.request = request
        self.response = response
        self.data = data
        self.error = error
        if let response = response {
            switch(response.statusCode) {
            case 0: self.error = APIError.networkError
                break
            case 200..<300: self.error = nil
                do {
                    if let data = data, let responseJson = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]  {
                        self.jsonData = responseJson
                    }
                } catch {
                    print(error.localizedDescription)
                    self.error = APIError.jsonParseError
                }
                break
            case 400: self.error = APIError.badRequestError
                break
            case 500: self.error = APIError.serverError
                break
            default:  self.error = APIError.unknownError
                break
            }
        }
    }
    
    
}

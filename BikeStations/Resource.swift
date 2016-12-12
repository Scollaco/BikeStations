//
//  Resource.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 12/9/16.
//  Copyright © 2016 Green. All rights reserved.
//

import Foundation

public typealias Headers = [String: String]

public struct Resource {
    
    public let path: String
    public let method: Method
    
    var finalUrl : URL {
        let urlString = BASE_URL + path
        return URL.init(string: urlString)!
    }
}

public enum Method: String {
    case GET
    case POST
}

extension Resource {
    
    public func request(_ baseURL: String) -> URLRequest {
        
        let request = NSMutableURLRequest(url: finalUrl)
        request.httpMethod = method.rawValue
        
        return request as URLRequest
    }
}

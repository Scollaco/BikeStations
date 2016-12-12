//
//  WebService.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 12/9/16.
//  Copyright © 2016 Green. All rights reserved.
//

import Foundation

protocol Connectable {
    func makeConnection(_ resource: Resource, completion: @escaping (Result<Any?, ErrorType>) -> Void)
}

final class WebService {
    
    fileprivate let session: URLSession
    
    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }
}

extension WebService: Connectable {
    
    func makeConnection(_ resource: Resource, completion: @escaping (Result<Any?, ErrorType>) -> Void) {
        
        let request = resource.request(BASE_URL)
        
        session.dataTask(with: request) { (data, response, error) in
            switch (data, error) {
            case(let data?, _):
                completion(.success(Parser().parse(data)))
            case(_, let error?):
                completion(.failure(.network(error)))
            default: break
            }
            }.resume()
    }
}

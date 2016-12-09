//
//  WebService.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 12/9/16.
//  Copyright © 2016 Green. All rights reserved.
//

import Alamofire
import Foundation

final class WebService {

    func get<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
     
        URLSession.shared.dataTask(with: resource.url as URL) { (data, urlResponse, error) in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            completion(resource.parse(data))
        }.resume()
    }
}

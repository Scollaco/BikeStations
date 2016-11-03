//
//  BikeStationController.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import Alamofire

protocol BikeStationClientProtocol {

    func getBikeStations(completion : @escaping  BikeStationCompletion)
}

typealias BikeStationCompletion = ([BikeStation]?, String?) -> Void

class BikeStationController: NSObject, BikeStationClientProtocol {
    
    var bikeStations : [BikeStation]! = []
    let bikeStationsEndPoint = "gbfs/en/station_information.json"
    
    
    func getBikeStations(completion : @escaping BikeStationCompletion) {
        
        let urlString  = BASE_URL + bikeStationsEndPoint
        let url = URL.init(string: urlString)
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            guard let json = response.result.value as? [String:AnyObject] else {
                
                completion(nil, unknownErrorMessage)
                return
            }
            
            let stations : [Any]? = json["data"]?["stations"] as? [Any]
            
            self.bikeStations = stations!.flatMap({ dictionary  in
                return BikeStation.init(dictionary: dictionary as! [String : Any])
            })
            
            completion (self.bikeStations, nil)
        }
    }
}

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
    
    func getBikeStations(completion : @escaping  BikeStationsCompletion)
    func getBikeStationInfo(stationId: String, completion : @escaping UniqueStationCompletion)
}

typealias BikeStationsCompletion = (Result<[BikeStation], ErrorType>) -> Void
typealias UniqueStationCompletion = (Result<BikeStation, ErrorType>) -> Void


class BikeStationController: NSObject, BikeStationClientProtocol {
    
    var bikeStations : [BikeStation]! = []
    
    func getBikeStations(completion : @escaping BikeStationsCompletion) {
        
        let url = urlWith(string: "gbfs/en/station_information.json")
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            guard let json = response.result.value as? [String:AnyObject] else {
                
                completion(.failure(response.result.error!))
                return
            }
            
            let stations : [Any]? = json["data"]?["stations"] as? [Any]
            
            self.bikeStations = stations!.flatMap({ dictionary  in
                
                let station = BikeStation.init(dictionary: dictionary as! [String : Any])
                station.store.saveStationToDataBase(station: station)
                return station
            })
            
            completion (.success(self.bikeStations))
        }
    }
    
    func getBikeStationInfo(stationId: String, completion : @escaping UniqueStationCompletion) {
        
        let url = urlWith(string: "gbfs/en/station_status.json")
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            
        }
    }
}

extension BikeStationController {

    func urlWith(string : String) -> URL? {
    
        let urlString  = BASE_URL + string
        if let url = URL.init(string: urlString) {
            return url
        } else {
            return nil
        }
    }
}


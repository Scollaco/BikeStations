//
//  BikeStationController.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import Alamofire

typealias BikeStationsCompletion = (Result<[BikeStation], ErrorType>) -> Void
typealias UniqueStationCompletion = (Result<BikeStation, ErrorType>) -> Void


class BikeStationController: NSObject {
    
    var bikeStations : [BikeStation]! = []
    
    func getBikeStations(completion : @escaping BikeStationsCompletion) {
        
        let resource = Resource(path: "gbfs/en/station_information.json", method: .GET)
        WebService().makeConnection(resource) { (result) in
            
            switch result {
            case .success(let json):
                
                let jsonResult = json as? [String : Any]
                
                guard jsonResult != nil else {
                    completion(.failure(.unknown("Some error occurred.")))
                    return
                }
                
                let jsonData = jsonResult!["data"] as! [String : Any]
                let stations = jsonData["stations"] as! [Any]
                
                self.bikeStations = stations.flatMap({ dictionary  in
                    
                    let station = BikeStation.init(dictionary: dictionary as! [String : Any])
                    station.store.saveStationToDataBase(station: station)
                    return station
                })
                
                completion(.success(self.bikeStations))
                
            case .failure(let error):
                completion(.failure(error))
            }            
        }
    }

    
    func getBikeStationInfo(stationId: String, completion : @escaping UniqueStationCompletion) {
        
        let resource = Resource(path:"gbfs/en/station_status.json", method: .GET)
        WebService().makeConnection(resource) { (result) in
         
            //TODO: Handle web service response
            switch result {
            case .success(let json):
                print(json!)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}



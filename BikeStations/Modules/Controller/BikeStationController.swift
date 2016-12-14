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
typealias UniqueStationCompletion = (Result<BikeStationInfo, ErrorType>) -> Void


class BikeStationController: NSObject {
    
    var bikeStations : [BikeStation]! = []
    
    func getBikeStations(completion : @escaping BikeStationsCompletion) {
        
        let resource = Resource(path: "gbfs/en/station_information.json", method: .GET)
        WebService().makeConnection(resource) { (result) in
            
            switch result {
            case .success(let json):
                
                let jsonResult = json as? [String : Any]
                
            
                guard  jsonResult != nil,
                       let jsonData = jsonResult!["data"] as? [String : Any],
                       let stations = jsonData["stations"] as? [Any] else {
                
                        completion(.failure(.unknown("Some error occurred.")))
                        return
                }
          
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
         
            switch result {
            case .success(let json):
                
                let jsonResult = json as? [String : Any]
                
                guard  jsonResult != nil,
                    let jsonData = jsonResult!["data"] as? [String : Any],
                    let stations = jsonData["stations"] as? [[String : Any]] else {
                        
                        completion(.failure(.unknown("Some error occurred.")))
                        return
                }
                
                let bikeStationDic = stations.filter({
                    ($0["station_id"] as! String) == stationId
                }).first
                
                guard bikeStationDic != nil else {
                
                    completion(.failure(.unknown("No station with id \(stationId) found!")))
                    return
                }
                
                let station = BikeStationInfo.init(dictionary: bikeStationDic!)
                completion(.success(station))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}



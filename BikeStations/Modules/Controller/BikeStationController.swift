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
}

typealias BikeStationsCompletion = ([BikeStation]?, String?) -> Void
typealias UniqueStationCompletion = (BikeStation?, String?) -> Void


class BikeStationController: NSObject, BikeStationClientProtocol {
    
    var bikeStations : [BikeStation]! = []
    let bikeStationsEndPoint = "gbfs/en/station_information.json"
    let uniqueStationEndPoint = "gbfs/en/station_status.json"
    
    
    func getBikeStations(completion : @escaping BikeStationsCompletion) {
        
        let urlString  = BASE_URL + bikeStationsEndPoint
        let url = URL.init(string: urlString)
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            guard let json = response.result.value as? [String:AnyObject] else {
                
                completion(nil, response.result.error.debugDescription)
                return
            }
            
            let stations : [Any]? = json["data"]?["stations"] as? [Any]
            
            self.bikeStations = stations!.flatMap({ dictionary  in
                
                let station = BikeStation.init(dictionary: dictionary as! [String : Any])
                station.store.saveStationToDataBase(station: station)
                return station
            })
            
            completion (self.bikeStations, nil)
        }
    }
    
    func getBikeStationInfo(stationId: String, completion : @escaping UniqueStationCompletion) {
        
        let urlString  = BASE_URL + uniqueStationEndPoint
        let url = URL.init(string: urlString)
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
              completion(nil, response.result.error.debugDescription)
            
           // guard let json = response.result.value as? [String:AnyObject] else {
             //   completion(nil, response.result.error.debugDescription)
             //   return
           // }
            

           // let stations : [Any]? = json["data"]?["stations"] as? [[String : Any]]
           // var station : BikeStationInfo?
            
            //stations?.forEach {(dictionary) in
            
              //  if let id =  dictionary["station_id"] as String {
                
                //    if id == station
                
                
              //  }
                
            //}
            
            //let station = stations?.filter{ ($0 as! Dictionary)["station_id"] == stationId }
       
            //print(station)
            
            //completion (self.bikeStations, nil)
        }
    }
    
}

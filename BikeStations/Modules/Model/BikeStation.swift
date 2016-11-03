//
//  BikeStation.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import CoreLocation

final class BikeStation : NSObject {
    
    let stationId : String?
    let name : String?
    let latitude : Double?
    let longitude : Double?
    
    var coordinate : CLLocationCoordinate2D  {
        get {
           return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        }
    }
    
    init(dictionary : [String : Any]) {
        
         self.name = dictionary["name"] as? String
         self.stationId = dictionary["station_id"] as? String
         self.latitude =  dictionary["lat"] as? Double
         self.longitude =  dictionary["lon"] as? Double
    }
    
    override var description: String {
    
        return "Name : \(name)" +
               "\nStation ID : \(stationId)" +
               "\nLatitude : \(latitude)" +
               "\nLongitude : \(longitude)"
    }
    
}



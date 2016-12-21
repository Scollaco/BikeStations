//
//  BikeStation.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import CoreLocation

struct BikeStation {
    
    var stationId : String?
    var name : String?
    var latitude : Double?
    var longitude : Double?
    //let store = BikeStationCache()
    
    var coordinate : CLLocationCoordinate2D  {
        get {
           return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        }
    }
}

extension BikeStation {
    
    init(dictionary : [String : Any]) {
        
        guard let latitude = dictionary["lat"] as? Double,
              let longitude = dictionary["lon"] as? Double else { return }
        
        self.name = dictionary["name"] as? String
        self.stationId = dictionary["station_id"] as? String
        self.latitude =  latitude
        self.longitude =  longitude
    }
}



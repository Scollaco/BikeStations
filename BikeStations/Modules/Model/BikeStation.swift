//
//  BikeStation.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import CoreLocation

protocol Annotable {

    var stationId : String? { get set }
    var name : String? { get set }
    var latitude : Double? { get set }
    var longitude : Double? { get set }
}

struct BikeStation {
    
    var stationId : String?
    var name : String?
    var latitude : Double?
    var longitude : Double?
    let store = BikeStationStore()
    
    var coordinate : CLLocationCoordinate2D  {
        get {
           return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        }
    }
}

extension BikeStation {

    init(dictionary : [String : Any]) {
        
        self.name = dictionary["name"] as? String
        self.stationId = dictionary["station_id"] as? String
        self.latitude =  dictionary["lat"] as? Double
        self.longitude =  dictionary["lon"] as? Double
    }
}



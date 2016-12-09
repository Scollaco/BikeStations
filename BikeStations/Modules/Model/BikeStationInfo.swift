//
//  BikeStationInfo.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/4/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit

struct BikeStationInfo {

    var name : String?
    var bikesAvailable : Int?
    var docksAvailable : Int?
    var lastReported : Date?
}

extension BikeStationInfo {

    init(dictionary : [String : Any], name : String) {
        
        self.name = name
        self.bikesAvailable = dictionary["num_bikes_available"] as? Int
        self.docksAvailable = dictionary["num_docks_available"] as? Int
        self.lastReported = dictionary["last_reported"] as? Date
        
    }
}

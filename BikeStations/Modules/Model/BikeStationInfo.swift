//
//  BikeStationInfo.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/4/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a 'on' MMM dd yyyy"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: self)
    }
}

struct BikeStationInfo {

    var bikesAvailable : Int?
    var docksAvailable : Int?
    var lastReported : String?
}

extension BikeStationInfo {

    init(dictionary : [String : Any]) {
        
        guard let bikesAvailable = (dictionary["num_bikes_available"] as? Int),
              let docksAvailable = (dictionary["num_docks_available"] as? Int),
              let lastReported = (dictionary["last_reported"] as? Int) else {

                return
        }
        
        self.bikesAvailable = bikesAvailable
        self.docksAvailable = docksAvailable

        let date = Date.init(timeIntervalSince1970: TimeInterval(lastReported))
        self.lastReported = date.toString()
    }
}

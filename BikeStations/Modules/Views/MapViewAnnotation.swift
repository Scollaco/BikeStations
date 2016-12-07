//
//  MapViewAnnotation.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/4/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import MapKit

class MapViewAnnotation: NSObject, MKAnnotation {

    let title : String?
    let subtitle : String?
    @objc let coordinate : CLLocationCoordinate2D
    
    init(title : String, subtitle : String, coordinate : CLLocationCoordinate2D) {
        
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }

    
}

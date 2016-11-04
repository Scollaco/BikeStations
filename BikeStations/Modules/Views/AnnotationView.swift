//
//  AnnotationView.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import MapKit

class AnnotationView: NSObject, MKAnnotation {

    let title : String?
    let subtitle : String?
    @objc let coordinate : CLLocationCoordinate2D

    init(title : String, subtitle : String, coordinate : CLLocationCoordinate2D) {
        
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }

}

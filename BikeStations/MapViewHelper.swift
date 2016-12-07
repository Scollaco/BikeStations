//
//  MapViewHelper.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import MapKit

extension MKMapView {

    func centerAnnotation(annotationView : MapViewAnnotation) {
        
        var rect = self.visibleMapRect
        let point = MKMapPointForCoordinate(annotationView.coordinate)
        rect.origin.x = point.x - rect.size.width * 0.5
        rect.origin.y = point.y - rect.size.width * 0.75
        
        self.setVisibleMapRect(rect, animated: true)
    }
}

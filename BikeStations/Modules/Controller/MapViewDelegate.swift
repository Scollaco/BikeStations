//
//  MapViewDelegate.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/4/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import MapKit

class MapViewDelegate: NSObject, MKMapViewDelegate {

    weak var mapView : MKMapView!
    weak var parent : UIViewController!
    
    init(mapView : MKMapView, parentVC : UIViewController) {
        
        self.mapView = mapView
        self.parent = parentVC
        
        super.init()
        mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let bubble = CalloutView.init(nibName: "CalloutView", bundle: nil, frame: view.frame)
        UIView.animate(withDuration: 0.3) {
            self.parent.view.addSubview(bubble.view)
            self.mapView.centerAnnotation(annotationView: view.annotation! as! AnnotationView)
        }
    }
}

//
//  ViewController.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    let controller = BikeStationController()
    @IBOutlet weak var mapStations: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.getBikeStations { [unowned self] stations, errorMessage in
            
            if stations != nil {
            
                self.mapStations.addAnnotation()
            
            }
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension MapViewController : MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        
        
    }
}


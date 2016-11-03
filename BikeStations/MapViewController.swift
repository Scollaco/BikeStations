//
//  ViewController.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    let controller = BikeStationController()
    @IBOutlet weak var mapStations: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.getBikeStations { [unowned self] stations, errorMessage in
            
            if stations != nil {
                self.addAnottationsOnMap(stations)
            }
        }
    }
    
    fileprivate func addAnottationsOnMap(_ stations : [BikeStation]?) {
    
        var annotations : [MKPointAnnotation] = []
        stations?.forEach({ (station) in
            
            let startPoint = MKPointAnnotation.init()
            startPoint.coordinate = station.coordinate
            startPoint.title = station.name
            annotations.append(startPoint)
        })
        
        DispatchQueue.main.async { [unowned self] in
         self.mapStations.addAnnotations(annotations)
         self.mapStations.showAnnotations(annotations, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.canShowCallout = true
    }
    
}


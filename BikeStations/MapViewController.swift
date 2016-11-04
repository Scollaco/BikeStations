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
            } else {
                self.addAnnotationFromDatabase()
            }
        }
    }
    
    fileprivate func addAnnotationFromDatabase() {
    
        let persistedStations = BikeStationEntity.mr_findAll()
        self.addAnottationsOnMapFromDatabase(persistedStations as! [BikeStationEntity]?)
    }
}

extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let bubble = CalloutView.init(nibName: "CalloutView", bundle: nil, frame: view.frame)
        UIView.animate(withDuration: 0.3) { 
            self.view.addSubview(bubble.view)
            self.mapStations.centerAnnotation(annotationView: view.annotation! as! AnnotationView)
        }
    }
    
    fileprivate func addAnottationsOnMapFromDatabase(_ stations : [BikeStationEntity]?) {
        
        var annotations : [MKPointAnnotation] = []
        stations?.forEach({ (station) in
            
            let startPoint = MKPointAnnotation.init()
            startPoint.coordinate = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
            startPoint.title = station.name
            annotations.append(startPoint)
        })
        
        DispatchQueue.main.async { [unowned self] in
            self.mapStations.addAnnotations(annotations)
            self.mapStations.showAnnotations(annotations, animated: true)
        }
    }
    
    fileprivate func addAnottationsOnMap(_ stations : [BikeStation]?) {
        
        var annotations : [AnnotationView] = []
        stations?.forEach({ (station) in
            
            let coordinate = CLLocationCoordinate2D(latitude: station.latitude!, longitude: station.longitude!)
            
            let startPoint = AnnotationView.init(title: station.name!, subtitle: "", coordinate: coordinate)
            annotations.append(startPoint)
        })
        
        DispatchQueue.main.async { [unowned self] in
            self.mapStations.addAnnotations(annotations)
            self.mapStations.showAnnotations(annotations, animated: true)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: "Annotation")
        annotationView.canShowCallout = true
        annotationView.annotation = annotation
        return annotationView
    }
}


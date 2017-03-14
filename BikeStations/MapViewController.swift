//
//  ViewController.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import MapKit
import CoreData

final class MapViewController: UIViewController {

    let controller = BikeStationController()
    var calloutView : CalloutView!
    
    @IBOutlet weak var mapStations: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBikeStations()
    }
    
    fileprivate func getBikeStations() {
        
        controller.getBikeStations { [unowned self] result in
            
            switch result {
            case .success( _) : break
            case .failure(let error) :
                print(error.localizedDescription)
            }
            
            self.addAnnotationsOnMap()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.subviews.forEach { [unowned self] (subview) in
            
            if subview.isKind(of: MKMapView.self) {
               self.calloutView?.dismissCallout()
            }
        }
    }
}

extension MapViewController {
    
    func addAnnotationsOnMap() {
        
         let stations = BikeStationCache.allStations()
        
        var annotations : [MapViewAnnotation] = []
        stations.forEach({ (station) in
            
            let coordinate = CLLocationCoordinate2D(latitude: station.latitude,
                                                    longitude: station.longitude)

            let pin = MapViewAnnotation.init(title: station.name!,
                                             subtitle: "",
                                             coordinate: coordinate)
            annotations.append(pin)
      })
        
        DispatchQueue.main.async { [unowned self] in
            self.mapStations.addAnnotations(annotations)
            self.mapStations.showAnnotations(annotations, animated: true)
        }
    }
}


extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard view.annotation! is MapViewAnnotation else {
            return
        }
        
        let station = selectedStation(annotation: view.annotation as! MapViewAnnotation)
        
        guard station != nil else {
            return
        }
        
        calloutView = CalloutView.init(nibName: "CalloutView", bundle: nil, frame: view.frame, bikeStation : station!)
        
        UIView.animate(withDuration: 0.3) {
            self.view.addSubview(self.calloutView.view)
            self.mapStations.centerAnnotation(annotationView: view.annotation! as! MapViewAnnotation)
        }
    }
    
    private func selectedStation(annotation : MapViewAnnotation) -> BikeStationEntity? {
    
        guard controller.bikeStations.count > 0 else {
        
            UIAlertController.presentAlert(message: "Some error occurred retrieving the station's info. Please, check your connection and relaunch the app.", parent: self)
            return nil
        }
        
        
        var bikeStation : BikeStationEntity? = nil
        
        controller.bikeStations.forEach { (station) in
            if station.latitude == annotation.coordinate.latitude && station.longitude == annotation.coordinate.longitude {
                bikeStation = station
            }
        }
        
        return bikeStation
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Annotation")
        annotationView.canShowCallout = false
        annotationView.image = UIImage.init(named: "pin_map")!
        
        return annotationView
    }
}


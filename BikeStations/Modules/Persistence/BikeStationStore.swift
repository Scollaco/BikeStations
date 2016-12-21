//
//  BikeStationStore.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import CoreData

class BikeStationCache {
    
    private init() {
        
    }
    
    class func allStations() -> [BikeStationEntity] {
        
        let stations = DatabaseController.getContext().fetchAll(entity: BikeStationEntity.self)
        return stations
    }
    
    class func saveStationToDataBase(values : [String : Any]) {
        
        if let cachedStation = DatabaseController.getContext().fetchFirst(entity: BikeStationEntity.self, by: "stationId", value: values["station_id"] as! String) {
            updateStation(station: cachedStation, newValues: values)
            
        } else {
            
            let newStation = DatabaseController.getContext().insert(entity: BikeStationEntity.self)
            updateStation(station: newStation, newValues: values)
        }
        
        DatabaseController.saveContext()
    }
    
    private class func updateStation(station : BikeStationEntity, newValues: [String : Any]) {
        
        station.name = newValues["name"] as! String?
        station.latitude = newValues["lat"] as! Double
        station.longitude = newValues["lon"] as! Double
        station.stationId = newValues["station_id"] as! String?
    }
    
    //TODO: Implement delete rule
    func deleteStation(station : BikeStation) {
        
    }
    
    fileprivate func stationAlreadyExists(station : BikeStation) -> Bool {
        
        guard station.stationId != nil else {
            return false
        }
        
        let object = DatabaseController.getContext().fetchFirst(entity: BikeStationEntity.self, by: "stationId", value: station.stationId!)
        
        return object != nil
    }
}

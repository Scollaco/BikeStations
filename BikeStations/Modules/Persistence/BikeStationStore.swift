//
//  BikeStationStore.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import MagicalRecord
import CoreData

class BikeStationStore: NSObject {

    let defaultContext = NSManagedObjectContext.mr_default()
    
    func saveStationToDataBase(station : BikeStation) {
        
        guard stationAlreadyExists(station: station) == false else {
            updateStation(station: station)
            return
        }
        
            let object = BikeStationEntity.mr_createEntity()
            object?.name = station.name
            object?.latitude = station.latitude!
            object?.longitude = station.longitude!
            object?.stationId = station.stationId
        
            defaultContext.mr_saveToPersistentStoreAndWait()
    }
    
    func deleteStation(station : BikeStation) {

        guard station.stationId != nil else {
            return
        }
        
        let object = BikeStationEntity.mr_findFirst(byAttribute: "stationId", withValue: station.stationId!)
        object?.mr_deleteEntity(in: defaultContext)
    }
    
    fileprivate func updateStation(station : BikeStation) {
    
            let object = BikeStationEntity.mr_findFirst(byAttribute: "stationId", withValue: station.stationId!)
            object?.name = station.name
            object?.latitude = station.latitude!
            object?.longitude = station.longitude!
            object?.stationId = station.stationId
        
            defaultContext.mr_saveToPersistentStoreAndWait()
    }
    
    fileprivate func stationAlreadyExists(station : BikeStation) -> Bool {
    
        guard station.stationId != nil else {
            return false
        }
        
        let persistedObj = BikeStationEntity.mr_findFirst(byAttribute: "stationId", withValue: station.stationId!)
        return persistedObj != nil
    }
}

//
//  BikeStationEntity+CoreDataProperties.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import Foundation
import CoreData

protocol ManagedAnnotable {
    
      var name: String? { get set }
      var stationId: String?  { get set }
      var latitude: Double  { get set }
      var longitude: Double  { get set }
}

extension BikeStationEntity : ManagedAnnotable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BikeStationEntity> {
        return NSFetchRequest<BikeStationEntity>(entityName: "BikeStationEntity");
    }

    @NSManaged public var name: String?
    @NSManaged public var stationId: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

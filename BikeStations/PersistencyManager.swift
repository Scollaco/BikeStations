//
//  PersistenceManager.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import MagicalRecord

let persistencyStoreName = "BikeStations"

class PersistencyManager: NSObject {
    
    class func fetchPersistedObjects(entityName : String) -> [NSManagedObject]? {
    
        let className : AnyClass = NSClassFromString(entityName)!
        let results = className.mr_findAll()
        return results
    }
    
    class func persistedObjectWithID(uniqueKey : String, objectID : String, entityName : String) -> NSManagedObject? {
    
        let className : AnyClass = NSClassFromString(entityName)!
        let object = className.mr_findFirst(byAttribute: uniqueKey, withValue: objectID) as? NSManagedObject
        return object
    }
    
    
    class func save() {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
    }

}

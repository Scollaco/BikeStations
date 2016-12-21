//
//  DatabaseController.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import UIKit
import CoreData

extension NSManagedObject {

    class var entityName : String {
    
        let components = NSStringFromClass(self).components(separatedBy: ".")
        return components[0]
    }
    
    class func fetch() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest(entityName: self.entityName)
    }
    
    class func fetchWith(_ key:String, ascending: Bool = true) -> NSFetchRequest<NSFetchRequestResult> {
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.sortDescriptors = [NSSortDescriptor(key: key, ascending: ascending)]
        return request
    }
}

extension NSManagedObjectContext {

    func insert<T : NSManagedObject>(entity : T.Type) -> T {
    
        let entityName = entity.entityName
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: self) as! T
    }
    
 
    func fetchAll<T: NSManagedObject>(entity: T.Type, key: String? = nil, ascending: Bool = true, request: NSFetchRequest<NSFetchRequestResult>? = nil) -> [T] {
    
        guard key == nil else {
        
            let request = entity.fetchWith(key!, ascending: ascending)
            
            do {
                if let results = try fetch(request) as? [T] {
                    return results
                }
                return [T]()
            } catch {
                return [T]()
            }
        }
        
        let request = request ?? NSFetchRequest<NSFetchRequestResult>(entityName:entity.entityName)

        do {
            if let results = try fetch(request) as? [T] {
                return results
            }
            return [T]()
            
        } catch {
            
            return [T]()
        }
    }
    
    func fetchFirst<T: NSManagedObject>(entity: T.Type, by id : String, value: String) -> T? {
    
        let predicate = NSPredicate.init(format: "\(id) = %@", value)
        let request = entity.fetch()
        request.predicate = predicate
        
        let result = fetchAll(entity: entity, request: request).first
        return result
    }
}

let persistencyStoreName = "BikeStations"

class DatabaseController {
    
    private init() {
        // Can't be called directly
    }
    
    class func getContext() -> NSManagedObjectContext {
        return DatabaseController.persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: persistencyStoreName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    class func saveContext () {
        let context = DatabaseController.getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

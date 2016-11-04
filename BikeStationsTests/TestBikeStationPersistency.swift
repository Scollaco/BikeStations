//
//  TestBikeStationPersistency.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import XCTest
import CoreData
import MagicalRecord

class TestBikeStationPersistency: XCTestCase {
    
    var station : BikeStationEntity?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        
        super.tearDown()
        station = nil
    }
    
    func testStationCanBeCreated() {
    
        let object = BikeStationEntity.mr_createEntity()
        object?.name = "name"
        object?.latitude = 0
        object?.longitude = 0
        object?.stationId = "id"
    
        let localContext = NSManagedObjectContext.mr_default()
        localContext.mr_saveToPersistentStoreAndWait()
        
        let persistedObj = BikeStationEntity.mr_findFirst(byAttribute: "stationId", withValue: object!.stationId!)
        XCTAssertNotNil(persistedObj, "Object should not be nil")
    
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

//
//  Result.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

enum Result<T, E: Error> {

    case success(T)
    case error(String)

}

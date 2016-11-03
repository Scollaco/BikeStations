//
//  Error.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import Foundation

enum ErrorType : Error {
    case network(String)
    case unknown(String)
}

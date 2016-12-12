//
//  Result.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 12/8/16.
//  Copyright © 2016 Green. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
  case success(T)
  case failure(E)
}

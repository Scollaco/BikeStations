//
//  Error.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 11/3/16.
//  Copyright © 2016 Green. All rights reserved.
//

import Foundation

enum ErrorType : Error {
    case network(Error)
    case parser
    case database
    case invalidJsonFormat
    case unknown
    
}

enum ErrorTypeDescription : String {

    case descriptionTypeParser = "Some error occurred parsing json."
    case descriptionTypeDatabase = "Fetching objects from database."
    case descriptionTypeUnknown = "Some error occurred."
    case descriptionTypeInvalidJson = "Invalid json format."
}

extension ErrorType  {

    var description : ErrorTypeDescription {
    
        switch self {
        case .parser:
            return .descriptionTypeParser
        case .database:
            return .descriptionTypeDatabase
        case .invalidJsonFormat:
            return .descriptionTypeInvalidJson
        default:
            return .descriptionTypeUnknown
        }
    }
}

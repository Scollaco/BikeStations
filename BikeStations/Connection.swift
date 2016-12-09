//
//  Connection.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 12/9/16.
//  Copyright © 2016 Green. All rights reserved.
//

import Foundation

protocol Connectable {

    func makeConnection(_ resource: Resource, completion: @escaping (Result<Data, ErrorType>) -> Void)
}

final class Connection : Connectable {

    fileprivate let session: URLSession
    fileprivate 
    
    
}

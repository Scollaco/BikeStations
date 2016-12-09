//
//  Resource.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 12/9/16.
//  Copyright © 2016 Green. All rights reserved.
//

import Foundation

public struct Resource<T> {

    let url: URL
    let parse: (Data) -> T?
}


extension Resource {
    
    init(url: URL, parseJSON: @escaping (Any) -> T?) {
        
        self.url = url
        self.parse = { data in
        
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
        }
        
    }

}

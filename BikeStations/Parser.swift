//
//  Parser.swift
//  BikeStations
//
//  Created by Saturnino Teixeira on 12/10/16.
//  Copyright © 2016 Green. All rights reserved.
//

import Foundation

final class Parser : NSObject {
    
    func parse(_ data: Data) -> Any? {
        
        let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        return json
    }
}

//
//  BusStops.swift
//  GetOnThatBus
//
//  Created by Aaron B on 2/2/16.
//  Copyright © 2016 Andrew Chen. All rights reserved.
//

import UIKit

class BusStops: NSObject {
    let latitude: String
    let longitude: String
    let stopName: String
    let routes: String
    
    init(longitude: String, latitude: String, stopName:String, routes:String) {
        self.longitude = longitude
        self.latitude = latitude
        self.stopName = stopName
        self.routes = routes
    }
}

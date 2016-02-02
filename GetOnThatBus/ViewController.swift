//
//  ViewController.swift
//  GetOnThatBus
//
//  Created by Andrew Chen on 2/2/16.
//  Copyright © 2016 Andrew Chen. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    var busStopsArray:NSMutableArray = []
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func fetchBusStop(jsonDictionary: NSDictionary) -> BusStop {
        let row = [NSDictionary]()
        for var i = 0; i < row.count; i++ {
            self.busStopsArray.addObject(row)
        }
        for dict in busStopsArray {
            var busStop: BusStop = dict as! NSDictionary
        }
        }
    }
    
}


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
    var busJson = NSDictionary()
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBusStop()
        mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(41.881832, -87.6847), MKCoordinateSpanMake(0.5, 0.5)), animated: true)
        
    }
    
    func fetchBusStop(){
        let url = NSURL(string: "https://s3.amazonaws.com/mmios8week/bus.json")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            do {
                self.busJson = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
            }catch let error as NSError {
                print("error: " + error.localizedDescription)
            }
            let rowArray:NSArray = (self.busJson.objectForKey("row") as? NSArray)! //in the json data the key "row"'s value is an Array containing busstop information as dictionaries
            for busStops in rowArray{
                let newDict:NSDictionary = busStops as! NSDictionary
                
                let longitude = newDict["longitude"] as! String
                let latitude = newDict["latitude"] as! String
                let stopName = newDict["cta_stop_name"] as! String
                let routes = newDict["routes"] as! String
                
                let newBusStop = BusStops(longitude: longitude, latitude: latitude, stopName: stopName, routes: routes)
                dropPinForLatAndLong(newBusStop)
            }
            
        }
        task.resume()
    }
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        let selectedBusStop =
    }
    
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        let pin = view
        let detailDisclosureButton = UIButton(type: .DetailDisclosure)
        pin.rightCalloutAccessoryView = detailDisclosureButton
        detailDisclosureButton.addTarget(target: self, action:Selector(detailDisclosureButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    @IBAction
    func dropPinForLatAndLong(busStop:BusStops) ->MKPointAnnotation{
        let latitudeAsDouble = NSNumberFormatter().numberFromString(busStop.latitude)!.doubleValue
        let longitudeAsDouble = NSNumberFormatter().numberFromString(busStop.longitude)!.doubleValue
        let newAnnotation = MKPointAnnotation ()
        newAnnotation.title = busStop.stopName
        newAnnotation.subtitle = busStop.routes
        newAnnotation.coordinate = CLLocationCoordinate2DMake(latitudeAsDouble, longitudeAsDouble)
        self.mapView.addAnnotation(newAnnotation)
        return newAnnotation
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailsVC = segue.destinationViewController as? DetailsViewController
        detailsVC?.selectedBusStopPin =
    }
    
}
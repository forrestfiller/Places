//
//  MapViewController.swift
//  Places-week-4
//
//  Created by Forrest Filler on 6/29/16.
//  Copyright © 2016 forrestfiller. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    var mapView: MKMapView! //regular ui view
    var currentLocation: CLLocation!
    
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .greenColor()
        
        self.mapView = MKMapView(frame: frame)
        self.mapView.centerCoordinate = self.currentLocation.coordinate
        
        let dist = CLLocationDistance(500)
        let region = MKCoordinateRegionMakeWithDistance(
            self.mapView.centerCoordinate,
            dist,
            dist
            )
        self.mapView.setRegion(region, animated: true)
        
        view.addSubview(self.mapView)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//
//  MapViewController.swift
//  Places-week-4
//
//  Created by Forrest Filler on 6/29/16.
//  Copyright © 2016 forrestfiller. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var mapView: MKMapView! //regular ui view
    
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .greenColor()
        
        self.mapView = MKMapView(frame: frame)
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

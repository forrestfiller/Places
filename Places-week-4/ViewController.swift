//
//  ViewController.swift
//  Places-week-4
//
//  Created by Forrest Filler on 6/27/16.
//  Copyright © 2016 forrestfiller. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager! //finds your location, this class

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        
        if (status == .AuthorizedWhenInUse){
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let currentLocation = locations.last!
        print("didUpdateLocations: \(locations) ")
        
        if (currentLocation.horizontalAccuracy < 30) { //good enough, stop GPS. This is in meters.
            self.locationManager.stopUpdatingLocation()
            
            let latLng = "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
            print("didUpdateLocations: \(latLng)")
            self.foursquareRequest(latLng)
        }
        
    }
    
    func foursquareRequest(latLng: String){        
        let url = "https://api.foursquare.com/v2/venues/search?v=20140806&ll=\(latLng)&query=food&client_id=VZZ1EUDOT0JYITGFDKVVMCLYHB3NURAYK3OHB5SK5N453NFD&client_secret=UAA15MIFIWVKZQRH22KPSYVWREIF2EMMH0GQ0ZKIQZC322NZ"
        
        print("\(url)")
        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject>{
                print("\(json)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}









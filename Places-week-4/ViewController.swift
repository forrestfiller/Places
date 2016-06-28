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

class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    var locationManager: CLLocationManager! //finds your location, this class
    var venueTextField: UITextField!
    
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .lightGrayColor()
        self.venueTextField = UITextField(frame: CGRect(x: 20, y: 84, width: frame.size.width-40, height: 22))
        venueTextField.backgroundColor = .whiteColor()
        self.venueTextField.delegate = self
        view.addSubview(self.venueTextField)
        self.view = view

    }

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
        }
        
    }
    
    func foursquareRequestFood(latLng: String){
        let url = "https://api.foursquare.com/v2/venues/search?v=20140806&ll=\(latLng)&query=food&client_id=VZZ1EUDOT0JYITGFDKVVMCLYHB3NURAYK3OHB5SK5N453NFD&client_secret=UAA15MIFIWVKZQRH22KPSYVWREIF2EMMH0GQ0ZKIQZC322NZ"
        
        print("\(url)")
        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject>{
                print("\(json)")
            }
        }
    }
    
    func foursquareRequestFashion(latLng: String){
        let url = "https://api.foursquare.com/v2/venues/search?v=20140806&ll=\(latLng)&query=fashion&client_id=VZZ1EUDOT0JYITGFDKVVMCLYHB3NURAYK3OHB5SK5N453NFD&client_secret=UAA15MIFIWVKZQRH22KPSYVWREIF2EMMH0GQ0ZKIQZC322NZ"
        
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

    func textFieldShouldReturn(textField: UITextField) -> Bool {
    // called when 'return' key pressed. return NO to ignore.
        print("\(textField.text!)")
        
        let lat = self.locationManager.location!.coordinate.latitude
        let lng = self.locationManager.location!.coordinate.longitude
        let latLng = ("\(lat),\(lng)")
        print("didUpdateLocations: \(latLng)")
        if textField.text == "Food" {
            self.foursquareRequestFood(latLng)
            print("USerTypedFood: ")
        }
        if textField.text == "Fashion" {
            self.foursquareRequestFashion(latLng)
            print("UserTypedFashion: ")
        }
        return true
    }
}









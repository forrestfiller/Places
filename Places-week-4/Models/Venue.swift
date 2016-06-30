//
//  Venue.swift
//  Places-week-4
//
//  Created by Forrest Filler on 6/27/16.
//  Copyright © 2016 forrestfiller. All rights reserved.
//

import UIKit
import MapKit


class Venue: NSObject, MKAnnotation {
    var name = ""
    var location: Dictionary<String, AnyObject>?
    var address = ""
    var city = ""
    var state = ""
    var lat = 0.0
    var lng = 0.0
    
// need the following three functions (3) if I add the MKAnnotation type above in the Class Venue: after importing MapKit
// Mark - Annotation overides
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.lat, self.lng)
    }
    
    var title: String? {
        return self.name
    }
    
    var subtitle: String? {
        return self.address
    }
    

    func populate(venueInfo: Dictionary<String, AnyObject>){
        if let _name = venueInfo["name"] as? String {
            self.name = _name
        }
        
        self.location = venueInfo["location"] as? Dictionary<String, AnyObject>
        
        if let _address = location!["address"] as? String {
            self.address = _address
        }
        if let _city = location!["city"] as? String {
            self.city = _city
        }
        if let _state = location!["state"] as? String {
            self.state = _state
        }
        if let _lat = location!["lat"] as? Double {
            self.lat = _lat
        }
        if let _lng = location!["lng"] as? Double {
            self.lng = _lng
        }
    }
}

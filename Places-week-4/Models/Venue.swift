//
//  Venue.swift
//  Places-week-4
//
//  Created by Forrest Filler on 6/27/16.
//  Copyright © 2016 forrestfiller. All rights reserved.
//

import UIKit


class Venue: NSObject {
    var name = ""
    var location: Dictionary<String, AnyObject>?
    var address = ""
    var city = ""
    var state = ""
    var lat = 0.0
    var lng = 0.0

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

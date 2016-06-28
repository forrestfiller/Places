//
//  Venue.swift
//  Places-week-4
//
//  Created by Forrest Filler on 6/27/16.
//  Copyright © 2016 forrestfiller. All rights reserved.
//

import UIKit


class Venue: NSObject {
    
    var food: String!
    var fashion: String!

    func populate(venueInfo: Dictionary<String, AnyObject>){
        
        self.food = venueInfo["food"] as? String
        self.fashion = venueInfo["fashion"] as? String
    }

}

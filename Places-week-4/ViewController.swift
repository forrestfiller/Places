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

class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var locationManager: CLLocationManager! //finds your location, this class
    var vTableView: UITableView!
    var searchField: UITextField!
    var venueList = Array<Venue>() //now we have a venues array
    
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .lightGrayColor()
        
        self.searchField = UITextField(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 24))
        self.searchField.delegate = self
        searchField.backgroundColor = .redColor()
 
        self.vTableView = UITableView(frame: frame, style: .Plain)
        self.vTableView.delegate = self
        self.vTableView.dataSource = self
        self.vTableView.tableHeaderView = searchField
        view.addSubview(self.vTableView)

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Map",
            style: .Plain,
            target: self,
            action: #selector(ViewController.showMapView)
        )
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func showMapView(){
        print("showMapView")
        let mapView = MapViewController()
        mapView.currentLocation = self.locationManager.location
        mapView.venueList = self.venueList //show these venues please
        self.navigationController?.pushViewController(mapView, animated: true)
    
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let searchText = self.searchField.text!

        let lat = self.locationManager.location!.coordinate.latitude
        let lng = self.locationManager.location!.coordinate.longitude
        let latLng = ("\(lat),\(lng)")
        
//        if textField.text == "Food" {
//            self.foursquareRequest(latLng, query: searchText)
//            print("UserTypedFood: ")
//        }
        self.foursquareRequest(latLng, query: searchText)
        self.venueList.removeAll() //clear venue list so we don't keep appending
        return true
        
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
    
    func foursquareRequest(latLng: String, query: String){
        let url = "https://api.foursquare.com/v2/venues/search?v=20140806&ll=\(latLng)&query=\(query)&client_id=VZZ1EUDOT0JYITGFDKVVMCLYHB3NURAYK3OHB5SK5N453NFD&client_secret=UAA15MIFIWVKZQRH22KPSYVWREIF2EMMH0GQ0ZKIQZC322NZ"
        
        print("\(url)")
        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject>{
                //print("\(json)")
                
                if let resp = json["response"] as? Dictionary<String, AnyObject>{
                    //print("\(resp)")
                
                    if let venues = resp["venues"] as? Array<Dictionary<String, AnyObject>>{
                       // print("\(venues)")
                        
                        for venueInfo in venues {
                            let venueData = Venue() //instansiating an instance of "venue"
                            venueData.populate(venueInfo)
                            print("\(venueData.name)")
                            self.venueList.append(venueData)
                        }
                            self.vTableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venueList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let venue = self.venueList[indexPath.row]
        
        let cellId = "cellId"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId){
            cell.textLabel?.text = venue.name
            cell.detailTextLabel?.text = venue.address+", "+venue.city+", "+venue.state+", "+"\(venue.lat)"+", "+"\(venue.lng)"
            return cell
        }
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        cell.textLabel?.text = venue.name
        cell.detailTextLabel?.text = venue.address+", "+venue.city+", "+venue.state+", "+"\(venue.lat)"+", "+"\(venue.lng)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("didSelectRowAtIndexPath")
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
    }





}





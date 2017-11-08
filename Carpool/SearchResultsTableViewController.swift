//
//  SearchResultsTableViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/8/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class SearchResultsTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    var query: String?
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var region: CLRegion?
    var namesOfPlaces: [String] = []
    var places: [CLPlacemark] = []
    var place: CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        guard let query = query else { return }
        geocoder.geocodeAddressString(query) { (placemarks, error) in
            
            for placemark in placemarks! {
                self.geocoder.reverseGeocodeLocation(placemark.location!, completionHandler: { (placemark, error) in
                    guard let placemark = placemark else { return }
                    self.places = placemark
                    self.tableView.reloadData()
                })
            
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResults", for: indexPath)
        
        cell.textLabel?.text = places[indexPath.row].name
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        place = places[indexPath.row]
        performSegue(withIdentifier: "unwindfromsearchresults", sender: self)
        
    }
    
}

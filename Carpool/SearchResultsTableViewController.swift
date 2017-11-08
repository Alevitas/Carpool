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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        guard let query = query else { return }
        geocoder.geocodeAddressString(query, in: region) { (placemarks, error) in
            
            for placemark in placemarks! {
                self.geocoder.reverseGeocodeLocation(placemark.location!, completionHandler: { (placemark, error) in
                    guard let name = placemark?.last?.name else { return }
                    self.namesOfPlaces.append(name)
                    self.tableView.reloadData()
                })
            
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesOfPlaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResults", for: indexPath)
        
        cell.textLabel?.text = namesOfPlaces[indexPath.row]
        
        return cell
    }
    
    
}

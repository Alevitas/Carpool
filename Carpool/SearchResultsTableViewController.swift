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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        guard let query = query else { return }
        geocoder.geocodeAddressString(query, in: <#T##CLRegion?#>, completionHandler: <#T##CLGeocodeCompletionHandler##CLGeocodeCompletionHandler##([CLPlacemark]?, Error?) -> Void#>)
        
    }
    
    
    
    
}

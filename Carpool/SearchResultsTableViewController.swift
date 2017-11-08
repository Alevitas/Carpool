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
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        
        
    }
    
    
    
    
}

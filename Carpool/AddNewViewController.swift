//
//  AddNewViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/6/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import CarpoolKit
import MapKit


class AddNewViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var descriptionTextFieldOutlet: UITextField!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    @IBAction func dropOffPickUpSegControl(_ sender: Any) {
    }
    @IBOutlet weak var locationSelectedLabel: UILabel!
    
    
    let locationManager = CLLocationManager()
    var aLocation: CLLocation?
    var datePicked = Date()
    var query: String?
    var region: CLRegion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerOutlet.minimumDate = Date()
        print(datePickerOutlet.date)
        locationManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    @IBAction func onDatePickerChanged(_ sender: UIDatePicker) {
        datePicked = sender.date
    }
    
    @IBAction func onCancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
    }
    @IBAction func onAddButtonPressed(_ sender: Any) {
        if let description = descriptionTextFieldOutlet.text {
            API.createTrip(eventDescription: description, eventTime: datePicked, eventLocation: (aLocation ?? nil)!) { (trip) in
                
                
                self.performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
            }
        }
    }
    
    @IBAction func onTextFieldReturnPressed(_ sender: UITextField) {
        
        query = sender.text
        performSegue(withIdentifier: "SearchResults", sender: query)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let SearchResultVC = segue.destination as! SearchResultsTableViewController
        SearchResultVC.region = region
        SearchResultVC.query = query
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 5000, 5000)
//        //        mapView.setRegion(coordinateRegion, animated: true)
//
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        region = CLCircularRegion(center: (locations.last?.coordinate)!, radius: 10000, identifier: "region")
    }
    
}


extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


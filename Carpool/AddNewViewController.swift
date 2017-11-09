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
    var aLocation: CLPlacemark?
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
            locationManager.startUpdatingLocation()
            
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
    @IBAction func onDoneButtonPressed(_ sender: UIBarButtonItem) {
        
        if let description = descriptionTextFieldOutlet.text {
            if query == "" {
                API.createTrip(eventDescription: description, eventTime: datePicked, eventLocation: (aLocation?.location ?? nil)!) { (trip) in
                    
                    
                    self.performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
                }
            } else {
                API.createTrip(eventDescription: description + ("\nAddress:") + query!, eventTime: datePicked, eventLocation: (aLocation?.location ?? nil)!) { (trip) in
                    
                    
                    self.performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
                }
            }
        }
    }
    
    @IBAction func onTextFieldReturn(_ sender: UITextField) {
        query = sender.text
        performSegue(withIdentifier: "SearchResults", sender: query)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let SearchResultVC = segue.destination as? SearchResultsTableViewController{
            SearchResultVC.region = region
            SearchResultVC.query = query
        }
    }
    
    @IBAction func unwindFromSearchResults(segue: UIStoryboardSegue) {
        let searchResultsVC = segue.source as! SearchResultsTableViewController
        aLocation = searchResultsVC.place
        if let aLocation = aLocation {
            mapView.addAnnotation((aLocation.location)!)
        }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance((aLocation?.location?.coordinate)!, 4000, 4000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
            
        case .notDetermined:
            print("user not accepted")
        case .restricted:
            print("user not accepted")
        case .denied:
            print("user not accepted")
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        region = CLCircularRegion(center: (locations.last?.coordinate)!, radius: 1000, identifier: "region")
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 10000, 10000)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
}


extension CLLocation: MKAnnotation {
    
}



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
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var descriptionTextFieldOutlet: UITextField!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var shownInMapsButton: UIButton!
    
    
    let geocoder = CLGeocoder()
    let locationManager = CLLocationManager()
    var aLocation: CLPlacemark?
    var datePicked = Date()
    var region: CLRegion?
    var query: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerOutlet.minimumDate = Date()
        print(datePickerOutlet.date)
        locationManager.delegate = self
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        keyboardToolbar.isTranslucent = false
        keyboardToolbar.barTintColor = UIColor.white
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissKeyboard)
        )
        addButton.tintColor = UIColor.black
        keyboardToolbar.items = [addButton]
        descriptionTextFieldOutlet.inputAccessoryView = keyboardToolbar
        
        
    }
    
    @objc func dismissKeyboard() {
        
        descriptionTextFieldOutlet.resignFirstResponder()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        if aLocation == nil {
            shownInMapsButton.isHidden = true
        } else {
            shownInMapsButton.isHidden = false
        }
        
        cancelButton.setRoundEdge()
        addButton.setRoundEdge()
        
    }
    
    @IBAction func onDatePickerChanged(_ sender: UIDatePicker) {
        datePicked = sender.date
    }
    
    
    
    
    
    @IBAction func onTextFieldReturn(_ sender: UITextField) {
        query = sender.text
        //        performSegue(withIdentifier: "SearchResults", sender: query)
        if let queryA = sender.text {
            geocoder.geocodeAddressString(queryA) { (placemarks, error) in
                
                for placemark in placemarks! {
                    self.geocoder.reverseGeocodeLocation(placemark.location!, completionHandler: { (placemark, error) in
                        guard let placemark = placemark else { return }
                        self.aLocation = placemark.first
                    })
                    
                }
            }
        }
        
        let saveAlert = UIAlertController(title: "Is \(String(describing: aLocation?.name ?? "the address")) correct?", message: nil, preferredStyle: .actionSheet)
        saveAlert.addAction(UIAlertAction(title: "Confirm location", style: .default, handler: onLocationSelection))
        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(saveAlert, animated: true, completion: nil)
        
    }
    
    func onLocationSelection(action: UIAlertAction) {
        if let aLocation = aLocation {
            mapView.addAnnotation((aLocation.location)!)
        }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance((aLocation?.location?.coordinate)!, 4000, 4000)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    @IBAction func onOpenInMapsPressed(_ sender: UIButton) {
        if let addressDict = aLocation?.addressDictionary, let coordinate = aLocation?.location?.coordinate {
            let mkPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict as? [String : Any])
            let mapItem = MKMapItem(placemark: mkPlacemark)
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
        
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
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
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
          performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if let SearchResultVC = segue.destination as? SearchResultsTableViewController{
    //            SearchResultVC.region = region
    //            SearchResultVC.query = query
    //        }
    //    }
    
//    @IBAction func unwindFromSearchResults(segue: UIStoryboardSegue) {
//        let searchResultsVC = segue.source as! SearchResultsTableViewController
//        aLocation = searchResultsVC.place
//        if let aLocation = aLocation {
//            mapView.addAnnotation((aLocation.location)!)
//        }
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance((aLocation?.location?.coordinate)!, 4000, 4000)
//        mapView.setRegion(coordinateRegion, animated: true)
//    }
    
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











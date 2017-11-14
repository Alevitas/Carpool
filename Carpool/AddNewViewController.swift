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
import EventKit


class AddNewViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
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
        
        let ViewForDoneButtonOnKeyboard = UIToolbar()
        ViewForDoneButtonOnKeyboard.sizeToFit()
        let btnDoneOnKeyboard = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtnfromKeyboardClicked))
        ViewForDoneButtonOnKeyboard.items = [btnDoneOnKeyboard]
        descriptionTextFieldOutlet.inputAccessoryView = ViewForDoneButtonOnKeyboard
        
    }
    
    @IBAction func onCancelButtonPressed(_ sender: Any) {
         performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
    }
    @IBAction func onDoneButtonPressed(_ sender: UIBarButtonItem) {
        
        let saveAlert = UIAlertController(title: "Confirm adding trip", message: nil, preferredStyle: .actionSheet)
        saveAlert.addAction(UIAlertAction(title: "Save to Carpool?", style: .default, handler: onCarpoolSelected))
        saveAlert.addAction(UIAlertAction(title: "Save to Carpool and Calendar?", style: .default, handler: onCalendarSelected))
        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(saveAlert, animated: true, completion: nil)
        
        
        
    }
    
    func onCalendarSelected(action: UIAlertAction) {
        
        func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
            let eventStore = EKEventStore()
            
            eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if (granted) && (error == nil) {
                    let event = EKEvent(eventStore: eventStore)
                    event.title = "Event from Carpool App"
                    event.startDate = self.datePicked
                    event.endDate = nil
                    event.notes = self.descriptionTextFieldOutlet.text
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    do {
                        try eventStore.save(event, span: .thisEvent)
                    } catch let e as NSError {
                        completion?(false, e)
                        return
                    }
                    completion?(true, nil)
                } else {
                    completion?(false, error as NSError?)
                }
            })
        }
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
    
    func onCarpoolSelected(action: UIAlertAction) {
        
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
    
    
    @IBAction func doneBtnfromKeyboardClicked (sender: Any) {
        print("Done Button Clicked.")
        //Hide Keyboard by endEditing or Anything you want.
        self.view.endEditing(true)
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
        
        
    }
    
    @IBAction func onDatePickerChanged(_ sender: UIDatePicker) {
        datePicked = sender.date
    }
    
    
    
    
    
    @IBAction func onTextFieldReturn(_ sender: UITextField) {
        query = sender.text
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











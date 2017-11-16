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
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionTextFieldOutlet: UITextField!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var shownInMapsButton: UIButton!
    
    let geocoder = CLGeocoder()
    let locationManager = CLLocationManager()
    var aLocation: CLPlacemark?
    var startTimePicked = Date()
    var endTimePicked = Date()
    var hasPickedEndTime: Bool = false
    var region: CLRegion?
    var query: String?
    var address: String?
    var dropOffPickUp: DropOffPickUp = .dropOff
    
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
        
        generateEvent(title: descriptionTextFieldOutlet.text!, startDate: startTimePicked, endDate: endTimePicked, description: "Carpool Event")
        guard let query = query, let aLocation = aLocation else { return API.createTrip(eventDescription: descriptionTextFieldOutlet.text!, eventTime: startTimePicked, eventLocation: nil) { (result) in
            
            switch result {
                
            case .success(let trip):
                API.set(endTime: self.endTimePicked, for: trip.event, completion: { (error) in
                    print("Did not set end time")
                })
                self.performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
            case .failure(_):
                print("error making trip")
            }
            }}
        if let description = descriptionTextFieldOutlet.text {
            if query == "" {
                API.createTrip(eventDescription: description, eventTime: startTimePicked, eventLocation: (aLocation.location ?? nil)!) { (result) in
                    
                    switch result {
                        
                    case .success(let trip):
                        API.set(endTime: self.endTimePicked, for: trip.event, completion: { (error) in
                            print("Did not set end time")
                        })
                        self.performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
                    case .failure(_):
                        print("error making trip")
                    }
                }
            } else {
                API.createTrip(eventDescription: description + ("\nAddress:") + query, eventTime: startTimePicked, eventLocation: (aLocation.location ?? nil)!) { (result) in
                    switch result {
                        
                    case .success(let trip):
                        API.set(endTime: self.endTimePicked, for: trip.event, completion: { (error) in
                            print("Did not set end time")
                        })
                        self.performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
                    case .failure(_):
                        print("error making trip")
                    }
                }
            }
        }
    }
    
    func onCarpoolSelected(action: UIAlertAction) {
        guard let query = query, let aLocation = aLocation else { return  API.createTrip(eventDescription: descriptionTextFieldOutlet.text!, eventTime: startTimePicked, eventLocation: nil) { (result) in
            
            switch result {
                
            case .success(let trip):
                API.set(endTime: self.endTimePicked, for: trip.event, completion: { (error) in
                    print("Did not set end time")
                })
                self.performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
            case .failure(_):
                print("error making trip")
            }
            }}
        if let description = descriptionTextFieldOutlet.text {
            if query == "" {
                API.createTrip(eventDescription: description, eventTime: startTimePicked, eventLocation: (aLocation.location ?? nil)!) { (result) in
                    
                    switch result {
                        
                    case .success(let trip):
                        API.set(endTime: self.endTimePicked, for: trip.event, completion: { (error) in
                            print("Did not set end time")
                        })
                        self.performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
                    case .failure(_):
                        print("error making trip")
                    }
                }
            } else {
                API.createTrip(eventDescription: description + ("\nAddress:") + query, eventTime: startTimePicked, eventLocation: (aLocation.location ?? nil)!) { (result) in
                    
                    switch result {
                        
                    case .success(let trip):
                        API.set(endTime: self.endTimePicked, for: trip.event, completion: { (error) in
                            print("Did not set end time")
                        })
                        self.performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
                    case .failure(_):
                        print("error making trip")
                    }
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
        
        
        shownInMapsButton.isHidden = true
        
    }
    
    @IBAction func SegmentedControlSwitched(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            dropOffPickUp = .dropOff
            datePickerOutlet.date = startTimePicked
        } else {
            dropOffPickUp = .pickUp
            datePickerOutlet.date = endTimePicked
        }
        
    }
    
    @IBAction func onDatePickerChanged(_ sender: UIDatePicker) {
        switch dropOffPickUp {
        case .dropOff:
            segmentControl.setTitle(datePickerOutlet.date.hourDesc, forSegmentAt: 0)
            startTimePicked = datePickerOutlet.date
            if !hasPickedEndTime {
                endTimePicked = startTimePicked
            }
        case .pickUp:
            segmentControl.setTitle(datePickerOutlet.date.hourDesc, forSegmentAt: 1)
            endTimePicked = datePickerOutlet.date
            hasPickedEndTime = true
        }
    }
    
    @IBAction func onTextFieldReturn(_ sender: UITextField) {
        query = sender.text
        if let queryA = sender.text {
            geocoder.geocodeAddressString(queryA) { (placemarks, error) in
                
                for placemark in placemarks! {
                    self.geocoder.reverseGeocodeLocation(placemark.location!, completionHandler: { (placemark, error) in
                        guard let placemark = placemark else { return }
                        self.aLocation = placemark.first
                        guard let aLocation = self.aLocation else { return }
                        self.address = String(describing: aLocation.name)
                        guard let address = self.address else { return }
                        let saveAlert = UIAlertController(title: "Is \(address) correct?", message: nil, preferredStyle: .actionSheet)
                        saveAlert.addAction(UIAlertAction(title: "Confirm location", style: .default, handler: self.onLocationSelection))
                        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(saveAlert, animated: true, completion: nil)
                        self.shownInMapsButton.isHidden = false
                    })
                }
            }
        }
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
    
    let appleEventStore = EKEventStore()
    var calendars: [EKCalendar]?
    func generateEvent(title: String, startDate: Date, endDate: Date, description: String) {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status)
        {
        case EKAuthorizationStatus.notDetermined:
            // This happens on first-run
            requestAccessToCalendar(title: title, startDate: startDate, endDate: endDate, description: description)
        case EKAuthorizationStatus.authorized:
            // User has access
            print("User has access to calendar")
            self.addAppleEvents(title: title, startDate: startDate, endDate: endDate, description: description)
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            // We need to help them give us permission
            noPermission()
        }
    }
    func noPermission()
    {
        print("User has to change settings...goto settings to view access")
    }
    
    
    
    func requestAccessToCalendar(title: String, startDate: Date, endDate: Date, description: String) {
        appleEventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                DispatchQueue.main.async {
                    print("User has access to calendar")
                    self.addAppleEvents(title: title, startDate: startDate, endDate: endDate, description: description)
                }
            } else {
                DispatchQueue.main.async{
                    self.noPermission()
                }
            }
        })
    }
    
    func addAppleEvents(title: String, startDate: Date, endDate: Date, description: String)
    {
        let event:EKEvent = EKEvent(eventStore: appleEventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.notes = description
        event.calendar = appleEventStore.defaultCalendarForNewEvents
        
        do {
            try appleEventStore.save(event, span: .thisEvent)
            print("events added with dates:")
        } catch let e as NSError {
            print(e.description)
            return
        }
        print("Saved Event")
    }
    
}










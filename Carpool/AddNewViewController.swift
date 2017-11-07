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


class AddNewViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var descriptionTextFieldOutlet: UITextField!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    @IBOutlet weak var locationSelectedLabel: UILabel!
    
    
    let locationManager = CLLocationManager()
    var aLocation: CLLocation = CLLocation(latitude: -56.6462520, longitude: -36.6462520)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(datePickerOutlet.date)
        locationManager.delegate = self
        
    }
    
    
    @IBAction func onDatePickerChanged(_ sender: UIDatePicker) {
    }
    
    @IBAction func onCancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
    }
    @IBAction func onAddButtonPressed(_ sender: Any) {
        if let description = descriptionTextFieldOutlet.text {
        API.createTrip(eventDescription: description, eventTime: datePickerOutlet.date, eventLocation: aLocation) { (trip) in
            
            
            self.performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
        }
        }
    }

    
    
}

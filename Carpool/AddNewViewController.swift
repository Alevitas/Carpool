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
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    @IBOutlet weak var dropOffDriverLabel: UILabel!
    
    @IBOutlet weak var pickUpDriverLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var aLocation: CLLocation = CLLocation(latitude: -56.6462520, longitude: -36.6462520)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
    }
    @IBAction func onCancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
    }
    @IBAction func onAddButtonPressed(_ sender: Any) {
        API.createTrip(eventDescription: descriptionTextView.text, eventTime: datePickerOutlet.date, eventLocation: aLocation) { (trip) in
            
            
            self.performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
        }
        
    }

    
    
}

//
//  AddNewViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/6/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import CarpoolKit

class AddNewViewController: UIViewController {
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    @IBOutlet weak var dropOffDriverLabel: UILabel!
    
    @IBOutlet weak var pickUpDriverLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    @IBAction func onCancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
    }
    @IBAction func onAddButtonPressed(_ sender: Any) {
        API.createTrip(eventDescription: descriptionTextView.text, eventTime: datePickerOutlet.date, eventLocation: CLLocation()) { (trip) in
            
            
            performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
        }
        
    }
    @IBAction func setDropOffButton(_ sender: Any) {
    }
    @IBAction func setPickUpButton(_ sender: Any) {
    }
    
    
    
}

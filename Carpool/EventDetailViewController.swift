//
//  EventDetailViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/6/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import CarpoolKit
import CoreLocation

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var pickUpButton: UIButton!
    @IBOutlet weak var dropOffButton: UIButton!
    
    var trip: Trip!
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let trip = trip {
            print("Event received is: \(trip.event)")
            
            descriptionLabel.text = trip.event.description
            
            timeLabel.text = String(describing: trip.event.time)
            
            locationLabel.text = trip.event.location.description
            
            if !trip.pickUp.isClaimed {
                pickUpButton.backgroundColor = UIColor.red
            }

            if !trip.dropOff.isClaimed {
                dropOffButton.backgroundColor = UIColor.red
            }
        }
    }
    
    @IBAction func onPickUpButtonPressed(_ sender: Any) {
        pickUpButton.backgroundColor = UIColor.green
    }
    
    @IBAction func onDropOffButtonPressed(_ sender: Any) {
        dropOffButton.backgroundColor = UIColor.green
    }
    
}

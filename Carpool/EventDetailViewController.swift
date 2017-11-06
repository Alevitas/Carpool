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
    
    var trip: Trip!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Event received is: \(trip.event)")

        descriptionLabel.text = trip.event.description
        
        timeLabel.text = String(describing: trip.event.time)

        locationLabel.text = trip.event.location.description
    }
    
    
}

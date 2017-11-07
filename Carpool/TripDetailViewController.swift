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

class TripDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pickUpButton: UIButton!
    @IBOutlet weak var dropOffButton: UIButton!
    
    @IBOutlet weak var pickUpDriverLabel: UILabel!
    
    @IBOutlet weak var dropOffDriverLabel: UILabel!
    
    var trip: Trip!
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let trip = trip {
            print("Event received is: \(trip.event)")
            
            descriptionLabel.text = trip.event.description
            
            timeLabel.text = trip.event.time.prettyDate
            dropOffButton.setRoundEdge()
            pickUpButton.setRoundEdge()
            
            if !(trip.pickUp?.isClaimed)! {
                pickUpButton.backgroundColor = UIColor.red
            } else {
                pickUpDriverLabel.text = trip.pickUp?.driver?.name
            }

            if !(trip.dropOff?.isClaimed)! {
                dropOffButton.backgroundColor = UIColor.red
            } else {
                dropOffDriverLabel.text = trip.dropOff?.driver?.name
            }
        }
    }
    
    @IBAction func onPickUpButtonPressed(_ sender: Any) {
        let saveAlert = UIAlertController(title: "Do you want to claim this leg?", message: nil, preferredStyle: .actionSheet)
        saveAlert.addAction(UIAlertAction(title: "Claim PickUp Leg", style: .default, handler: onClaimPickUp))
        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(saveAlert, animated: true, completion: nil)
    }
    
    @IBAction func onDropOffButtonPressed(_ sender: Any) {
        let saveAlert = UIAlertController(title: "Do you want to claim this leg?", message: nil, preferredStyle: .actionSheet)
        saveAlert.addAction(UIAlertAction(title: "Claim DropOff Leg", style: .default, handler: onClaimDropOff))
        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(saveAlert, animated: true, completion: nil)
    }
    
    func onClaimPickUp(action: UIAlertAction) {
        pickUpButton.backgroundColor = UIColor.green
        API.claimPickUp(trip: trip) { (error) in
            self.pickUpDriverLabel.text = self.trip.pickUp?.driver?.name
            print("Error claiming PickUp: \(String(describing: error))")
        }
    }
    
    func onClaimDropOff(action: UIAlertAction) {
        dropOffButton.backgroundColor = UIColor.green
        API.claimDropOff(trip: trip) { (error) in
            self.dropOffDriverLabel.text = self.trip.dropOff?.driver?.name
            print("Error claiming DropOff: \(String(describing: error))")
        }
    }
}

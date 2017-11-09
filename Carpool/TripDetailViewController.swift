//
//  EventDetailViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/6/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import MapKit
import CarpoolKit
import CoreLocation

class TripDetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pickUpButton: UIButton!
    @IBOutlet weak var dropOffButton: UIButton!
    @IBOutlet weak var childrenNameTextField: UITextField!
    
    @IBOutlet weak var alertTextLabel: UILabel!

    @IBOutlet weak var pickUpDriverLabel: UILabel!
    @IBOutlet weak var dropOffDriverLabel: UILabel!
    
    var trip: Trip!
    var child: Child!
    var loggedInUser: User!
    var currentUser: String = ""
    var children: [Child] = []
    
    let locationManager = CLLocationManager()
    var aLocation: CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let trip = trip else { return }
        
        print("Event received is: \(trip.event)")
        locationManager.delegate = self

        descriptionLabel.text = trip.event.description
        childrenNameTextField.text = makeListOfChildren(childrenList: trip.event.owner.children)

        timeLabel.text = Date(timeIntervalSince1970: trip.event.time.timeIntervalSince1970).prettyDate
        dropOffButton.setRoundEdge()
        pickUpButton.setRoundEdge()
        
        if trip.pickUp?.driver == nil {
            pickUpButton.backgroundColor = UIColor.red
        } else {
            pickUpDriverLabel.text = trip.pickUp?.driver.name
        }
        
        if trip.dropOff?.driver == nil {
            dropOffButton.backgroundColor = UIColor.red
        } else {
            dropOffDriverLabel.text = trip.dropOff?.driver.name
        }
        alertTextLabel.text = trip.alertText
    }
    
    @IBAction func onChildrenNameChanged(_ sender: UITextField) {
        if let childName = sender.text {
            API.addChild(name: childName, completion: { ( result ) in
                switch result {
                case .success(let child):
                    self.children.append(child)
                case .failure(let error):
                    print("Error adding child.", error)
                }
            })
        }
    }
    
    @IBAction func onOpenInMapsPressed(_ sender: Any) {
        if let addressDict = aLocation?.addressDictionary, let coordinate = aLocation?.location?.coordinate {
            let mkPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict as? [String : Any])
            let mapItem = MKMapItem(placemark: mkPlacemark)
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
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
    
    func makeListOfChildren(childrenList: [Child]) -> String {
        var childNames: [String] = []
        
        for child in childrenList {
            childNames.append(child.name)
        }
        return childNames.joined(separator: ", ")
    }
    
    func onClaimPickUp(action: UIAlertAction) {
        pickUpButton.backgroundColor = UIColor.green
        API.claimPickUp(trip: trip) { (error) in
            self.pickUpDriverLabel.text = self.trip.pickUp?.driver.name
            print("Error claiming PickUp: \(String(describing: error))")
        }
    }
    
    func onClaimDropOff(action: UIAlertAction) {
        dropOffButton.backgroundColor = UIColor.green
        API.claimDropOff(trip: trip) { (error) in
            self.dropOffDriverLabel.text = self.trip.dropOff?.driver.name
            print("Error claiming DropOff: \(String(describing: error))")
        }
    }
}

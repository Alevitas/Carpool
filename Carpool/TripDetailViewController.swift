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

class TripDetailViewController: UITableViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var openInMapsButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pickUpButton: UIButton!
    @IBOutlet weak var dropOffButton: UIButton!
    @IBOutlet weak var dropOffTimeButton: UIButton!
    @IBOutlet weak var pickUpTimeButton: UIButton!
    
    @IBOutlet weak var childrenNameLabel: UILabel!
    @IBOutlet weak var childrenNameTextField: UITextField!
    
    @IBOutlet weak var dropOffDatePicker: UIDatePicker!
    @IBOutlet weak var pickUpDatePicker: UIDatePicker!
    
    @IBOutlet weak var alertTextLabel: UILabel!
    
    @IBOutlet weak var pickUpDriverLabel: UILabel!
    @IBOutlet weak var dropOffDriverLabel: UILabel!
    
    var trip: Trip!
    var child: Child!
    var loggedInUser: User!
    var children: [Child] = []
    var dropOffPickUp: DropOffPickUp = .dropOff
    
    let locationManager = CLLocationManager()
    var aLocation: CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let trip = trip else { return }
        
        //      tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backGroundimage2"))
        //        if trip.hasLocation {
        //            openInMapsButton.isHidden = false
        //        } else {
        //            openInMapsButton.isHidden = true
        //        }
        
        print("Event received is: \(trip.event)")
        locationManager.delegate = self

        descriptionLabel.text = trip.alertText
        
        childrenNameLabel.text = trip.event.owner.stringOfChildNames

        self.title = trip.event.time.prettyDay
        dropOffTimeButton.setTitle(trip.event.time.hourDesc, for: .normal)
        pickUpTimeButton.setTitle(trip.event.endTime?.hourDesc, for: .normal)
        
        dropOffButton.setRoundEdge()
        pickUpButton.setRoundEdge()
        descriptionLabel.setRoundEdge()
        
        if trip.myDropOffLeg {
            dropOffButton.setTitle("Unclaim", for: .normal)
        } else {
            dropOffButton.setTitle("Claim", for: .normal)

        }

        if !trip.dropOffLegClaimed {
            dropOffButton.backgroundColor = UIColor.red
        } else {
            dropOffButton.backgroundColor = UIColor.green
            dropOffDriverLabel.text = trip.dropOff?.driver.name
        }

        if trip.myPickUpLeg {
            pickUpButton.setTitle("Unlaim", for: .normal)
        } else {
            pickUpButton.setTitle("Claim", for: .normal)
        }
        
        if !trip.pickUpLegClaimed {
            pickUpButton.backgroundColor = UIColor.red
        } else {
            pickUpButton.backgroundColor = UIColor.green
            pickUpDriverLabel.text = trip.pickUp?.driver.name
        }
        //alertTextLabel.text = trip.alertText
    }
    
    @IBAction func onSelectTimeButtonPressed(_ sender: UIButton) {
        switch dropOffPickUp {
        case .dropOff:
            dropOffTimeButton.setTitle(dropOffDatePicker.date.hourDesc, for: .normal)
        case .pickUp:
            pickUpTimeButton.setTitle(dropOffDatePicker.date.hourDesc, for: .normal)
        }
    }
    
    @IBAction func onDropOffTimeButtonPressed(_ sender: UIButton) {
        dropOffPickUp = .dropOff
        UIView.animate(withDuration: 0.3, animations: {
            self.dropOffDatePicker.isHidden = !self.dropOffDatePicker.isHidden
        })
        dropOffDatePicker.date = trip.event.time
    }
    
    @IBAction func onPickUpTimeButtonPressed(_ sender: UIButton) {
        dropOffPickUp = .pickUp
        UIView.animate(withDuration: 0.3, animations: {
            self.pickUpDatePicker.isHidden = !self.pickUpDatePicker.isHidden
        })
        pickUpDatePicker.date = trip.event.endTime!
    }
    
    @IBAction func onDropOffLegDatePickerChanged(_ sender: UIDatePicker) {
        dropOffTimeButton.setTitle(dropOffDatePicker.date.hourDesc, for: .normal)
    }
    
    @IBAction func onPickUpLegDatePickerChanged(_ sender: UIDatePicker) {
        pickUpTimeButton.setTitle(pickUpDatePicker.date.hourDesc, for: .normal)
    }
    
    @IBAction func onAddChildrenPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "AddChildren", sender: self)
    }
    
    @IBAction func onRecurringSwitchChanged(_ sender: UISwitch) {
    }
    
    
    @IBAction func onViewCommentsPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Comments", sender: self)
    }
    
    @IBAction func onChildrenNameChanged(_ sender: UITextField) {
        if let childName = sender.text, childName != "" {
            API.addChild(name: childName, completion: { ( result ) in
                switch result {
                case .success(let child):
                    self.children.append(child)
                case .failure(let error):
                    print("Error adding child.", error)
                }
            })
        } else {
            //TODO Error: Don't let them add if the child name is empty
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
        if !trip.myPickUpLeg {
            saveAlert.addAction(UIAlertAction(title: "Claim PickUp Leg", style: .default, handler: onClaimPickUp))
        }
        if trip.myPickUpLeg {
            saveAlert.addAction(UIAlertAction(title: "Unclaim PickUp Leg", style: .default, handler: onUnclaimPickup))
        }
        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(saveAlert, animated: true, completion: nil)
    }
    
    @IBAction func onDropOffButtonPressed(_ sender: Any) {
        let saveAlert = UIAlertController(title: "Do you want to claim this leg?", message: nil, preferredStyle: .actionSheet)
        if !trip.myDropOffLeg {
            saveAlert.addAction(UIAlertAction(title: "Claim DropOff Leg", style: .default, handler: onClaimDropOff))
        }
        if trip.myDropOffLeg {
            saveAlert.addAction(UIAlertAction(title: "Unclaim DropOff Leg", style: .default, handler: onUnclaimDropOff))
        }
        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(saveAlert, animated: true, completion: nil)
    }
    
    func onClaimPickUp(action: UIAlertAction) {
        pickUpButton.backgroundColor = UIColor.green
        API.claimPickUp(trip: trip) { (error) in
            self.pickUpDriverLabel.text = self.trip.pickUp?.driver.name
            print("Error claiming PickUp: \(String(describing: error))")
        }
    }
    
    func onUnclaimPickup(action: UIAlertAction) {
        pickUpButton.backgroundColor = UIColor.red
        API.unclaimPickUp(trip: trip) { (error) in
            self.pickUpDriverLabel.text = "Driver unclaimed."
        }
    }
    
    func onClaimDropOff(action: UIAlertAction) {
        dropOffButton.backgroundColor = UIColor.green
        API.claimDropOff(trip: trip) { (error) in
            self.dropOffDriverLabel.text = self.trip.dropOff?.driver.name
            print("Error claiming DropOff: \(String(describing: error))")
        }
    }
    
    func onUnclaimDropOff(action: UIAlertAction) {
        dropOffButton.backgroundColor = UIColor.red
        API.unclaimDropOff(trip: trip) { (error) in
            self.dropOffDriverLabel.text = "Driver unclaimed."
        }
    }
    
    @IBAction func unwindFromCommentVC(segue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindFromAddChildrenVC(segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addChildrenVC = segue.destination as? AddChildrenViewController {
            addChildrenVC.children = trip.children
        }
        if let commentsVC = segue.destination as? CommentsViewController {
            commentsVC.comments = trip.comments
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
}

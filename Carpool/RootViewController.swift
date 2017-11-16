//
//  RootViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/6/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import CarpoolKit
import FirebaseCommunity

class RootViewController: UITableViewController {
    
    var trips: [Trip] = []
    var trip: Trip!
    var tripCalendar: API.TripCalendar?
    
    var legsChecked: LegsClaimed {
        if let trip = trip {
            if !trip.pickUpLegClaimed, !trip.dropOffLegClaimed {
                return .red
            } else if trip.pickUpLegClaimed , !trip.dropOffLegClaimed {
                return .yellow
            } else if !trip.pickUpLegClaimed, trip.dropOffLegClaimed {
                return .yellow
            } else if trip.pickUpLegClaimed , trip.dropOffLegClaimed {
                return .green
            }
        } else {
            print("Error checking legs of trip.")
        }
        return .red
    }
    
    @IBOutlet weak var segmentedButton: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backGroundimage2"))
        API.observeMyTripCalendar(sender: self, observer: { (result) in
            switch result {
                
            case .success(let tripCalendarDownloaded):
                
                self.trips = tripCalendarDownloaded.trips
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    @IBAction func onSegmentedControlChange(_ sender: UISegmentedControl) {
        if segmentedButton.selectedSegmentIndex == 1 {
            API.observeTheTripsOfMyFriends(sender: self) { (result) in
                switch result {
                    
                case .success(let tripsDownloaded):
                    self.trips = tripsDownloaded
                    self.tableView.reloadData()
                    print(self.trips)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            
            
            API.observeMyTripCalendar(sender: self, observer: { (result) in
                switch result {
                    
                case .success(let tripCalendarDownloaded):
                    
                    self.trips = tripCalendarDownloaded.trips
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Trips", for: indexPath) as! TripCell
        
        trip = trips[indexPath.row]
        switch legsChecked {
        case .red:
            cell.legStatusView.layer.backgroundColor = UIColor.red.cgColor
        case .yellow:
            cell.legStatusView.layer.backgroundColor = UIColor.yellow.cgColor
        case .green:
            cell.legStatusView.layer.backgroundColor = UIColor.green.cgColor
        }
        
        if trips[indexPath.row].repeats == true {
            cell.eventDetailsView.layer.borderColor = UIColor.blue.cgColor
            cell.eventDetailsView.layer.borderWidth = 1.0
        } else {
            cell.eventDetailsView.layer.borderColor = UIColor.black.cgColor
        }
        
        cell.selectionStyle = .none
        cell.eventNameLabel.text = trips[indexPath.row].alertText + "\n Comments: \(trips[indexPath.row].comments.count.description)"
        cell.eventMonthLabel.text = trips[indexPath.row].event.time.shortMonthDay
        cell.eventTimeLabel.text = trips[indexPath.row].event.time.shortDayName
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let eventDetailVC = segue.destination as? TripDetailViewController
        
        eventDetailVC?.trip = trip
    }
    
    @IBAction func unwindFromEventDetail(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindFromAddNew(segue: UIStoryboardSegue) {
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        do {
            try API.delete(trip: trips[indexPath.row])
            trips.remove(at: indexPath.row)
            tableView.reloadData()
        } catch {
            print("error happened here")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        trip = trips[indexPath.row]
        performSegue(withIdentifier: "ToEventDetails", sender: self)
    }
}


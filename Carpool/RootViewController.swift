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
    var currentUser: String?
    
    @IBOutlet weak var segmentedButton: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        currentUser = Auth.auth().currentUser?.displayName
        API.observeTrips(sender: self) { (result) in
            switch result {
                
            case .success(let tripsDownloaded):
                self.trips = tripsDownloaded
                self.tableView.reloadData()
                print(self.trips)
            case .failure(let error):
                print(error)
            }
        }
        
    }
  
    
    @IBAction func onSegmentedControlChange(_ sender: UISegmentedControl) {
        if segmentedButton.selectedSegmentIndex == 0 {
            API.observeTrips(sender: self) { (result) in
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
            API.observeMyTrips(sender: self, observer: { (result) in
                switch result {
                    
                case .success(let tripsDownloaded):
                    self.trips = tripsDownloaded
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
        
        //        cell.eventNameLabel.text = trips[indexPath.row].event.description
//        cell.eventDetailsView.layer.cornerRadius = 10
//        cell.eventDetailsView.layer.borderWidth = 1.0
//        cell.eventDetailsView.layer.borderColor = UIColor.black.cgColor
//        cell.eventDetailsView.layer.shadowColor = UIColor.black.cgColor
//        cell.eventDetailsView.layer.shadowOpacity = 0.3
//        cell.eventDetailsView.layer.shadowOffset = CGSize(width: 3, height: 3)
//        cell.eventDetailsView.layer.shadowRadius = 1.0
//        
//        cell.legStatusView.layer.cornerRadius = 10
//        cell.legStatusView.layer.borderWidth = 1.0
//        cell.legStatusView.layer.borderColor = UIColor.black.cgColor
//        cell.legStatusView.layer.shadowColor = UIColor.black.cgColor
//        cell.legStatusView.layer.shadowOpacity = 0.3
//        cell.legStatusView.layer.shadowOffset = CGSize(width: 3, height: 3)
//        cell.legStatusView.layer.shadowRadius = 1.0
        
        
        cell.eventNameLabel.text = trips[indexPath.row].alertText
        
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


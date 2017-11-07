//
//  RootViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/6/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import CarpoolKit

class RootViewController: UITableViewController {

    var trips: [Trip] = []
    var trip: Trip!
    var currentUser: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.observeTrips { (trip) in
            self.trips = trip
            self.tableView.reloadData()
            print(self.trips)
        }
        
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Trips", for: indexPath) as! TripCell
        
        cell.eventNameLabel.text = trips[indexPath.row].event.description
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let eventDetailVC = segue.destination as? TripDetailViewController
        
        eventDetailVC?.currentUser = currentUser
        eventDetailVC?.trip = trip
       
    }

    @IBAction func unwindFromAddNew(segue: UIStoryboardSegue) {
//        let addNewVC = segue.source as! AddNewViewController
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        trip = trips[indexPath.row]
        performSegue(withIdentifier: "ToEventDetails", sender: self)
    }
}


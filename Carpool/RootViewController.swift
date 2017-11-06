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
    var event: Event!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.fetchTripsOnce { (trip) in
            self.trips = trip
        }
        tableView.reloadData()
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Events", for: indexPath)
        
        cell.textLabel?.text = trips[indexPath.row].event.description
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let eventDetailVC = segue.destination as? EventDetailViewController
        
        
        eventDetailVC?.event = event
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        event = trips[indexPath.row].event
    }
}


//
//  FriendsViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/10/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import Foundation
import UIKit
import CarpoolKit

class FriendsViewController: UITableViewController {
    @IBOutlet weak var segmentedControl: UIBarButtonItem!
    
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var friendSearch: UITextField!
    
    var friends: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.observeFriends(sender: self) { (result) in
            switch result {
                
            case .success(let downloadedFriends):
                self.friends = downloadedFriends
                self.tableView.reloadData()
            case .failure(_):
                print("error")
            }
        }
        
        
    }
    @IBAction func segmentedButtonChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            searchBarView.isHidden = true
            API.observeFriends(sender: self) { (result) in
                switch result {
                    
                case .success(let downloadedFriends):
                    self.friends = downloadedFriends
                    self.tableView.reloadData()
                case .failure(_):
                    print("error")
                }
            }
        } else {
            searchBarView.isHidden = false
            friends = []
            tableView.reloadData()
        }
    }
    @IBAction func onFriendSearchReturn(_ sender: UITextField) {
        API.search(forUsersWithName: sender.text!) { (result) in
            switch result{
                
            case .success(let downloadedFriends):
                self.friends = downloadedFriends
                self.tableView.reloadData()
            case .failure(_):
                print("error")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Friend", for: indexPath) as! FriendCell
        
        
        
        
        return cell
    }
    
}

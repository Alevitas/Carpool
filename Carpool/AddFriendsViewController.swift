//
//  AddFriendsViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/13/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import Foundation
import UIKit
import CarpoolKit

class AddFriendsViewController: UITableViewController {
    @IBOutlet weak var searchTextField: UITextField!
    
    var friends: [User] = []
    var currentFriends: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backGroundimage2"))
        
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    @IBAction func onSearchFieldReturn(_ sender: UITextField) {
        API.search(forUsersWithName: sender.text!) { (result) in
            switch result{
                
            case .success(let downloadedFriends):
                self.friends = downloadedFriends
                self.tableView.reloadData()
                print(self.friends)
            case .failure(let error):
                print("\nError getting Users:", error)
            }
        }
        searchTextField.text = ""
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendSearch", for: indexPath) as! AddFriendCell
        
        cell.friendNameLabel.text = friends[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !currentFriends.contains(friends[indexPath.row]) {
            API.add(friend: friends[indexPath.row])
            performSegue(withIdentifier: "UnwindFromAddFriends", sender: self)
        } else {
            self.title = "Already a friend"
            var seconds = 5
            var timer = Timer()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                seconds -= 1
                
                if seconds <= 0 {
                    self.title = "Add friends"
                }
            })
        }
    }
    
}

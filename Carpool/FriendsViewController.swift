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
    
    
    var friends: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.observeFriends(sender: self) { (result) in
            switch result {
                
            case .success(let downloadedFriends):
                self.friends = downloadedFriends
            case .failure(_):
                print("error")
            }
        }
        
        
    }
    
    
    
}

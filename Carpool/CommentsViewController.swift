//
//  CommentsViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/14/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import Foundation
import UIKit
import CarpoolKit

class CommentsViewController: UITableViewController {
    
    var comments: [Comment] = []
    var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Comments", for: indexPath) as! CommentsCell
        
        cell.commentLabel.text = comments[indexPath.row].body
        cell.userNameLabel.text = comments[indexPath.row].user.name
        cell.dateLabel.text = comments[indexPath.row].time.dayHour
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addCommentsVC = segue.destination as! AddCommentsViewController
        
        addComments.trip = trip
        
    }
    
}

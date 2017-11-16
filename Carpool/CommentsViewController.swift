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
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backGroundimage2"))
        tableView.reloadData()
        guard let trip = trip else { return }
        API.observe(trip: trip, sender: self) { (result) in
            switch result {
                
            case .success(let trip):
                self.trip = trip
                self.tableView.reloadData()
            case .failure(_):
                print("error happened here")
            }
        }
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
        
        addCommentsVC.trip = trip
        
    }
    
    @IBAction func unwindFromAddComments(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

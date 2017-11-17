//
//  AddChildrenViewController.swift
//  Carpool
//
//  Created by Gary on 11/15/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import CarpoolKit

class AddChildrenViewController: UITableViewController {
    
    @IBOutlet weak var childNameTextField: UITextField!
    @IBOutlet weak var childNameTextFieldView: UIView!
    
    var trip: Trip!
    var myChildren: [String] = []
    var tripChildren: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backGroundimage2"))
        myChildren = []
        for child in trip.event.owner.children {
            myChildren.append(child.name)
            tableView.reloadData()
        }
        tripChildren = []
        for tripChild in trip.children {
            tripChildren.append(tripChild.name)
            tableView.reloadData()
        }
    }
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        if let childName = childNameTextField.text, childName != "" {
            do {
                let indexPath = tableView.indexPathForSelectedRow
                try API.add(child: trip.event.owner.children[(indexPath?.row)!], to: trip)
            } catch {
                print("Error adding child: ", error)
            }
        } else { //TODO Child name cannot be blank
            print("Childname cannot be blank.")
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "My Children"
        } else {
            return "Trip Children"
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return myChildren.count
        } else {
            return tripChildren.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildNameCell", for: indexPath) as! ChildNameCell
        if indexPath.section == 0 {
            cell.childNameLabel.text = myChildren[indexPath.row]
        } else if indexPath.section == 1{
            cell.childNameLabel.text = tripChildren[indexPath.row]
        }
        return cell
    }
    
}

class ChildNameCell: UITableViewCell {
    
    @IBOutlet weak var childNameCellView: UIView!
    @IBOutlet weak var childNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        childNameCellView.layer.cornerRadius = 10
        childNameCellView.layer.borderWidth = 0.5
        childNameCellView.layer.borderColor = UIColor.black.cgColor
    }
    
}


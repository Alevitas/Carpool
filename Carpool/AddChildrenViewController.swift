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
    var newChild: Child!
    var myChildren: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("children received is: \(trip.children)")
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backGroundimage2"))
        myChildren = []
        for child in trip.children {
            myChildren.append(child.name)
            tableView.reloadData()
        }
        print("myChildren are: \(myChildren)\n")
    }
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        if let childName = childNameTextField.text, childName != "" {
            do {
                try newChild = Child(from: childName as! Decoder)
                try API.add(child: newChild, to: trip)
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myChildren.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildNameCell", for: indexPath) as! ChildNameCell
        cell.childNameLabel.text = myChildren[indexPath.row]
        print("Trying to display \(myChildren[indexPath.row])")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        do {
            try API.ruthlesslyKillChildWithoutRemorseOrMoralCompassLikeDudeWhatKindOfPersonAreYouQuestionMark((trip.children[indexPath.row]))
            myChildren.remove(at: indexPath.row)
            tableView.reloadData()
        } catch {
            print("error happened here")
        }
        
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


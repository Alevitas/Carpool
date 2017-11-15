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
    
    @IBOutlet weak var childNameView: UIView!
    @IBOutlet weak var childNameTextField: UITextField!
    
    var children: [Child] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backGroundimage2"))
    }

    @IBAction func onAddButtonPressed(_ sender: Any) {
        if let childName = childNameTextField.text, childName != "" {
            API.addChild(name: childName, completion: { (result) in
                switch result {
                case .success(let child):
                    self.children.append(child)
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error adding child: ", error)
                }
            })
        } else { //TODO Child name cannot be blank
            print("Childname cannot be blank.")
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return children.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildNameCell", for: indexPath) as! ChildNameCell
        cell.childNameLabel.text = children[indexPath.row].name
        
        return cell
    }
}

class ChildNameCell: UITableViewCell {
    
    @IBOutlet weak var childNameView: UIView!
    @IBOutlet weak var childNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        childNameView.layer.cornerRadius = 10
        childNameView.layer.borderWidth = 0.5
        childNameView.layer.borderColor = UIColor.black.cgColor
    }
    
}


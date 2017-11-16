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
    
    var children: [Child] = []
    var myChildren: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("children received is: \(children)")
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backGroundimage2"))
        myChildren = []
        for child in children {
            myChildren.append(child.name)
            tableView.reloadData()
        }
        print("myChildren are: \(myChildren)\n")
    }
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        if let childName = childNameTextField.text, childName != "" {
            API.addChild(name: childName, completion: { (result) in
                switch result {
                case .success(let child):
                    self.myChildren.append(child.name)
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
        return myChildren.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildNameCell", for: indexPath) as! ChildNameCell
        cell.childNameLabel.text = myChildren[indexPath.row]
        print("Trying to display \(myChildren[indexPath.row])")
        
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


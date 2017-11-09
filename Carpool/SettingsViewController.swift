//
//  SettingsViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/9/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import FirebaseCommunity
import CarpoolKit

class SettingsViewController: UIViewController {
   
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var childrenAddedLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    var children: [Child] = []
//    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.setRoundEdge()
//        childrenAddedLabel.text = makeListOfChildren(childrenList: )
    }
    @IBAction func usernameTextFieldEnter(_ sender: UITextField) {
//        usernameTextField.placeholder = "\()"
        API.set(userFullName: sender.text!)
        
    }
    
    func makeListOfChildren(childrenList: [Child]) -> String {
        var childNames: [String] = []
        
        for child in childrenList {
            childNames.append(child.name)
        }
        return childNames.joined(separator: ", ")
    }
    
    
    @IBAction func addChildrenTextFieldEnter(_ sender: UITextField) {
        if let child = sender.text {
            API.addChild(name: child) { (result) in
                switch result {
                case .success(let child):
                    self.children.append(child)
                case .failure(let error):
                    print("Error adding child.")
                }
            }
        }
    }
    @IBAction func logoutButonPressed(_ sender: Any) {
    }
    
    
}


//
//  SettingsViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/9/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import CarpoolKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var childrenAddedLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    var children: [Child] = []
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.fetchCurrentUser { (result) in
            switch result {
                
            case .success(let user):
                self.currentUser = user
            case .failure(_):
                print("Error retreiving current user")
            }
        }
        
        logoutButton.setRoundEdge()
        if let currentChildren = currentUser._children{
            childrenAddedLabel.text = makeListOfChildren(childrenList: currentChildren )
        } else {
            print("error")
        }
    }
    @IBAction func usernameTextFieldEnter(_ sender: UITextField) {
        
        usernameTextField.placeholder = "\(String(describing: currentUser.name ?? "Username"))"
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
                case .failure(_):
                    print("Error adding child.")
                }
            }
        }
    }
    @IBAction func logoutButonPressed(_ sender: Any) {
    }
    
    
}


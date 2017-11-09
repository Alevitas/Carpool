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
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var childrenAddedLabel: UILabel!
    var children: [Child] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        childrenAddedLabel.text = makeListOfChildren(childrenList: )
    }
    @IBAction func usernameTextFieldEnter(_ sender: UITextField) {
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


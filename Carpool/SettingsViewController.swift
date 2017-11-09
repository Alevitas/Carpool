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
    var children: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    @IBAction func usernameTextFieldEnter(_ sender: UITextField) {
    }
    
    @IBAction func addChildrenTextFieldEnter(_ sender: UITextField) {
        if let child = sender.text {
            API.addChild(name: child) { (<#Result<Child>#>) in
                <#code#>
            }
        }
    }
    @IBAction func logoutButonPressed(_ sender: Any) {
    }
    
    
}


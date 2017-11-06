//
//  AddNewViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/6/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController {
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    @IBAction func onCancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
    }
    @IBAction func onAddButtonPressed(_ sender: Any) {
         performSegue(withIdentifier: "UnwindFromAddNew", sender: self)
    }
    
    
    
}

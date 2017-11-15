//
//  AddCommentsViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/14/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import Foundation
import UIKit
import CarpoolKit

class AddCommentsViewController: UIViewController {
    
    var trip: Trip?
    
    @IBOutlet weak var commentsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTextView.layer.cornerRadius = 10
        
    }
    
    @IBAction func onSubmitPressed(_ sender: UIButton) {
        guard let trip = trip else { return }
        API.add(comment: commentsTextView.text, to: trip)
        performSegue(withIdentifier: "AddCommentsUnwind", sender: self)
    }
    
}

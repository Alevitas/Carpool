//
//  HelpViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/13/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import Foundation
import UIKit


class HelpViewController: UIViewController {
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    @IBAction func carpoolScreenButtonPressed(_ sender: Any) {
        sectionLabel.text = "Carpool Screen:"
        infoTextView.text = "On this screen you are presented all of the trips along with their main details. The color of the left bubble shows whether or not both drop off and pickup are claimed. If red, both are unclaimed; green, both are claimed; yellow if either one is claimed and the other is unclaimed. Selecting a row will open up the event details screen. Pressing on the plus sign on the top right opens the create new event screen."
    }
    @IBAction func createNewButtonPressed(_ sender: Any) {
        sectionLabel.text = "Create New Trip:"
        infoTextView.text = "On this screen you are presented all of the fields required in order to create a new trip. The first thing you must do is write a description of the trip which can be as detailed as you want. Next up is selecting the date and time. You may enter an exact address in the location field which is optional but if provided will allow you to open the location up in maps with the 'show in maps button'. Once you have filled out all of the required fields, hit confirm and the new trip will be added."
    }
    @IBAction func modifyExistingPressed(_ sender: Any) {
        sectionLabel.text = "How to modify existing trips:"
        infoTextView.text = "From the trips screen, select any trip you would like to modify and it will take you to a new screen with all the options. The fields available for editing are pick up and drop off drivers, the times for both, and the children involved. If a location was selected in the create new screen then you may click open in maps to get directions."
    }
    @IBAction func addFriendButtonPressed(_ sender: Any) {
        sectionLabel.text = "Adding friends:"
        infoTextView.text = "For the app to have its full functionality, you probably would want it to help coordinate with your friends. The trips screen has two options which is to view your own trips and those of your friends. To add new friends, go to the friends tab and click the plus sign. A search bar will be available for you to search for your friends name and selecting them will add them to your list. You may remove them on the friends screen by swiping left on the row."
    }
    
}

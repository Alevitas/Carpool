//
//  AddFriendCell.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/13/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import Foundation
import UIKit

class AddFriendCell: UITableViewCell {
    
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var addFriendView: UIView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        addFriendView.layer.cornerRadius = 10
        addFriendView.layer.borderWidth = 0.5
        addFriendView.layer.borderColor = UIColor.black.cgColor
        
        
    }
    
    
    
}

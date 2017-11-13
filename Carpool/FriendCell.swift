//
//  FriendCell.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/10/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import Foundation
import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var friendView: UIView!
    @IBOutlet weak var friendNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        friendView.layer.cornerRadius = 10
        friendView.layer.borderWidth = 1.0
        friendView.layer.borderColor = UIColor.black.cgColor
        friendView.layer.shadowColor = UIColor.black.cgColor
        friendView.layer.shadowOpacity = 0.3
        friendView.layer.shadowOffset = CGSize(width: 3, height: 3)
        friendView.layer.shadowRadius = 1.0
        
        
    }
    
    
    
}

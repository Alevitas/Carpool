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
    
    @IBOutlet weak var friendIconView: UIView!
    @IBOutlet weak var friendView: UIView!
    @IBOutlet weak var friendNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        friendIconView.layer.cornerRadius = friendIconView.frame.size.width/2
        friendIconView.clipsToBounds = true
        
        friendIconView.layer.borderColor = UIColor.white.cgColor
        friendIconView.layer.borderWidth = 5.0
        
        friendView.layer.cornerRadius = 10
        friendView.layer.borderWidth = 0.5
        friendView.layer.borderColor = UIColor.black.cgColor
        
        
        
    }
    
    
    
}

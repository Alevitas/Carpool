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
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        iconView.layer.cornerRadius = 10
        iconView.layer.borderColor = UIColor.black.cgColor
        iconView.layer.borderWidth = 0.5
        
        iconImageView.layer.cornerRadius = 10
        iconImageView.layer.borderWidth = 0.5
        iconImageView.layer.borderColor = UIColor.black.cgColor
        
        friendView.layer.cornerRadius = 10
        friendView.layer.borderWidth = 0.5
        friendView.layer.borderColor = UIColor.black.cgColor
        
        
        
    }
    
    
    
}

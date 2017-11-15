//
//  ChildNameCell.swift
//  Carpool
//
//  Created by Gary on 11/15/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit

class ChildNameCell: UITableViewCell {
    
    @IBOutlet weak var childNameView: UIView!
    @IBOutlet weak var childNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        childNameView.layer.cornerRadius = 10
        childNameView.layer.borderWidth = 0.5
        childNameView.layer.borderColor = UIColor.black.cgColor
    }
    
}

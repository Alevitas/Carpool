//
//  EventCell.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/6/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit

class TripCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDetailsView: UIView!
    @IBOutlet weak var legStatusView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        eventDetailsView.layer.cornerRadius = 10
        eventDetailsView.layer.borderWidth = 1.0
        eventDetailsView.layer.borderColor = UIColor.black.cgColor
        eventDetailsView.layer.shadowColor = UIColor.black.cgColor
        eventDetailsView.layer.shadowOpacity = 0.3
        eventDetailsView.layer.shadowOffset = CGSize(width: 3, height: 3)
        eventDetailsView.layer.shadowRadius = 1.0
        
        legStatusView.layer.cornerRadius = 10
        legStatusView.layer.borderWidth = 1.0
        legStatusView.layer.borderColor = UIColor.black.cgColor
        legStatusView.layer.shadowColor = UIColor.black.cgColor
        legStatusView.layer.shadowOpacity = 0.3
        legStatusView.layer.shadowOffset = CGSize(width: 3, height: 3)
        legStatusView.layer.shadowRadius = 1.0//        contentView.layer.cornerRadius = 5
//        contentView.layer.masksToBounds = true
//        contentView.layer.borderColor = UIColor.black.cgColor
//        contentView.layer.allowsGroupOpacity = true
//        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(10, 10, 10, 10))
    }
    
    
    
}

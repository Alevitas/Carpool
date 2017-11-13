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
    @IBOutlet weak var eventTimeLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        eventDetailsView.layer.cornerRadius = 10
        eventDetailsView.layer.borderWidth = 0.5
        eventDetailsView.layer.borderColor = UIColor.black.cgColor
    
        
        legStatusView.layer.cornerRadius = 10
        legStatusView.layer.borderWidth = 0.5
        legStatusView.layer.borderColor = UIColor.black.cgColor
     
    }
    
    
    
}

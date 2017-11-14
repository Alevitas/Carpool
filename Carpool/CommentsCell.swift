//
//  CommentsCell.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/14/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import Foundation
import UIKit

class CommentsCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var commentsView: UIView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userInfoView.layer.cornerRadius = 10
        userInfoView.layer.borderWidth = 0.5
        userInfoView.layer.borderColor = UIColor.black.cgColor
        
        
        commentsView.layer.cornerRadius = 10
        commentsView.layer.borderWidth = 0.5
        commentsView.layer.borderColor = UIColor.black.cgColor
        
    }
    
    
    
}

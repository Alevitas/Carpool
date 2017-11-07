//
//  Extensions.swift
//  Carpool
//
//  Created by Gary on 11/7/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit

extension Date {
    var shortDayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
    var LongDayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    var hourDesc: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: self)
    }
    var prettyDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, YYYY h:mm a"
        return dateFormatter.string(from: self)
    }
    var prettyDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d"
        return dateFormatter.string(from: self)
    }
    var dayHour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, h a"
        return dateFormatter.string(from: self)
    }
}

extension UILabel {
    
    // extension user defined Method
    func setRoundEdge() {
        //Width of border
        self.layer.borderWidth = 1.0
        //How much the edge to be rounded
        self.layer.cornerRadius = 5.0
        
        // following properties are optional
        //color for text
        self.textColor = UIColor.blue
        // Mask the bound
        self.layer.masksToBounds = true
        //clip the pixel contents
        self.clipsToBounds = true
    }
}

extension UIButton {
    
    // extension user defined Method
    func setRoundEdge() {
        //Width of border
        self.layer.borderWidth = 1.0
        //How much the edge to be rounded
        self.layer.cornerRadius = 5.0
        
        // following properties are optional
        // Mask the bound
        self.layer.masksToBounds = true
        //clip the pixel contents
        self.clipsToBounds = true
    }
}

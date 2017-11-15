//
//  Extensions.swift
//  Carpool
//
//  Created by Gary on 11/7/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import MapKit
import CarpoolKit
import CoreLocation

enum DropOffPickUp: String {
    case dropOff
    case pickUp
}

enum LegsClaimed: String {
    case red
    case yellow
    case green
}



extension CLLocation: MKAnnotation {
    
}

extension Date {
    var shortDayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
    var longDayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    var hourDesc: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
    var prettyDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d YYYY, h:mm a"
        return dateFormatter.string(from: self)
    }
    var shortMonthDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: self)
    }
    var prettyDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter.string(from: self)
    }
    var dayHour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, h:mm a"
        return dateFormatter.string(from: self)
    }
}

extension Trip {
    var alertText: String {
        let msg = "\(self.event.description) on \(self.event.time.prettyDay) at \(self.event.time.hourDesc)"
        return msg
    }
    var dropOffLegClaimed: Bool {
        return self.dropOff != nil
    }
    var pickUpLegClaimed: Bool {
        return self.pickUp != nil
    }
    var myDropOffLeg: Bool {
        return self.dropOff?.driver == currentUser
    }
    var myPickUpLeg: Bool {
        return self.pickUp?.driver == currentUser
    }
    var hasLocation: Bool {
        return self.event.clLocation != nil
    }
}

extension Event {
    var myEvent: Bool {
        return self.owner == currentUser
    }
}

extension User {
    var stringOfChildNames: String {
        let foo = self.children.reduce("") { (result, child) -> String in
            result + ", " + child.name
        }
        return foo
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

extension MKMapItem: MKAnnotation { // Like Event in Carpool app
    public var coordinate: CLLocationCoordinate2D {
        return placemark.coordinate
    }
    public var title: String? {
        return name
    }
    public var subtitle: String? {
        return phoneNumber
    }
}


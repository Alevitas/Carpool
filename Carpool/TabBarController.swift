//
//  TabBarController.swift
//  Carpool
//
//  Created by Gary on 11/9/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import CarpoolKit

let carpoolLoginNotificationName = Notification.Name("carpoolLoginNotification")

class TabBarController: UITabBarController {
    
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: carpoolLoginNotificationName, object: nil, queue: .main) { _ in
            if let loginVC = self.presentedViewController as? LoginViewController {
                loginVC.dismiss(animated: true, completion: nil)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        API.fetchCurrentUser { (result) in
            switch result {
                
            case .success(let user):
                self.currentUser = user
            case .failure(_):
                let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginVC")
                self.present(loginVC, animated: animated)
            }
        }
        
    }
}


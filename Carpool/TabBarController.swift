//
//  TabBarController.swift
//  Carpool
//
//  Created by Gary on 11/9/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import FirebaseCommunity

let carpoolLoginNotificationName = Notification.Name("snapchapLoginNotification")

class TabBarController: UITabBarController {
    
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
        
        if Auth.auth().currentUser == nil {
            let loginVC = storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            present(loginVC, animated: animated)
        }
    }
}


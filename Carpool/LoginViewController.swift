//
//  LoginViewController.swift
//  Carpool
//
//  Created by Gary on 11/9/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginSignupButton: UIButton!
    @IBOutlet weak var loginSignupSegControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmPasswordTextField.isHidden = true
        loginSignupButton.setTitle("Login", for: .normal)
    }
    
    @IBAction func onLoginSignupPressed(_ sender: UISegmentedControl) {
        if loginSignupSegControl.selectedSegmentIndex == 0 {
            confirmPasswordTextField.isHidden = true
            loginSignupButton.setTitle("Login", for: .normal)
        } else {
            confirmPasswordTextField.isHidden = false
            loginSignupButton.setTitle("Signup", for: .normal)
        }
    }
    
    @IBAction func onLoginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            let alert = UIAlertController(title: "Error", message: "Email or Password can not be empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if loginSignupSegControl.selectedSegmentIndex == 0 {
            // login
        } else if let confirmPassword = confirmPasswordTextField.text, password == confirmPassword {
            // signup
        }
    }
}

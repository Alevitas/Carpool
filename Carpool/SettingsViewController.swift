//
//  SettingsViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/9/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import UIKit
import CarpoolKit
import MessageUI

class SettingsViewController: UIViewController, MFMessageComposeViewControllerDelegate{
    
    
    @IBOutlet weak var friendNumberOutlet: UITextField!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var childrenAddedLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addChildrenTextFieldOutlet: UITextField!
    
    var children: [Child] = []
    let messageController = MFMessageComposeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageController.messageComposeDelegate  = self
        usernameLabel.text = "\(String(describing: currentUser?.name ?? "Username"))"
        
        API.fetchCurrentUser { (result) in
            switch result {
                
            case .success(let user):
                currentUser = user
            case .failure(_):
                print("Error retreiving current user")
            }
        }
        
        if let user = currentUser {
            childrenAddedLabel.text = user.stringOfChildNames
        } else {
            print("error")
        }
        
        let ViewForDoneButtonOnKeyboard = UIToolbar()
        ViewForDoneButtonOnKeyboard.sizeToFit()
        let btnDoneOnKeyboard = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtnfromKeyboardClicked))
        ViewForDoneButtonOnKeyboard.items = [btnDoneOnKeyboard]
        friendNumberOutlet.inputAccessoryView = ViewForDoneButtonOnKeyboard
        addChildrenTextFieldOutlet.inputAccessoryView = ViewForDoneButtonOnKeyboard
        
        
    }
    
    @IBAction func doneBtnfromKeyboardClicked (sender: Any) {
        print("Done Button Clicked.")
        //Hide Keyboard by endEditing or Anything you want.
        self.view.endEditing(true)
    }
    
    @IBAction func addChildrenTextFieldEnter(_ sender: UITextField) {
        if let child = sender.text {
            API.addChild(name: child) { (result) in
                switch result {
                case .success(let child):
                    self.children.append(child)
                case .failure(_):
                    print("Error adding child.")
                }
            }
        }
    }
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        let loginVC = storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
        present(loginVC, animated: true)
    }
    
    @IBAction func inviteThroughTextButton(_ sender: UIButton) {
        guard let number = friendNumberOutlet.text else { return }
        if MFMessageComposeViewController.canSendText() == true {
            let recipients:[String] = ["1" + number]
            messageController.recipients = recipients
            messageController.body = "Come join me in the Carpool App"
            self.present(messageController, animated: true, completion: nil)
        } else {
            //handle text messaging not available
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch result {
            
        case .cancelled:
            print("Canceled message")
        case .sent:
            print("sent message")
        case .failed:
            print("failed to message")
        }
        
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}


//
//  FriendsViewController.swift
//  Carpool
//
//  Created by Akiva Levitas on 11/10/17.
//  Copyright © 2017 Akiva Levitas. All rights reserved.
//

import Foundation
import UIKit
import CarpoolKit
import MessageUI

class FriendsViewController: UITableViewController, MFMessageComposeViewControllerDelegate {
    
    
    var friends: [User] = []
    let messageController = MFMessageComposeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageController.messageComposeDelegate  = self
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backGroundimage2"))
        API.observeFriends(sender: self) { (result) in
            switch result {
                
            case .success(let downloadedFriends):
                self.friends = downloadedFriends
                self.tableView.reloadData()
            case .failure(let error):
                print("\nError getting Friends: ", error)
            }
        }
    }
    @IBAction func unwindFromAddnewVC(segue: UIStoryboardSegue) {
        tableView.reloadData()
        
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Friend", for: indexPath) as! FriendCell
        
        cell.friendNameLabel.text = friends[indexPath.row].name
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let saveAlert = UIAlertController(title: "Call or Text friend?", message: nil, preferredStyle: .actionSheet)
        saveAlert.addAction(UIAlertAction(title: "Make a call", style: .default, handler: PhoneCalling.call(friends[indexPath.row].phoneNumber)))
        saveAlert.addAction(UIAlertAction(title: "Send a text", style: .default, handler: onTextSelected(number: friends[indexPath.row].phoneNumber)))
        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(saveAlert, animated: true, completion: nil)
        
       
        
    }
    
    func onTextSelected(number: String?) {
        guard let number = number else { return }
        if MFMessageComposeViewController.canSendText() == true {
            let recipients:[String] = [number]
            messageController.recipients = recipients
            messageController.body = "Come join me in the Carpool App"
            self.present(messageController, animated: true, completion: nil)
        } else {
            //handle text messaging not available
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        API.remove(friend: friends[indexPath.row])
        friends.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addFriendsVC = segue.destination as! AddFriendsViewController
        addFriendsVC.currentFriends = friends
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



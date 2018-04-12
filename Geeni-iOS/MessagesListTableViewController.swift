//
//  MessagesListTableViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SWRevealViewController
import Firebase

class MessagesListTableViewController: UITableViewController {
    
    var chatrooms = [Chatroom]()
    var userArray = [User]()
    var selectedChatroom : Chatroom?
    var receiver : User?
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Messages")
        revealSideMenu(menuButton)
        getChatrooms()
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Messages"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    func getChatrooms() {
        ref.child("chatrooms").queryOrdered(byChild: "student").queryEqual(toValue: uid).observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let chatroom = Chatroom(dictionary: dictionary)
                self.chatrooms.append(chatroom)
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, withCancel: nil)
        
        ref.child("chatrooms").queryOrdered(byChild: "tutor").queryEqual(toValue: uid).observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let chatroom = Chatroom(dictionary: dictionary)
                self.chatrooms.append(chatroom)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, withCancel: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ChatroomViewController
        destination.chatroom = selectedChatroom
       
        if selectedChatroom?.student == uid {
            destination.receiverId = selectedChatroom?.tutor
        } else {
            destination.receiverId = selectedChatroom?.student
        }
        destination.receiverUsername = receiver?.username
        destination.sender = uid
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatrooms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatroomTableViewCell
        let chatroom = self.chatrooms[indexPath.row]
        let id = chatroom._id
        
        ref.child("sessions").child(id!).observe(.value, with: { (snapshot) in
            if let snapshotValue = snapshot.value as? [String: AnyObject] {
                let session = Session(dictionary: snapshotValue)
                cell.descriptionLabel.text = session.desc
                let timeStamp = session.timestamp! / 1000
                let time = Date(timeIntervalSince1970: timeStamp)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy h:mm a Z"
                let timeString = dateFormatter.string(from: time)
                cell.dateLabel.text = timeString
            }
        })
        
      
        
        if uid == chatroom.student {
            // getting tutor details
            FirebaseCalls().getUserDetails(idString: chatroom.tutor, completionHandler: { (user, bool) in
                if bool {
                    self.receiver = user
                    cell.user = user
                } else {
                    self.showAlert("Unexpected error occured!")
                }
            })
        } else {
            // getting student details
            FirebaseCalls().getUserDetails(idString: chatroom.student, completionHandler: { (user, bool) in
                if bool {
                    self.receiver = user
                    cell.user = user
                } else {
                    self.showAlert("Unexpected error occured!")
                }
            })
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedChatroom = chatrooms[indexPath.item]
        
        performSegue(withIdentifier: "chatroomSegue", sender: self)
    }
}



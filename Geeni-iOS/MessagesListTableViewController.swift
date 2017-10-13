//
//  MessagesListTableViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SWRevealViewController

class MessagesListTableViewController: UITableViewController {
    
    var chatrooms = [Chatroom]()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Messages")
        revealSideMenu(menuButton)
        getChatrooms()
        tableView.tableFooterView = UIView()
    }
    
    func getChatrooms() {
        ref.child("chatrooms").queryOrdered(byChild: "student").queryEqual(toValue: uid).observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let chatroom = Chatroom(dictionary: dictionary)
                self.chatrooms.append(chatroom)
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
        
        ref.child("chatrooms").queryOrdered(byChild: "tutor").queryEqual(toValue: uid).observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let chatroom = Chatroom(dictionary: dictionary)
                self.chatrooms.append(chatroom)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.chatrooms.count
//        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatroomTableViewCell
        cell.chatroom = self.chatrooms[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}



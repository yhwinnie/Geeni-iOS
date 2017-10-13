//
//  ScheduleTableViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SWRevealViewController
import Firebase

class ScheduleTableViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    var sessions = [Session]()
    let sessionRef = ref.child("sessions")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "Schedule")
        revealSideMenu(menuButton)
        getSessionIfTutor()
        getSessionIfStudent()
        tableView.tableFooterView = UIView()
    }
    
    
    // Query sessions by user
    func getSessionIfTutor() {
        guard let uid = uid else { return }
        sessionRef.queryOrdered(byChild: "tutor").queryEqual(toValue: uid).observe(.value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let session = Session(dictionary: dictionary)
                self.sessions.append(session)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
    }
    
    func getSessionIfStudent() {
        sessionRef.queryOrdered(byChild: "student").queryEqual(toValue: uid).observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let session = Session(dictionary: dictionary)
                self.sessions.append(session)
                
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
        return self.sessions.count
//        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SessionTableViewCell
        cell.session = self.sessions[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


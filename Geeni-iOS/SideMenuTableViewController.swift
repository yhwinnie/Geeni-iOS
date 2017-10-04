//
//  SideMenuTableViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 3/18/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SWRevealViewController
import Firebase
import FirebaseStorage
import Kingfisher

class SideMenuTableViewController: UITableViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    let sections: [String] = ["NEWS FEED", "NEW POST", "SCHEDULE", "MESSAGES", "WALLET", "PAYMENT OPTIONS", "BECOME A TUTOR", "LOGOUT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileImage()
        tableView.backgroundColor = UIColor.black
        tableView.separatorColor = UIColor.darkGray
        tableView.tableFooterView = UIView()
        getUserInfo()
    }
    
    func setupProfileImage(){
        profileImageView.makeRound()
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImageTapped)))
    }
    
    func profileImageTapped(){
        let profileViewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "Profile") as! UITableViewController
        self.present(profileViewController, animated: true, completion: nil)
    }
    
    func getUserInfo() {
        guard let uid = uid else { return }
        
        ref.child("users").child(uid).observe(.value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User(dictionary: dictionary)
                
                DispatchQueue.main.async(execute: {
                    self.majorLabel.text = user.major
                    self.nameLabel.text = user.username
                    storageRef = storage.reference(forURL: user.photo_gs!)
                    storageRef.downloadURL { (url, error) in
                        self.profileImageView.kf.setImage(with: url)
                    }
                    
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.sections[indexPath.row]
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 1:
            let newPost: UIViewController = UIStoryboard(name: "NewPost", bundle: nil).instantiateViewController(withIdentifier: "NewPost") as! UINavigationController
            self.revealViewController().setFront(newPost, animated: true)
            
        case 2:
            let schedule: UIViewController = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(withIdentifier: "Schedule") as! UINavigationController
            self.revealViewController().setFront(schedule, animated: true)
            
        case 3:
            let messages: UIViewController = UIStoryboard(name: "Messages", bundle: nil).instantiateViewController(withIdentifier: "Messages") as! UINavigationController
            self.revealViewController().setFront(messages, animated: true)
            
        case 4:
            let wallet: UIViewController = UIStoryboard(name: "Wallet", bundle: nil).instantiateViewController(withIdentifier: "Wallet") as! UINavigationController
            self.revealViewController().setFront(wallet, animated: true)
            
        case 5:
            let cards: UIViewController = UIStoryboard(name: "ListCard", bundle: nil).instantiateViewController(withIdentifier: "ListCard") as! UINavigationController
            self.revealViewController().setFront(cards, animated: true)
            
        case 6:
            let becomeTutor: UIViewController = UIStoryboard(name: "BecomeTutor", bundle: nil).instantiateViewController(withIdentifier: "BecomeTutor") as! UINavigationController
            self.revealViewController().setFront(becomeTutor, animated: true)
            
        case 7:
            let firebaseAuth = FIRAuth.auth()
            do {
                try firebaseAuth?.signOut()
                let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
                appDelegate.window?.rootViewController = initialViewController
                appDelegate.window?.makeKeyAndVisible()
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
        default: break
            
        }
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        let settingsController = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "Settings") as! UINavigationController
        self.present(settingsController, animated: true, completion: nil)
    }
}

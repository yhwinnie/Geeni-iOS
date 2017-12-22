//
//  ProfileTableViewController.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 01/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import Firebase

class ProfileTableViewController: UITableViewController {
    
    var post: Post?
    
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    
    var schedule : Bool = true
    var userRating : Double = 0.0
    var userDetails : Bool = true
    var id : String = ""
    var postUser : User?
    var userPosts : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.makeRound()
        userImageView.setBorder(color : UIColor.white.cgColor , width : 2)
        
        userImageView.image = UIImage(named:"user_gray")
        backgroundImageView.image = UIImage(named: "user_gray")
            
        tableView.allowsSelection = false
        getProfileDetails()
        tableView.tableFooterView = UIView()
        if schedule {
            self.setupNavigationBar(title: "Schedule")
            revealSideMenu(menuButton)
            hideBackButton(true)
            if !userDetails {
                hideBackButton(false)
            }
        } else {
            hideBackButton(false)
        }
    }
    
    func getUserPosts() {
        guard let uid = uid else { return }
        UserDetails.userPosts = []
        FIRDatabase.database().reference().child("posts").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let post = Post(dictionary: dictionary)
                if post.user_id == uid {
                    UserDetails.userPosts.append(post)
                }
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
    }
    
    func getPosts() {
        FIRDatabase.database().reference().child("posts").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let post = Post(dictionary: dictionary)
                if post.user_id == self.id {
                    self.userPosts.append(post)
                }
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
    }
    
    func hideMessageButton(_ bool : Bool){
        messageButton.isHidden = bool
        messageButton.isUserInteractionEnabled = !bool
    }
    
    func hideBackButton(_ bool : Bool){
        backButton.isHidden = bool
        backButton.isUserInteractionEnabled = !bool
    }
    
    func getProfileDetails() {
        if userDetails {
            guard let uid = uid else { return }
            if UserDetails.user == nil {
                FirebaseCalls().getUserDetails(idString: uid) { (user , bool) in
                    if bool {
                        UserDetails.user = user
                        self.getUserPosts()
                        self.setupProfile()
                        
                    } else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Geeni", message: "Unexpected error occurred!", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                self.dismiss(animated: true, completion: nil)
                            })
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            } else {
                setupProfile()
            }
        } else {
            FirebaseCalls().getUserDetails(idString: id) { (user , bool) in
                if bool {
                    self.postUser = user
                    self.getPosts()
                    self.setupPostUserProfile()
                    
                } else {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Geeni", message: "Unexpected error occurred!", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            self.dismiss(animated: true, completion: nil)
                        })
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func setupProfile(){
        if UserDetails.user?._id == uid {
            self.hideMessageButton(true)
        } else {
            self.hideMessageButton(false)
        }
        self.majorLabel.text = UserDetails.user?.major
        self.userNameLabel.text = UserDetails.user?.username
        let imageURL = URL(string: (UserDetails.user?.photo_gs!)!)
        if UserDetails.user?.photo_gs?.first == "g"{
            storageRef = storage.reference(forURL: (UserDetails.user?.photo_gs!)!)
            storageRef.downloadURL { (url, error) in
                self.userImageView.kf.setImage(with: url)
                self.backgroundImageView.kf.setImage(with: url)
            }
        } else {
            self.userImageView.kf.setImage(with: imageURL)
            self.backgroundImageView.kf.setImage(with: imageURL)
        }
        self.userRating = (UserDetails.user?.overall_ratings_student)!
    }
    
    func setupPostUserProfile(){
        if UserDetails.user?._id == uid {
            self.hideMessageButton(true)
        } else {
            self.hideMessageButton(false)
        }
        self.majorLabel.text = postUser?.major
        self.userNameLabel.text = postUser?.username
        let imageURL = URL(string: (postUser?.photo_gs!)!)
        if postUser?.photo_gs?.first == "g"{
            storageRef = storage.reference(forURL: (postUser?.photo_gs!)!)
            storageRef.downloadURL { (url, error) in
                self.userImageView.kf.setImage(with: url)
                self.backgroundImageView.kf.setImage(with: url)
            }
        } else {
            self.userImageView.kf.setImage(with: imageURL)
            self.backgroundImageView.kf.setImage(with: imageURL)
        }
        self.userRating = (postUser?.overall_ratings_student)!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if userDetails {
            return UserDetails.userPosts.count
            } else {
                return userPosts.count
            }
        } else {
            return 1
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80.0
        } else if indexPath.section == 1{
            return 50.0
        } else {
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Seeking Tutor"
        case 1:
            return "Reviews"
        case 2:
            return "Stats"
        default:
            return "Header"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "profilePost") as! ProfilePostTableViewCell
            let currentPost : Post?
            if userDetails {
                currentPost = UserDetails.userPosts[indexPath.item]
            } else {
                currentPost = userPosts[indexPath.item]
            }
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "MM/dd/yy h:mm a Z"
            
            // setting value for user's posts in profile 
            cell.classNameLabel.text = currentPost?.subject
            cell.locationLabel.text = currentPost?.location
            let now = dateformatter.string(from: Date(timeIntervalSince1970: (currentPost?.start_time!)!/1000))
            cell.dateLabel.text = now
            return cell
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileReview") as! ProfileReviewTableViewCell
            cell.ratingView.isUserInteractionEnabled = false
            cell.ratingView.rating = self.userRating
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell")
            cell?.textLabel?.text = "TBD"
            return cell!
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "", size: 18)
        header.textLabel?.textColor = colors.tableHeaderColor
    }
}





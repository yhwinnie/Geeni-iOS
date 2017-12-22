//
//  NewsFeedViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SWRevealViewController
import Firebase

class NewsFeedViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentView: UIView!
    
    var posts = [Post]()
    let ref = FIRDatabase.database().reference()
    var selectedPost : Post? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        getPublicNewsFeed()
        revealSideMenu(menuButton)
        self.setupNavigationBar(title: "News Feed")
        setupSegmentController()
        guard let uid = uid else { return }
        
        //getting user details on first launch
        if UserDetails.user == nil {
            FirebaseCalls().getUserDetails(idString : uid, completionHandler: { (user, bool) in
                if bool {
                    UserDetails.user = user
                    self.getUserPosts()
                }
            })
        } else {
            getUserPosts()
        }
    }
    
    func setupSegmentController() {
        segmentedControl.backgroundColor = colors.blueColor
        segmentedControl.tintColor = colors.whiteColor
        segmentView.backgroundColor = colors.blueColor
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        posts = []
        self.tableView.reloadData()
        if segmentedControl.selectedSegmentIndex == 0 {
            getPublicNewsFeed()
        } else {
            getPrivateNewsFeed()
        }
    }
    
    func getPublicNewsFeed() {
        guard let uid = uid else {return}
        FIRDatabase.database().reference().child("posts").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let post = Post(dictionary: dictionary)
                if post.user_id != uid {
                    self.posts.append(post)
                }
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
            
        }, withCancel: nil)
    }
    
    func getPrivateNewsFeed() {
        
        guard let uid = uid else { return }
        FIRDatabase.database().reference().child("posts").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let post = Post(dictionary: dictionary)
                if post.user_id == uid {
                    self.posts.append(post)
                }
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! EachPostViewController
        destination.currentPost = self.selectedPost
        if segmentedControl.selectedSegmentIndex == 0 {
            if UserDetails.user?.tutor_bool == true {
                destination.addTutor = true
            } else {
                destination.addTutor = false
            }
        } else {
            destination.addTutor = false
        }
    }
}

extension NewsFeedViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        cell.post = self.posts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension NewsFeedViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPost = self.posts[indexPath.item]
        self.performSegue(withIdentifier: "postSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


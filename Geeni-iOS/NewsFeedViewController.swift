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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        getPublicNewsFeed()
        revealSideMenu(menuButton)
        self.setupNavigationBar(title: "News Feed")
        setupSegmentController()
    }
    
    func setupSegmentController() {
        segmentedControl.backgroundColor = colors.blueColor
        segmentedControl.tintColor = colors.whiteColor
        segmentView.backgroundColor = colors.blueColor
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        posts = []
        if segmentedControl.selectedSegmentIndex == 0 {
            getPublicNewsFeed()
        } else {
            getPrivateNewsFeed()
        }
    }
    
   
    
    func getPublicNewsFeed() {
        FIRDatabase.database().reference().child("posts").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let post = Post(dictionary: dictionary)
                self.posts.append(post)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
            
        }, withCancel: nil)
    }
    
    func getPrivateNewsFeed() {
        
        guard let uid = uid else { return }
        
        FIRDatabase.database().reference().child("posts").queryOrdered(byChild: "private_sort_tag").queryStarting(atValue: "\(uid) 0").queryEnding(atValue: "\(uid) 99999999").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let post = Post(dictionary: dictionary)
                self.posts.append(post)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
            
        }, withCancel: nil)
    }
}

extension NewsFeedViewController : UITableViewDataSource {
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.posts.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        //cell.textLabel?.text = "Public"
        cell.post = self.posts[indexPath.row]
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension NewsFeedViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "postSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


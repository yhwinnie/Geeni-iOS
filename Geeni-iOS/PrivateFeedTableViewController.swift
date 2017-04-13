//
//  PrivateFeedTableViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import Firebase

class PrivateFeedTableViewController: UITableViewController {
    

    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPrivateNewsFeed()
    }
    
    
    // Query by the user and time
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.posts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PrivateTableViewCell

        cell.post = self.posts[indexPath.row]
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "PostDetail", bundle: nil)
        let eachPostViewController = storyboard.instantiateViewController(withIdentifier: "eachPost") as! EachPostViewController
        eachPostViewController.post = self.posts[indexPath.row]
        
        
        self.present(eachPostViewController, animated: true)
    }
}

class PrivateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var userPicture: CustomRoundImageView!
    
    var post: Post? {
        
        didSet {
            guard let post = post else { return }
            
            shortDescriptionLabel.text = post.desc
            
            // Set Images
            
            if let imageURL = post.user_photo_gs {
                
                storageRef = storage.reference(forURL: imageURL)
                
                
                storageRef.downloadURL { (url, error) in
                    self.userPicture.kf.setImage(with: url)
                }
                
            }
            
            let dateformatter = DateFormatter()
            
            dateformatter.dateFormat = "MM/dd/yy h:mm a Z"
            
            let now = dateformatter.string(from: Date(timeIntervalSince1970: post.start_time!/1000))
            
            dateLabel.text = now
            
            courseNameLabel.text = post.subject
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

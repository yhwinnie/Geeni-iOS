//
//  EachPostViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/11/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit

class EachPostViewController: UIViewController {
    
    var post: Post?
    
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }



}

extension EachPostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PostTableViewCell
        
        cell.post = self.post
        
        return cell 
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

class PostTableViewCell: UITableViewCell {
    
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
                
                let url = URL(fileURLWithPath: imageURL)
                // userPicture.kf.setImage(with: storageRef.child(imageURL))
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


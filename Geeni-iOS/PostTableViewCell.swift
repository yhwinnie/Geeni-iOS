//
//  PostTableViewCell.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 29/09/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import Foundation

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
    
    var post: Post? {
        
        didSet {
            guard let post = post else { return }
            
            shortDescriptionLabel.text = post.desc
            
            // Set Images
            if let imageURL = post.user_photo_gs {
                //getting image from firebase storage
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        userPicture.makeRound()
    }
    
}

//
//  ChatroomTableViewCell.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 11/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import Kingfisher

class ChatroomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var user : User? {
        didSet {
            userName.text = user?.username
            majorLabel.text = user?.major
            //getting image from firebase
            if let imageUrl = user?.photo_gs {
                if user?.photo_gs?.first == "g"{
                    storageRef = storage.reference(forURL: imageUrl)
                    storageRef.downloadURL { (url, error) in
                        self.userImageView?.kf.setImage(with: url)
                    }
                } else {
                    self.userImageView?.kf.setImage(with: (URL (string : imageUrl)))
                }
            }
        }
    }
    
    var post : Post? {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        userImageView.image = UIImage(named : "user_gray")
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.width/2
    }
}

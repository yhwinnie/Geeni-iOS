//
//  SessionTableViewCell.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 11/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import Foundation

// Session TableViewCell
class SessionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
    
    var session: Session? {
        
        didSet {
            guard let session = session else { return }
            shortDescriptionLabel.text = session.desc
            
            // Set Images
            //
            //            if let imageURL = session.user_photo_gs {
            //
            ////                let url = URL(fileURLWithPath: imageURL)
            //                // userPicture.kf.setImage(with: storageRef.child(imageURL))
            //            }
            
            let dateformatter = DateFormatter()
            
            dateformatter.dateFormat = "MM/dd/yy h:mm a Z"
            
            let now = dateformatter.string(from: Date(timeIntervalSince1970: session.start_time!/1000))
            
            dateLabel.text = now
            
            courseNameLabel.text = session.subject
            
        }
    }
}




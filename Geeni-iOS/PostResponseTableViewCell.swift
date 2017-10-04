//
//  PostResponseTableViewCell.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 03/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class PostResponseTableViewCell : UITableViewCell{
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var userLabel : UILabel!
    @IBOutlet weak var subjectLabel : UILabel!
    @IBOutlet weak var ratingView : CosmosView!
    
    override func awakeFromNib() {
        userImage.makeRound()
        userImage.contentMode = .scaleAspectFill
    }
}

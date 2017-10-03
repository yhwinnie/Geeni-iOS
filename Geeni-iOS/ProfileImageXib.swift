//
//  ProfileImageXib.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 02/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit

class ProfileImageXib: UIView {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    override func awakeFromNib() {
        userImage.makeRound()
        userImage.setBorder(color: colors.whiteColor.cgColor, width: 2)
    }
}

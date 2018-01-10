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
    @IBOutlet weak var userNameLabel : UILabel!
    @IBOutlet weak var subjectNameLabel : UILabel!
    @IBOutlet weak var majorLabel : UILabel!
    
    override func awakeFromNib() {
        userImage.image = UIImage(named : "user_gray")
        backgroundImage.image = UIImage(named : "user_gray")
        userNameLabel.text = ""
        subjectNameLabel.text = ""
        majorLabel.text = ""
        userImage.makeRound()
        userImage.setBorder(color: colors.whiteColor.cgColor, width: 2)
        userImage.contentMode = .scaleToFill
        backgroundImage.contentMode = .scaleToFill
    }
    
    func hideMessageButton(_ bool : Bool){
        messageButton.isHidden = bool
        messageButton.isUserInteractionEnabled = !bool
    }
    
    func hideBackButton(_ bool : Bool){
        backButton.isHidden = bool
        backButton.isUserInteractionEnabled = !bool
    }
}

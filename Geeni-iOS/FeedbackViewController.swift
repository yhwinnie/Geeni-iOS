//
//  FeedbackViewController.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 02/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import Cosmos

class FeedbackViewController: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var submitButton: UIButton!
    
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileView()
        setupRatingView()
        setupSubmitButton()
    }
    
    
    func setupProfileView() {
        let profileImageView = Bundle.main.loadNibNamed("ProfileImageXib", owner: self, options: nil)![0] as? ProfileImageXib
        profileImageView?.frame = CGRect(x: 0, y: -statusBarHeight, width: self.view.frame.width, height: 250)
        profileImageView?.center.x = self.view.center.x
        self.view.addSubview(profileImageView!)
        profileImageView?.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    func setupRatingView(){
        ratingView.rating = 5
    }
    
    func setupSubmitButton(){
        submitButton.setTitleColor(colors.whiteColor, for: .normal)
        submitButton.setTitle("Submit Feedback", for: .normal)
        submitButton.backgroundColor = colors.blueColor
    }
    
    func backButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

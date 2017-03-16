//
//  LoginViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 3/16/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        // Set background image for login screen
        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = UIImage(named: "login")
        self.view.addSubview(backgroundImage)
        
        // Set logo
        let logoImage = UIImageView(frame: CGRect(x: (backgroundImage.frame.width/2) - 50, y: 100, width: 100, height: 90))
        logoImage.image = UIImage(named: "logo")
        backgroundImage.addSubview(logoImage)
        
        // Set the view for google button
        let googleButton = UIView(frame: CGRect(x: 40, y: backgroundImage.frame.height - 150, width: backgroundImage.frame.width - 80, height: 50))
        googleButton.backgroundColor = UIColor.white
        backgroundImage.addSubview(googleButton)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

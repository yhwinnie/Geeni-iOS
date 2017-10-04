//
//  BecomeTutorPartTwoViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 3/18/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SWRevealViewController

class BecomeTutorPartTwoViewController: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Become a Tutor")
        setupSubmitButton()
    }
    
    func setupSubmitButton(){
        submitButton.createSubmitButton()
        submitButton.center.x = self.view.center.x
        submitButton.frame.origin.y = self.view.frame.height - 100 - (self.navigationController?.navigationBar.frame.height)!
    }
}



//
//  PostViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 3/16/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SWRevealViewController


class PostViewController: UIViewController {
    @IBOutlet weak var menuButton: CustomMenuBarButton!
    
    @IBOutlet weak var courseTextField: CustomTextField!

    @IBOutlet weak var locationTextField: CustomTextField!

    @IBOutlet weak var dateTextField: CustomTextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        revealSideMenu()
        
    }
    
    func revealSideMenu() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    
    
    
    @IBAction func submitPostAction(_ sender: Any) {
    }
    
    
    
    @IBAction func addPictureAction(_ sender: Any) {
    }

}


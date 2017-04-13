//
//  NewsFeedViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SWRevealViewController
import Firebase

class NewsFeedViewController: UIViewController {
    



    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var privateContainerView: UIView!
    @IBOutlet weak var publicContainerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        publicContainerView.alpha = 1
        privateContainerView.alpha = 0
        
        revealSideMenu()

    }


    func revealSideMenu() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        
        switch (sender.selectedSegmentIndex) {
        case 0: publicContainerView.alpha = 1
            privateContainerView.alpha = 0
        case 1:
            publicContainerView.alpha = 0
            privateContainerView.alpha = 1
        default:
            publicContainerView.alpha = 1
            privateContainerView.alpha = 0
        }
        
    }


}

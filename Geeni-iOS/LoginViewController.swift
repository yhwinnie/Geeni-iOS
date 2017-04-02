//
//  LoginViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 3/16/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the Google sign in UI
        GIDSignIn.sharedInstance().uiDelegate = self
        
        
        // Use to call the sign in view from Google 
//        GIDSignIn.sharedInstance().signIn()
    }
    


    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

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

class LoginViewController: UIViewController, GIDSignInUIDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
}

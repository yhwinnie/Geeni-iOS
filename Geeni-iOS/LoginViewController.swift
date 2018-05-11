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
import SWRevealViewController

class LoginViewController: UIViewController, GIDSignInUIDelegate{
    
    @IBOutlet weak var activityView : UIActivityIndicatorView!
    var firstLogin : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        setupActivityView()
        firebaseAutoLogin()
    }
    
    func firebaseAutoLogin(){
        activityView.isHidden = false
        activityView.startAnimating()
        //check if the user has logged in
        if Auth.auth().currentUser != nil {
            let ref = Database.database().reference()
            ref.child("users").observe(DataEventType.value, with: {
                (snapshot) in
                for u in snapshot.children {
                    let fireDict = (u as! DataSnapshot).value as? [String: AnyObject] ?? [:]
                    if Auth.auth().currentUser?.uid == fireDict["_id"] as! String? {
                        self.firstLogin = false
                        self.activityView.stopAnimating()
                        self.activityView.isHidden = true
                        break;
                    }
                }
                uid = Auth.auth().currentUser?.uid
                DispatchQueue.main.async {
                    if self.firstLogin {
                        self.presentSignUpView()
                    } else {
                        self.presentMainView()
                    }
                }
            })
        } else {
            activityView.stopAnimating()
            activityView.isHidden = true
        }
    }
    
    func setupActivityView() {
        activityView.activityIndicatorViewStyle = .whiteLarge
        activityView.center  = self.view.center
        activityView.isHidden = true
    }
    
    func presentMainView() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard: UIStoryboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainPage") as! SWRevealViewController
        delegate.window?.rootViewController = initialViewController
        delegate.window?.makeKeyAndVisible()
    }
    
    func presentSignUpView(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "SignUp") as! UINavigationController
        delegate.window?.rootViewController = initialViewController
        delegate.window?.makeKeyAndVisible()
    }
}

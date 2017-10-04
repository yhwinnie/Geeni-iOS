//
//  AppDelegate.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 3/16/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import KeychainAccess
import SWRevealViewController


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    let keychain = Keychain(service: "com.wiwen.Geeni-iOS")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        // Check if user is already logged in
        do {
            // Getting access token if user is already loggen in.
            let token = try keychain.get("token")
            if let token = token {
                print(token)
                
                // Check if user is already under "users" on firebase, if yes present Main View. If no, go to sign up page which is still in progress
                let ref = FIRDatabase.database().reference()
                ref.child("users").observe(FIRDataEventType.value, with: {
                    (snapshot) in
                    for u in snapshot.children {
                        let fireDict = (u as! FIRDataSnapshot).value as? [String: AnyObject] ?? [:]
                        if FIRAuth.auth()?.currentUser?.uid == fireDict["_id"] as! String? {
                            // Move to Main Page
                            self.presentMainView()
                        }
                    }
                })
            }
            
        } catch {
            // Handle read failure
            if FIRAuthErrorCode(rawValue: error._code) != nil {
                print("User Error: \(error)")
            }
        }
        
        
        //status bar color
        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }
    
    func presentMainView() {
        let storyboard: UIStoryboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainPage") as! SWRevealViewController
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if error != nil {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        // ...
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            // ...
            if error != nil {
                // ...
                return
            }
            else {
            
                do {
                    // Store authentication to keychain
                    // Also store the firebase id as well.
                    try self.keychain.set(authentication.accessToken, key: "token")
                    
                    // Check if it is the first time user logs in, if yes, do not presentMainView
                    let ref = FIRDatabase.database().reference()
                    ref.child("users").observe(FIRDataEventType.value, with: {
                        (snapshot) in
                        var firstTime = true
                        for u in snapshot.children {
                            let fireDict = (u as! FIRDataSnapshot).value as? [String: AnyObject] ?? [:]
                            if FIRAuth.auth()?.currentUser?.uid == fireDict["_id"] as! String? {
                                firstTime = false
                                break;
                            }
                        }
                        // If success, move to main view
                        if (!firstTime) {
                            self.presentMainView()
                        } else {
                            
                            // Store new user
                            let userDict: [String : AnyObject] = ["_id": FIRAuth.auth()?.currentUser?.uid as AnyObject,
                                                                  "balance_available": 0 as AnyObject,
                                                                  "balance_pending": 0 as AnyObject,
                                                                  "email": user?.email as AnyObject,
                                                                  "limit": 0 as AnyObject,
                                                                  "major": "Computer Science" as AnyObject,
                                                                  "nor_student": 0 as AnyObject,
                                                                  "overall_ratings_student": 0 as AnyObject,
                                                                  "overall_ratings_tutor": 0 as AnyObject,
                                                                  "photo_gs": user?.photoURL?.absoluteString as AnyObject,
                                                                  "tutor_bool": false as AnyObject,
                                                                  "username": user?.displayName as AnyObject,
                                                                  "year": "2017" as AnyObject]
                            ref.child("users").childByAutoId().setValue(userDict)
                        }
                    })
                } catch let error {
                    print("error: \(error)")
                }
            }
        }
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}


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
                
                
                
                // TODO: Check if user is already under "users" on firebase, if yes present Main View. If no, go to sign up page which is still in progress
                
                
                // Move to Main Page
                presentMainView()
                
                
            }
            
        } catch {
            // TODO: Handle read failure
            
        }
        
        
        
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
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        
        
        
        
        
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        // ...
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            // ...
            if let error = error {
                // ...
                return
            }
            else {
                
        
            
                do {
                    // Store authentication to keychain
                    // TODO: Also store the firebase id as well.
                    try self.keychain.set(authentication.accessToken, key: "token")
                    
                    // TODO: Check if it is the first time user logs in, if yes, do not presentMainView 

                    
                    
                    // If success, move to main view
                    self.presentMainView()
                    
                    
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


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
import SWRevealViewController
import Stripe
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, UNUserNotificationCenterDelegate {
    
    let gregorian = Calendar(identifier: .gregorian)

    var window: UIWindow?
    //    let keychain = Keychain(service: "com.wiwen.Geeni-iOS")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //stripe key
        Stripe.setDefaultPublishableKey("pk_live_Hj9VUB3kQrZFczITJkfOeNqW")
        
        
        //firebase configuration
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        //status bar color
        UIApplication.shared.statusBarStyle = .lightContent
        
        //userNotification Authorisation
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (accepted, error) in
            if !accepted {
                print("Notification Denied")
            }
            else {
                UNUserNotificationCenter.current().delegate = self
            }
        }
        
        
        
        return true
    }
    
    func scheduleNotifications(_ currentSession : Session) {
        
        let timeStamp = currentSession.start_time! / 1000
        let date = Date(timeIntervalSince1970: timeStamp)
        let previousDate = gregorian.date(byAdding: .minute, value: -15, to: date)
        var dayComponents = Calendar.current.dateComponents([.month,.day,.year], from: previousDate!)
        let timeComponents = Calendar.current.dateComponents([.hour , .minute], from: previousDate!)
        
        dayComponents.second = 0
        dayComponents.minute = timeComponents.minute
        dayComponents.hour = timeComponents.hour
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dayComponents, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Session Alert"
        content.sound = UNNotificationSound.default()
        
        if UserDetails.user?.tutor_bool == false {
            let tutorId = currentSession.tutor_name
            content.subtitle = "Your session with " + tutorId! + " will begin in 15 minutes"
        } else {
            let userId = currentSession.username
            content.subtitle = "Your session with " + userId! + " will begin in 15 minutes"
        }
        
        let notif_identifier = currentSession._id
        
        let request = UNNotificationRequest(identifier: notif_identifier!, content: content, trigger: trigger)
        
        //schedule new notifications
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("Error occured during notification")
            } else {
                print("Notification created")
            }
        }
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
        if error != nil {
            print("\(String(describing: error?.localizedDescription))")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("\(String(describing: error?.localizedDescription))")
                return
            }
            else {
                // Check if it is the first time user logs in, if yes, do not presentMainView
                let ref = Database.database().reference()
                ref.child("users").observe(DataEventType.value, with: {
                    (snapshot) in
                    var firstTime = true
                    for u in snapshot.children {
                        let fireDict = (u as! DataSnapshot).value as? [String: AnyObject] ?? [:]
                        if Auth.auth().currentUser?.uid == fireDict["_id"] as! String? {
                            firstTime = false
                            break;
                        }
                    }
                    uid = user?.uid
                    UserDetails.user?._id = uid
                    
                    if (!firstTime) {
                        self.presentMainView()
                    } else {
                        self.presentSignUpView()
                    }
                })
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func presentMainView() {
        let storyboard: UIStoryboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainPage") as! SWRevealViewController
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    func presentSignUpView(){
        let storyboard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "SignUp") as! UINavigationController
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    
}

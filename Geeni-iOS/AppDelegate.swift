//
//  AppDelegate.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 3/16/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
        
        // Can change for later purposes
//        let controller = NewsFeedViewController()
//        let navigationController = UINavigationController(rootViewController: controller)
//        window?.rootViewController = navigationController
//        
//        let newsFeedViewController = PostViewController()
//        let navigationController = UINavigationController(rootViewController: newsFeedViewController)
//        
//        newsFeedViewController.addLeftBarButtonWithImage(UIImage(named: "add-photo")!)
//
//
//        let leftViewController = SideMenuTableViewController()
    
        
//        let slideMenuController = SlideMenuController(mainViewController: navigationController, leftMenuViewController: leftViewController, rightMenuViewController: leftViewController)
//        self.window?.rootViewController = slideMenuController
//        self.window?.makeKeyAndVisible()
//        
//        SlideMenuOptions.leftViewWidth = 50
//        SlideMenuOptions.contentViewScale = 0.50
        
        // Calling postViewController
//        let postViewController = PostViewController()
//        let navigationController = UINavigationController(rootViewController: postViewController)
//        window?.rootViewController = navigationController
//
//        UINavigationBar.appearance().tintColor = UIColor.white
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        // Calling the loginViewController
//        let loginViewController = LoginViewController()
//        //let navigationController = UINavigationController(rootViewController: loginViewController)
//        window?.rootViewController = loginViewController
        
        
        // create viewController code...
        
//        let mainViewController = PostViewController()
//        let leftViewController = SideMenuTableViewController()
//        let rightViewController = SideMenuTableViewController()
//        
//        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
//        
//        UINavigationBar.appearance().tintColor = UIColor.black
//        
//        leftViewController.mainViewController = nvc
//        
//        
//        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
//        slideMenuController.automaticallyAdjustsScrollViewInsets = true
//        slideMenuController.delegate = mainViewController
//        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
//        self.window?.rootViewController = slideMenuController
//        self.window?.makeKeyAndVisible()
        
        return true
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


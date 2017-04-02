//
//  SideMenuTableViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 3/18/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
class SideMenuTableViewController: UITableViewController {
    
    let sections: [String] = ["NAME", "NEWS FEED", "NEW POST", "SCHEDULE", "MESSAGES", "WALLET", "PAYMENT OPTIONS", "BECOME A TUTOR", "LOGOUT"]

    var mainViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.black
        tableView.separatorColor = UIColor.darkGray
        
        mainViewController = PostViewController()
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = self.sections[indexPath.row]
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.row {
//        case 0:
//            let newsFeedController = NewsFeedViewController()
//            let navigationController = UINavigationController(rootViewController: newsFeedController)
//            
//            present(navigationController, animated: true, completion: nil)
//            
//        default: let postViewController = PresentedViewController()
//        
//        let navigationController = UINavigationController(rootViewController: postViewController)
//       
//        present(navigationController, animated: true, completion: nil)
//            
//
//        }
    }
 
}

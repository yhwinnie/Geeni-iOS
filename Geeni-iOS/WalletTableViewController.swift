//
//  WalletTableViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SWRevealViewController
import Firebase
import FirebaseDatabase

class WalletTableViewController: UITableViewController {
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var receipts = [Receipt]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        revealSideMenu(menuButton)
        getReceipts()
        getWalletInfo()
        setupNavigationBar(title: "Wallet")
        tableView.tableFooterView = UIView()
        
    }
    
    func getWalletInfo() {
        guard let uid = uid else { return }
        ref.child("users").child(uid).observe(.value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User(dictionary: dictionary)
                
                DispatchQueue.main.async(execute: {
                    self.balanceLabel.text = "You have $" + String(describing: user.balance_available!/100) + " in your Geeni Wallet"
                    self.userNameLabel.text = user.username
                    
                    if let imageURL = user.photo_gs {
                        
                        if imageURL.first == "g"{
                            storageRef = storage.reference(forURL: imageURL)
                            storageRef.downloadURL { (url, error) in
                                self.userImageView.kf.setImage(with: url)
                            }
                        } else {
                            self.userImageView.kf.setImage(with: URL(string : imageURL))
                        }
                    }
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
    }
    
    func getReceipts() {
        
        guard let uid = uid else { return }
        ref.child("receipts").observe(.value, with: { (snapshot) in
            let receiptArray = snapshot.children.allObjects as NSArray
            for receipt in receiptArray {
                let receiptSnapshot = receipt as! DataSnapshot
                if let receiptValue = receiptSnapshot.value as? [String : Any] {
                    let toValue = receiptValue["to"] as! String
                    
                    //if tutor

                    if toValue == uid {
                        let receiptObject = Receipt(dictionary: receiptValue)
                        self.receipts.append(receiptObject)
                    }
                    
                    //if student
                    let forValue = receiptValue["from"] as! String
                    if forValue == uid {
                        let receiptObject = Receipt(dictionary: receiptValue)
                        self.receipts.append(receiptObject)
                    }
                }
                
            }
            self.tableView.reloadData()

            
        })
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return self.receipts.count
        return receipts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WalletTableViewCell
        cell.receipt = self.receipts[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

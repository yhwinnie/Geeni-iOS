//
//  WalletTableViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SWRevealViewController

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
                    self.balanceLabel.text = String(describing: user.balance_available!)
                    self.userNameLabel.text = user.username
                    
                    if let imageURL = user.photo_gs {
                        
                        storageRef = storage.reference(forURL: imageURL)
                        
                        
                        storageRef.downloadURL { (url, error) in
                            self.userImageView.kf.setImage(with: url)
                        }
                    }
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
    }
    
    func getReceipts() {
        
        guard let uid = uid else { return }
        ref.child("receipts").queryOrdered(byChild: "from").queryEqual(toValue: uid).observe(.value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let receipt = Receipt(dictionary: dictionary)
                self.receipts.append(receipt)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
        
        ref.child("receipts").queryOrdered(byChild: "to").queryEqual(toValue: uid).observe(.value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let receipt = Receipt(dictionary: dictionary)
                self.receipts.append(receipt)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return self.receipts.count
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WalletTableViewCell
//        cell.receipt = self.receipts[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

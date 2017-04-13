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
    @IBOutlet weak var userImageView: CustomRoundImageView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var receipts = [Receipt]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        revealSideMenu()
        getReceipts()
        getWalletInfo()
        
    }
    
    func revealSideMenu() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
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
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.receipts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WalletTableViewCell
        
        cell.receipt = self.receipts[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}



// Wallet TableViewCell
class WalletTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var receiptLabel: UILabel!
    @IBOutlet weak var userImageView: CustomRoundImageView!
    var receipt: Receipt? {
        
        didSet {
            
            guard let uid = uid else { return }
            
            guard let receipt = receipt else { return }
            
            if receipt.to == uid {
                receiptLabel.text = "\(receipt.from) paid You \(receipt.amount)"
                
            }
                
            else {
                receiptLabel.text = "You paid \(receipt.to) \(receipt.amount)"
            }
            
            timestamp.text = String(describing: receipt.timestamp)
            
            // Set Images
            
            if let imageURL = receipt.from_photo_gs {
                
                storageRef = storage.reference(forURL: imageURL)
                
                
                storageRef.downloadURL { (url, error) in
                    self.userImageView.kf.setImage(with: url)
                }
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}



// Receipt Model
class Receipt: NSObject {
    var _id: String?
    var amount: Double?
    var cancelled: Bool?
    var cut: Double?
    
    var from: String?
    var from_photo_gs: String?
    var from_username: String?
    
    var message: String?
    
    var payout: Double?
    var processed: Bool?
    
    var timestamp: Double?
    
    
    var to: String?
    var to_photo_gs: String?
    var to_username: String?
    
    
    init(dictionary: [String: Any]) {
        self._id = dictionary["_id"] as? String ?? ""
        
        self.amount = dictionary["amount"] as? Double ?? 0.0
        self.cancelled = dictionary["cancelled"] as? Bool ?? false
        self.cut = dictionary["cut"] as? Double ?? 0.0
        
        self.from = dictionary["from"] as? String ?? ""
        self.from_photo_gs = dictionary["from_photo_gs"] as? String ?? ""
        self.from_username = dictionary["from_username"] as? String ?? ""
        
        self.payout = dictionary["payout"] as? Double ?? 0.0
        self.processed = dictionary["processed"] as? Bool ?? false
        self.timestamp = dictionary["timestamp"] as? Double ?? 0.0
        
        self.to = dictionary["to"] as? String ?? ""
        self.to_photo_gs = dictionary["to_photo_gs"] as? String ?? ""
        self.to_username = dictionary["to_username"] as? String ?? ""
        
    }
}


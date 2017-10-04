//
//  WalletTableViewCell.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 29/09/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import Foundation

// Wallet TableViewCell
class WalletTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var receiptLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    var receipt: Receipt? {
        
        didSet {
            
            guard let uid = uid else { return }
            guard let receipt = receipt else { return }
            
            if receipt.to == uid {
                receiptLabel.text = receipt.from! + " paid You " + "\(String(describing: receipt.amount))"
                
            }
                
            else {
                receiptLabel.text = "You paid " + receipt.to!  + " \(String(describing: receipt.amount))"
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}



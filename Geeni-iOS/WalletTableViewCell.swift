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
                receiptLabel.text = receipt.from_username! + " paid You $" + "\(receipt.amount ?? 0.0)"
                if let imageURL = receipt.from_photo_gs {
                    
                    if imageURL.first == "g" {
                        storageRef = storage.reference(forURL: imageURL)
                        storageRef.downloadURL { (urL, error) in
                            self.userImageView.kf.setImage(with: urL)
                        }
                    } else {
                        self.userImageView.kf.setImage(with: URL(string : imageURL))
                    }
                }
            }
                
            else {
                receiptLabel.text = "You paid $" + receipt.to_username!  + " \(receipt.amount ?? 0.0)"
                if let imageURL = receipt.to_photo_gs {
                    
                    if imageURL.first == "g" {
                        storageRef = storage.reference(forURL: imageURL)
                        storageRef.downloadURL { (urL, error) in
                            self.userImageView.kf.setImage(with: urL)
                        }
                    } else {
                        self.userImageView.kf.setImage(with: URL(string : imageURL))
                    }
                }
                
            }
            
            let timestamp = receipt.timestamp
            let timestampDate = Date(timeIntervalSince1970: timestamp!/1000)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd"
            let dateString = dateFormatter.string(from: timestampDate)
            self.timestamp.text = dateString
        }
    }
}



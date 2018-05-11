//
//  CardListTableViewCell.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 06/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit

class CardListTableViewCell: UITableViewCell {
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    
    var card: Card? {
        
        didSet {
            guard let card = card else { return }
            
            cardNumber.text = "*" + card.last_four!
            
            // Set Images
            
            guard let provider = card.provider else { return }
            cardImageView.image = UIImage(named: provider)
            
        }
    }
}





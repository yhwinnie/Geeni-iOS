
//
//  SettingsTableViewCell.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 05/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel : UILabel!
    @IBOutlet weak var cellTextField : UITextField!
    
    override func awakeFromNib() {
        cellTextField.borderStyle = .none
    }
}

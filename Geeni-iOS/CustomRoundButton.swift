//
//  CustomRoundButton.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation
import UIKit

class CustomRoundButton: UIButton {
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    
    func setup() {
        self.backgroundColor = UIColor.blue
        self.layer.cornerRadius = 20.0
        self.setTitleColor(UIColor.white, for: .normal)
        
        
    }
    
    
    
    
}


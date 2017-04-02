//
//  CustomRoundImageView.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation
import UIKit

class CustomRoundImageView: UIImageView {
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    
    func setup() {
        self.layer.cornerRadius = self.frame.width / 2
        
        
        self.clipsToBounds = true 
        
        
    }


}

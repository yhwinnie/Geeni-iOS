//
//  CustomTextField.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    
    func setup() {
        self.borderStyle = .none
        
        let line = UIView(frame: CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 1))
        line.backgroundColor = UIColor.black 

        
        self.addSubview(line)
        
    }
    
    
    
    
}

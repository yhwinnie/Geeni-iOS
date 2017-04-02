//
//  CustomMenuBarButton.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation
import UIKit

class CustomMenuBarButton: UIBarButtonItem {
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    
    func setup() {
       // self.addTarget(self, action: #selector(clicked), for: .touchUpInside)

        self.image = UIImage(named: "hamburger")
        
    }
    

    
    
    
}

//
//  Card.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 06/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation

// Card Model
class Card: NSObject {
    var _id: String?
    var card_token: String?
    var last_four: String?
    var provider: String?
    var type: String?
    var user_id: String?
    
    init(dictionary: [String: Any]) {
        self._id = dictionary["_id"] as? String ?? ""
        self.card_token = dictionary["card_token"] as? String ?? ""
        self.last_four = dictionary["last_four"] as? String ?? ""
        self.provider = dictionary["provider"] as? String ?? ""
        self.type = dictionary["type"] as? String ?? ""
        self.user_id = dictionary["user_id"] as? String ?? ""
        
    }
}

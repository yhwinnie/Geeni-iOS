//
//  Messages.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 01/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation
import UIKit

// Message Model
class Message: NSObject {
    var _id: String?
    var to: String?
    var from: String?
    var message: String?
    var timestamp: Double?
    
    init(dictionary: [String: Any]) {
        self._id = dictionary["_id"] as? String ?? ""
        self.to = dictionary["student"] as? String ?? ""
        self.from = dictionary["tutor"] as? String ?? ""
        self.message = dictionary["message"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Double ?? 0.0
    }
}


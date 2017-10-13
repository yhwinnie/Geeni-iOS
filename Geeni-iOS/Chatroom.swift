//
//  Chatroom.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 11/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation

// Chatroom Model
class Chatroom: NSObject {
    var _id: String?
    var student: String?
    var tutor: String?
    //  var messages: [Message]?
    
    init(dictionary: [String: Any]) {
        self._id = dictionary["_id"] as? String ?? ""
        self.student = dictionary["student"] as? String ?? ""
        self.tutor = dictionary["tutor"] as? String ?? ""
        //      self.messages = dictionary["messages"] as? [Message] ?? []
        
    }
}

//
//  Session.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 06/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation


// Session Model
class Session: NSObject {
    var _id: String?
    var desc: String?
    var duration: Double?
    var location: String?
    
    var processed: Int?
    var start_time: Double?
    var student: String?
    var student_review_submitted: Bool?
    var subject: String?
    var timestamp: Double?
    
    var tutor: String?
    var tutor_name: String?
    var tutor_photo_gs: String?
    var tutor_review_submitted: Bool?
    
    var user_id: String?
    var user_photo_gs: String?
    var username: String?
    
    
    init(dictionary: [String: Any]) {
        self._id = dictionary["_id"] as? String ?? ""
        self.desc = dictionary["desc"] as? String ?? ""
        self.duration = dictionary["duration"] as? Double ?? 0.0
        self.location = dictionary["location"] as? String ?? ""
        
        self.processed = dictionary["processed"] as? Int ?? 0
        self.start_time = dictionary["start_time"] as? Double ?? 0.0
        
        self.student = dictionary["student"] as? String ?? ""
        self.student_review_submitted = dictionary["student_review_submitted"] as? Bool ?? false
        
        self.subject = dictionary["subject"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Double ?? 0.0
        
        self.tutor = dictionary["tutor"] as? String ?? ""
        self.tutor_name = dictionary["tutor_name"] as? String ?? ""
        self.tutor_photo_gs = dictionary["tutor_photo_gs"] as? String ?? ""
        self.tutor_review_submitted = dictionary["tutor_review_submitted"] as? Bool ?? false
        
        self.user_id = dictionary["user_id"] as? String ?? ""
        self.user_photo_gs = dictionary["user_photo_gs"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        
        
    }
}

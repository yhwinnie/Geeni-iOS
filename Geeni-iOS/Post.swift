//
//  Post.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/13/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation

class Post: NSObject {
    var _id: String?
    var desc: String?
    var duration: Double?
    var location: String?
    var private_sort_tag: String?
    var processed: Bool?
    var start_time: Double?
    var subject: String?
    var timestamp: Double?
    var user_id: String?
    var user_photo_gs: String?
    var username: String?
    var problem_photo_gs : String?

    init(dictionary: [String: Any]) {
        self._id = dictionary["_id"] as? String ?? ""
        self.desc = dictionary["desc"] as? String ?? ""
        self.duration = dictionary["duration"] as? Double ?? 0.0
        self.location = dictionary["location"] as? String ?? ""
        self.private_sort_tag = dictionary["private_sort_tag"] as? String ?? ""
        self.processed = dictionary["processed"] as? Bool ?? false
        self.start_time = dictionary["start_time"] as? Double ?? 0.0
        self.subject = dictionary["subject"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Double ?? 0.0
        self.user_id = dictionary["user_id"] as? String ?? ""
        self.user_photo_gs = dictionary["user_photo_gs"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.problem_photo_gs = dictionary["problem_photo_gs"] as? String ?? ""
    }
}

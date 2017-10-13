//
//  User.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/13/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation

// User Model
class User: NSObject {
    var _id: String?
    var email: String?
    var limit: Int?
    var balance_available: Double?
    var balance_pending: Double?
    var major: String?
    var nor_student: Int?
    var nor_tutor: Int?
    var overall_ratings_student: Double?
    var overall_ratings_tutor: Double?
    var photo_gs: String?
    var tutor_bool: Bool?
    var username: String?
    var year: Int?
    
    init(dictionary: [String: Any]) {
        self._id = dictionary["_id"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.limit = dictionary["limit"] as? Int ?? 0
        self.major = dictionary["major"] as? String ?? ""
        self.nor_student = dictionary["nor_student"] as? Int ?? 0
        self.nor_tutor = dictionary["nor_tutor"] as? Int ?? 0
        self.overall_ratings_student = dictionary["overall_ratings_student"] as? Double ?? 0.0
        self.overall_ratings_tutor = dictionary["overall_ratings_tutor"] as? Double ?? 0.0
        self.balance_available = dictionary["balance_available"] as? Double ?? 0.0
        self.balance_pending = dictionary["balance_pending"] as? Double ?? 0.0
        self.photo_gs = dictionary["photo_gs"] as? String ?? ""
        self.tutor_bool = dictionary["tutor_bool"] as? Bool ?? false
        self.username = dictionary["username"] as? String ?? ""
        self.year = dictionary["year"] as? Int ?? 0
    }
}

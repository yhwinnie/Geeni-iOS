//
//  Receipt.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 29/09/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation

// Receipt Model
class Receipt: NSObject {
    var _id: String?
    var amount: Double?
    var cancelled: Bool?
    var cut: Double?
    var from: String?
    var from_photo_gs: String?
    var from_username: String?
    var message: String?
    var payout: Double?
    var processed: Bool?
    var timestamp: Double?
    var to: String?
    var to_photo_gs: String?
    var to_username: String?
    
    
    init(dictionary: [String: Any]) {
        self._id = dictionary["_id"] as? String ?? ""
        self.amount = dictionary["amount"] as? Double ?? 0.0
        self.cancelled = dictionary["cancelled"] as? Bool ?? false
        self.cut = dictionary["cut"] as? Double ?? 0.0
        self.from = dictionary["from"] as? String ?? ""
        self.from_photo_gs = dictionary["from_photo_gs"] as? String ?? ""
        self.from_username = dictionary["from_username"] as? String ?? ""
        self.payout = dictionary["payout"] as? Double ?? 0.0
        self.processed = dictionary["processed"] as? Bool ?? false
        self.timestamp = dictionary["timestamp"] as? Double ?? 0.0
        self.to = dictionary["to"] as? String ?? ""
        self.to_photo_gs = dictionary["to_photo_gs"] as? String ?? ""
        self.to_username = dictionary["to_username"] as? String ?? ""
        
    }
}


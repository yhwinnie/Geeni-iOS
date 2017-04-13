//
//  Model.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/11/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation
import Gloss

protocol PostsDelegate: class {
    func periodLoaded(period: String)
}

//class Model {
//    
//    var delegate: PostsDelegate?
//    
//    init (day: NSDate) {
//        //code...
//        
//        // Query Period
//        let refFirstPeriod: FIRDatabaseReference!
//        refFirstPeriod = FIRDatabase.database().reference().child(Const.kFireChild)
//        refFirstPeriod.queryOrderedByChild(Const.kFireFromDate)..// set from to etc. //.....(.Value, withBlock: { snapshot in self.addPeriodsFromFIRDataSnapshots(snapshot) }, withCancelBlock: { error in self.delegate?.errorWileLoading(error) } )
//        
//        
//        private func addPeriodsFromFIRDataSnapshots(snapshot: FIRDataSnapshot) {
//            if let snap = snapshot.children.allObjects as? [FIRDataSnapshot] {
//                for child in snap {
//                    if let period = child.value {
//                        let fromDate = period[Const.kFireFromDate] as? String
//                        // Send new period to delegate
//                        let periodToAdd = Period( from: fromDate)
//                        self.delegate?.periodLoaded(periodToAdd)
//                    } else {
//                        let error = NSError(domain: Const.kDomain, code: Const.kErrorNum, userInfo: [
//                            NSLocalizedDescriptionKey: Const.kErrorDataFormat])
//                        // Send error to delegate
//                        self.delegate?.errorWileLoading(error)
//                    }
//                }
//            }
//        }
//    }
//}

//struct PageData<T: Decodable> {
//
//    var data: [T]
//}
//
//extension PageData: Decodable {
//    init?(json: JSON) {
//
//        guard let data: [T] = "posts" <~~ json else { return nil }
//
//        self.data = data
//
//    }
//}
//
//struct Post: Decodable {
//    let _id: String
//    let desc: String
//    let duration: Double
//    let location: String
//    let private_sort_tag: String
//    let processed: Int
//    let start_time: Double
//    let subject: String
//    let timestamp: Double
//    let user_id: String
//    let user_photo_gs: String
//    let username: String
//
//    init?(json: JSON) {
//        guard let _id: String = "_id" <~~ json else { return nil }
//        guard let desc: String = "desc" <~~ json else { return nil }
//        guard let duration: Double = "duration" <~~ json else { return nil }
//
//        guard let location: String = "location" <~~ json else { return nil }
//        guard let private_sort_tag: String = "private_sort_tag" <~~ json else { return nil }
//        guard let processed: Int = "processed" <~~ json else { return nil }
//
//        guard let start_time: Double = "start_time" <~~ json else { return nil }
//        guard let subject: String = "subject" <~~ json else { return nil }
//        guard let timestamp: Double = "timestamp" <~~ json else { return nil }
//
//        guard let user_id: String = "user_id" <~~ json else { return nil }
//        guard let user_photo_gs: String = "user_photo_gs" <~~ json else { return nil }
//        guard let username: String = "username" <~~ json else { return nil }
//
//        self._id = _id
//        self.desc = desc
//        self.duration = duration
//        self.location = location
//        self.private_sort_tag = private_sort_tag
//        self.processed = processed
//        self.start_time = start_time
//        self.subject = subject
//        self.timestamp = timestamp
//        self.user_id = user_id
//        self.user_photo_gs = user_photo_gs
//        self.username = username
//    }
//}
//

//struct Answer: Decodable {
//    let thumbnailURL: URL
//    let videoURL: URL
//    let question: Question
//    var commentCount: Int?
//    var id: Int = 0
//    let likesCount: Int?
//
//    init?(json: JSON) {
//        guard let thumbnailURL: URL = "thumbnail_url" <~~ json else { return nil }
//        guard let videoURL: URL = "video_url" <~~ json else { return nil }
//        guard let question: Question = "question" <~~ json else { return nil }
//
//        guard let id: Int = "id" <~~ json else { return nil }
//
//
//        self.thumbnailURL = thumbnailURL
//        self.videoURL = videoURL
//        self.question = question
//        self.commentCount = "comment_count" <~~ json
//        self.id = id
//        self.likesCount = "likes_count" <~~ json
//
//    }
//}

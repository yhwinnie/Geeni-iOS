//
//  AvailableTutors.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 22/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation

class availableTutors  {
    var tutors : [Tutors] = []
    
    init(dict : [Tutors]) {
        tutors = dict
    }
}

class Tutors {
    var isRejected : Bool = false
    var tutor_id : String = ""
    var photo_gs : String = ""
    var username : String = ""
    
    init(dict : [String : AnyObject]){
        isRejected = dict["isRejected"] as? Bool ?? false
        tutor_id = dict["tutor_id"] as? String ?? ""
        photo_gs = dict["photo_gs"] as? String  ?? ""
        username = dict["username"] as? String  ?? ""
    }
}

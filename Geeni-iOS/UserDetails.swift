//
//  UserDetails.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 29/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation

struct UserDetails {
    
    static var user : User?
    static var userToken : String?
    static var userPosts : [Post] = []
    static var sessions : [Session] = []
    static var tutorSessions : [Session] = []
    static var selectedCard : Card? = nil
}

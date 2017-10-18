//
//  FirebaseCalls.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 13/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FirebaseCalls {
    
    // Firebase Calls for User's Personal Information
    func saveUserDetails(name : String , majors : String , year : String , completionHandler : @escaping(_ bool : Bool) -> Void){
        let userDict: [String : AnyObject] =
            ["_id": FIRAuth.auth()?.currentUser?.uid as AnyObject,
             "balance_available": 0 as AnyObject,
             "balance_pending": 0 as AnyObject,
             "email": FIRAuth.auth()?.currentUser?.email as AnyObject,
             "limit": 0 as AnyObject,
             "major": majors as AnyObject,
             "nor_student": 0 as AnyObject,
             "overall_ratings_student": 0 as AnyObject,
             "overall_ratings_tutor": 0 as AnyObject,
             "photo_gs": FIRAuth.auth()?.currentUser?.photoURL?.absoluteString as AnyObject,
             "tutor_bool": false as AnyObject,
             "username": name as AnyObject,
             "year": year as AnyObject
        ]
        
        ref.child("users").childByAutoId().setValue(userDict)
        completionHandler(true)
    }
    
    func updateUserDetails(){
        
    }
    
    func getUserDetails(completionHandler : @escaping (_ userDetails : User? , _ bool : Bool) -> Void) {
        var foundDetails : Bool = false
        var userDetails : User?
        let userId = FIRAuth.auth()?.currentUser?.uid
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            for id in snapshot.children {
                let user = (id as! FIRDataSnapshot).value as! [String : AnyObject]
                if user["_id"] as! String == userId! {
                    foundDetails = true
                    userDetails = User(dictionary : user)
                    break;
                }
            }
            if foundDetails {
                completionHandler(userDetails!,foundDetails)
            } else {
                completionHandler(nil,foundDetails)
            }
        })
    }
}

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
    func saveUserDetails(name : String , majors : String , year : String ,tutor_bool : Bool, completionHandler : @escaping(_ bool : Bool) -> Void){
        let userDict: [String : AnyObject] =
            ["_id": Auth.auth().currentUser?.uid as AnyObject,
             "balance_available": 0 as AnyObject,
             "balance_pending": 0 as AnyObject,
             "email": Auth.auth().currentUser?.email as AnyObject,
             "limit": 0 as AnyObject,
             "major": majors as AnyObject,
             "nor_student": 0 as AnyObject,
             "overall_ratings_student": 0 as AnyObject,
             "overall_ratings_tutor": 0 as AnyObject,
             "photo_gs": Auth.auth().currentUser?.photoURL?.absoluteString as AnyObject,
             "tutor_bool": tutor_bool as AnyObject,
             "username": name as AnyObject,
             "year": year as AnyObject
        ]
        
        //registering user to stripe
        //todo
        
        ref.child("users").childByAutoId().setValue(userDict)
        completionHandler(true)
    }
    
    // uploading image to firebase storage
    func uploadImageToFirebase(_ image : UIImage, completionHandler : @escaping (_ url : String? , _ error : Error?) -> Void){
        if let pngRepresentation = UIImagePNGRepresentation(image){
            storageRef.putData(pngRepresentation, metadata: nil) { (metadata, error) in
                if error != nil {
                    completionHandler(nil,error)
                } else {
                    let imageUrlString = metadata?.downloadURL()?.absoluteString
                    completionHandler(imageUrlString , nil)
                }
            }
        }
        
    }
    
    //creating new post
    func createNewPost(_ dict : [String : AnyObject] , completionHandler : @escaping(_ bool : Bool) -> Void) {
        let postRef = ref.child("posts").childByAutoId()
        let id = postRef.key
        var postDict : [String : AnyObject] = dict
        postDict["_id"] = id as AnyObject
        postRef.setValue(postDict)
        completionHandler(true)
    }
    
    //deleting private post
    func deletePost() {
        
    }
    
    //getting user's details
    func getUserDetails( idString : String? , completionHandler : @escaping (_ userDetails : User? , _ bool : Bool) -> Void) {
        var foundDetails : Bool = false
        var userDetails : User?
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            for id in snapshot.children {
                let user = (id as! DataSnapshot).value as! [String : AnyObject]
                let userIdString = user["_id"] as! String
                if userIdString  == idString {
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
    
    //MARK: - chatroom firebase calls
    func createNewChatroom(student : String? , completionHandler:@escaping( _ chatroom : Chatroom? , _ bool : Bool) -> Void){
        guard let uid = uid else { return }
        let tutorId = uid
        let studentId = student
        var newChatroom = [String : AnyObject]()
        newChatroom["tutor"] = tutorId as AnyObject
        newChatroom["student"] = studentId as AnyObject
        let chatroomRef = ref.child("chatrooms").childByAutoId()
        let chatroomId = chatroomRef.key
        newChatroom["_id"] = chatroomId as AnyObject
        chatroomRef.setValue(newChatroom)
        completionHandler(Chatroom(dictionary : newChatroom),true)
    }
    
    func createMessage(dict : [String:AnyObject] , chatroomId : String, completionHandler : @escaping( _ bool : Bool) -> Void ) {
        let messageRef = ref.child("chatrooms").child(chatroomId).child("messages").childByAutoId()
        let messageKey = messageRef.key
        var messageDict = dict
        messageDict["_id"] = messageKey as AnyObject
        messageRef.setValue(messageDict)
        completionHandler(true)
    }
    
    //get sessions with current user as student
    func getUserSessions(_ completionHandler : @escaping( _ sessions : [Session]) -> Void){
        var sessionsArray : [Session] = []
        ref.child("sessions").observeSingleEvent(of: .value , with: { (snapshot) in
            for id in snapshot.children {
                let user = (id as! DataSnapshot).value as! [String : AnyObject]
                let userIdString = user["user_id"] as! String
                if userIdString == uid {
                    sessionsArray.append(Session(dictionary: user))
                }
            }
        })
        
        //sort sessions based on start time
        let sortedArray = sessionsArray.sorted(by: {$0.start_time! < $1.start_time!})
        completionHandler(sortedArray)
    }
    
    //get sessions with current user as student
    func getTutorSessions(_ completionHandler : @escaping( _ sessions : [Session]) -> Void){
        var sessionsArray : [Session] = []

        ref.child("sessions").observeSingleEvent(of: .value , with: { (snapshot) in
            for id in snapshot.children {
                let user = (id as! DataSnapshot).value as! [String : AnyObject]
                let userIdString = user["tutor"] as! String
                if userIdString == uid {
                    sessionsArray.append(Session(dictionary: user))
                }
            }
        })
        
        //sort sessions based on start time
        let sortedArray = sessionsArray.sorted(by: {$0.start_time! < $1.start_time!})
        completionHandler(sortedArray)
    }
}

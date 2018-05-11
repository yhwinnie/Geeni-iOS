//
//  ServerCalls.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 14/11/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation
import Firebase
import Stripe
import Alamofire

class ServerCalls {
    
    func addNewCard(_ stripeToken : STPToken , completionHandler : @escaping( _ bool : Bool , _ errorMessage : String?) -> Void){
        let url = "https://geeni-test-server.herokuapp.com/api/test/card"
        let currentUser = Auth.auth().currentUser
        
        currentUser?.getIDTokenForcingRefresh(true, completion: { (token, error) in
            if error == nil {
                
                let userToken = token
                UserDetails.userToken = userToken
                
                let parameters : Parameters = ["user_token" : UserDetails.userToken! ,
                                               "client_card_token" : "\(stripeToken)"]
                
                Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                    if let json = response.result.value  {
                        let data = json as! [String : Any]
                        let success = data["success"] as! Int
                        if success == -1 {
                            let errorMessage = data["message"] as! String
                            completionHandler(false,errorMessage)
                        } else {
                            completionHandler(true,nil)
                        }
                    }
                }
            } else {
                completionHandler(false,error?.localizedDescription)
            }
        })
    }
    
    func acceptTutor(studentId : String, postId : String , completionHandler : @escaping (_ message : String) -> Void) {
        //userToken, postId, tutor
        let tutorId = uid
        
        let parameters : [String : Any] = ["user_token" : studentId ,
                                           "post_id" : postId ,
                                           "accepted_tutor" : tutorId ?? ""]
        
        let url = "https://geeni-test-server.herokuapp.com/api2/tutor_acception"
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if response.error != nil {
                if response.response?.statusCode == 200 {
                    completionHandler("Session Created")
                } else {
                    completionHandler("Could not tutor this student")
                }
            } else {
                let json = response.result.value as? NSDictionary
                let message = json!["message"] as! String
                completionHandler(message)
            }
        }
    }
    
    func cancelSession(sessionId : String, completionHandler : @escaping (_ message : String) -> Void) {
        let url = "https://geeni-test-server.herokuapp.com/api2/cancel_session"
        let parameters  : [String : Any] = ["session_id" : sessionId ,
                                            "user_token" : uid ?? ""]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if response.error != nil {
                completionHandler("Could not cancel session")
            } else {
                let json = response.result.value as? NSDictionary
                let message = json!["message"] as! String
                completionHandler(message)
                
            }
        }
    }
    
    func endSession(_ session : Session,_ time : Int, completionHandler : @escaping(_ message : Int) -> Void){
        let url = "https://geeni-test-server.herokuapp.com/api2/end_session"
        let sessionId = session._id
        let tutorId = session.tutor
        let stripeId = session.stripeid_customer
        let endTime = time * 1000
        let userId = session.user_id
        
        let parameters : [String : Any] = ["session_id" : sessionId ?? "",
                                           "tutor_token" : tutorId ?? "",
                                           "stripe_token" : stripeId ?? "",
                                           "total_time" : endTime,
                                           "user_token" : userId ?? ""]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if response.error != nil {
                completionHandler(-1)
            } else {
                let json = response.result.value as? NSDictionary
                let success = json!["success"] as! Int
                completionHandler(success)
            }
        }
    }
    
    func retryPayment(_ id : String, completionHandler : @escaping(_ message : String) -> Void){
        let url = "https://geeni-test-server.herokuapp.com/api2/retry"
        ref.child("receipts").observe(.value, with: { (snapshot) in
            let receiptArray = snapshot.children.allObjects as NSArray
            for receipt in receiptArray {
                let receiptSnapshot = receipt as! DataSnapshot
                if let receiptValue = receiptSnapshot.value as? NSDictionary {
                    let sessionId = receiptValue["session_id"] as! String
                    if sessionId == id {
                        let receiptId = receiptValue["_id"] as! String
                        let paramters : [String : Any] = ["receipt_id" : receiptId,
                                                          "user_token" : UserDetails.userToken]
                        Alamofire.request(url, method: .post, parameters: paramters, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                            if response.error != nil {
                                completionHandler("Successful Payment")
                            } else {
                                let json = response.result.value as? NSDictionary
                                let success = json!["message"] as! String
                                completionHandler(success)
                            }
                        })
                    }
                }
            }
        })
        
        
    }
}

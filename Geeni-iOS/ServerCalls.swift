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
                let success = json!["success"] as!  Int
                if success == 1 {
                    completionHandler(message)
                } else {
                    completionHandler("Could not tutor this student")
                }
            }
        }
    }
    
    func cancelSession(){
        
    }
}

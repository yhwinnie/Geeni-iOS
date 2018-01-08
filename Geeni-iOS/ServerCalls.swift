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
        let currentUser = FIRAuth.auth()?.currentUser
        currentUser?.getTokenForcingRefresh(true, completion: { (token, error) in
            if error == nil {
                UserDetails.userToken = token
                let parameters : Parameters = ["user_token" : UserDetails.userToken! , "client_card_token" : "\(stripeToken)"]
                
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
                completionHandler(false,"Unexpected error occurred!")
            }
        })
    }
}

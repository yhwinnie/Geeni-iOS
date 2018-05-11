//
//  Utils.swift
//  Geeni-iOS
//
//  Created by Casey Takeda on 3/16/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

var uid = Auth.auth().currentUser?.uid
let ref = Database.database().reference()

let storage = Storage.storage()
var storageRef: StorageReference!

func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}




    


//
//  MessagesViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// Message Model
class Message: NSObject {
    var _id: String?
    var to: String?
    var from: String?
    var message: String?
    var timestamp: Double?
    

    init(dictionary: [String: Any]) {
        self._id = dictionary["_id"] as? String ?? ""
        
        self.to = dictionary["student"] as? String ?? ""
        
        self.from = dictionary["tutor"] as? String ?? ""
        
        self.message = dictionary["message"] as? String ?? ""

        self.timestamp = dictionary["timestamp"] as? Double ?? 0.0
    }
}

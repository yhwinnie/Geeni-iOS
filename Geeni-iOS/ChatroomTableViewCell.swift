//
//  ChatroomTableViewCell.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 11/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit

class ChatroomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var chatroom: Chatroom? {
        
        didSet {
            
            guard let uid = uid else { return }
            guard let chatroom = chatroom else { return }
            //          guard let messages = chatroom.messages else { return }
            //
            //            if (messages.count) > 0 {
            //                descriptionLabel.text = messages[0].message
            //            }
            
            if chatroom.student == uid {
                userName.text = chatroom.tutor
            }
            else {
                userName.text = chatroom.student
            }
            
        }
    }
}

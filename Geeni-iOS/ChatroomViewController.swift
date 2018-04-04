//
//  ChatroomViewController.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 25/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatroomViewController: JSQMessagesViewController {
    
    lazy var outgoingBubbleImageView = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView = self.setupIncomingBubble()
    
    var chatroom : Chatroom?
    var sender : String?
    var receiverId : String?
    var receiverUsername : String?
    var messages = [JSQMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: receiverUsername!)
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        self.senderId = sender
        self.senderDisplayName = ""
        observeMessages()
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        //do nothing
    }
    
    private func addMessage(message : Message) {
        if let jsqMessage = JSQMessage(senderId: message.from, displayName: "name", text: message.message) {
            messages.append(jsqMessage)
        }
    }
    
    // collection view data source
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    // message cell bubble color
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
    }
    
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        return JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: colors.blueColor)
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        return JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    // cell text label color
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            cell.textView.textColor = colors.whiteColor
        } else {
            cell.textView.textColor = colors.blackColor
        }
        return cell
    }
    
    //removing avatars
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        var message = [String : AnyObject]()
        message["to"] = receiverId as AnyObject
        message["from"] = sender as AnyObject
        message["message"] = text! as AnyObject
        message["timestamp"] = Date().timeIntervalSince1970 as AnyObject
        let chatroomId = chatroom?._id
        FirebaseCalls().createMessage(dict: message, chatroomId: chatroomId!) { (bool) in
            if bool {
                JSQSystemSoundPlayer.jsq_playMessageSentSound()
                self.finishSendingMessage()
            } else {
                self.showAlert("Unexpected error occured!")
            }
        }
    }
    
    //getting messages from firebase
    private func observeMessages(){
        let chatroomId = chatroom?._id
        ref.child("chatrooms").child(chatroomId!).child("messages").observe(.childAdded , with : { (snapshot) in
            let message = snapshot.value as! Dictionary<String,AnyObject>
            let messageObject = Message(dictionary: message)
            self.addMessage(message: messageObject)
            self.finishSendingMessage()
        })
    }
}

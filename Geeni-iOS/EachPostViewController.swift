//
//  EachPostViewController.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 03/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation
import UIKit

class EachPostViewController : UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView : UIActivityIndicatorView!
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    var descriptionTableViewCellHeight : CGFloat = 0.0
    var currentPost : Post? = nil
    var addTutor : Bool = false
    var tutorsArray : [Tutors] = []
    var profileImageXibArray : [ProfileImageXib] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupProfileImageView()
        addTutorButton(addTutor)
        activityIndicatorView.isHidden = true
    }
    
    func setupTableView(){
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupProfileImageView(){
        
        let profileImageView = Bundle.main.loadNibNamed("ProfileImageXib", owner: self, options: nil)![0] as? ProfileImageXib
        profileImageView?.frame = CGRect(x: 0, y: -statusBarHeight, width: self.view.frame.width, height: 250)
        profileImageView?.center.x = self.view.center.x
        let userImageUrl = URL(string: (currentPost?.user_photo_gs!)!)
        if currentPost?.user_photo_gs!.first != "g" {
            // if the photo is saved in firebase storage
            profileImageView?.userImage.kf.setImage(with: userImageUrl)
            profileImageView?.backgroundImage.kf.setImage(with: userImageUrl)
        } else {
            // if there is a direct link
            storageRef = storage.reference(forURL: (currentPost?.user_photo_gs!)!)
            storageRef.downloadURL { (url, error) in
                profileImageView?.userImage.kf.setImage(with: url)
                profileImageView?.backgroundImage.kf.setImage(with: url)
                profileImageView?.messageButton.addTarget(self, action: #selector(self.messageButtonPressed), for: .touchUpInside)
            }
        }
        
        // when profile image is clicked
        profileImageView?.userImage.isUserInteractionEnabled = true
        profileImageView?.userImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImageClicked)))
        
        profileImageView?.userNameLabel.text = currentPost?.username!
        profileImageView?.subjectNameLabel.text = currentPost?.subject!
        profileImageView?.majorLabel.text = "@" + (currentPost?.username!)!
        profileView.frame.origin.y = -statusBarHeight
        profileView.frame = (profileImageView?.frame)!
        if !addTutor {
            // hide message button if the user is not a tutor
            profileImageView?.hideMessageButton(true)
        }
        profileView.addSubview(profileImageView!)
        profileImageView?.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        profileImageXibArray.append(profileImageView!)
    }
    
    //presenting profile of post owner
    func profileImageClicked(){
        let profileViewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "Profile") as! ProfileTableViewController
        profileViewController.userDetails = false
        profileViewController.id = (currentPost?.user_id)!
        self.present(profileViewController, animated: true, completion: nil)
    }
    
    func backButtonPressed() {
        profileImageXibArray = []
        self.dismiss(animated: true, completion: nil)
    }
    
    func messageButtonPressed(){
        // go to chat room
    }
    
    func addTutorButton(_ bool : Bool){
        // check if the user is tutor or not
        if bool {
            let tutorButton = UIButton()
            tutorButton.frame = CGRect(x: 0.0, y: self.view.frame.height - 75.0, width: self.view.frame.width, height: 75.0)
            tutorButton.setTitle("Tutor this student", for: .normal)
            tutorButton.backgroundColor = colors.blueColor
            tutorButton.setTitleColor(colors.whiteColor, for: .normal)
            tutorButton.addTarget(self, action: #selector(tutorButtonPressed), for: .touchUpInside)
            self.view.addSubview(tutorButton)
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 75, right: 0)
        }
    }
    
    func tutorButtonPressed() {
        // create chat room and unhide message button if chatroom is already not present
//        profileImageXibArray.first?.hideMessageButton(false)
//        FirebaseCalls().createNewChatroom(student: currentPost?.user_id) { (chatroom, bool) in
//            if bool {
//                // chat room created
//                let alertController = UIAlertController(title: "Geeni", message: "New Chatroom created", preferredStyle: .alert)
//                let alertAction = UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
//                    self.dismiss(animated: true, completion: nil)
//                })
//                alertController.addAction(alertAction)
//                self.present(alertController, animated: true, completion: nil)
//            } else {
//                self.showAlert("Unexpected error occurred!")
//            }
//        }
        
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        
        ServerCalls().acceptTutor(studentId: (currentPost?.user_id)!, postId: (currentPost?._id)!, completionHandler: {(message) in
            self.showAlert(message)
            self.navigationController?.popViewController(animated: true)
            self.activityIndicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        })
    }
    
    func setupResponses(){
        tutorsArray = []
        if currentPost?.available_tutors != nil {
            tutorsArray = (currentPost?.available_tutors?.tutors)!
        }
    }
}

extension EachPostViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return tutorsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "postDetail") as! PostDetailTableViewCell
                cell.classNameLabel.text = currentPost?.subject
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yy h:mm a Z"
                let date = Date(timeIntervalSince1970: TimeInterval((currentPost?.start_time!)!/1000.0))
                let dateString = dateFormatter.string(from:date)
                cell.dateLabel.text = dateString
                cell.locationLabel.text  = currentPost?.location!
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "postDescription")
                cell?.textLabel?.numberOfLines = 0
                cell?.textLabel?.text = currentPost?.desc!
                cell?.textLabel?.sizeToFit()
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
                descriptionTableViewCellHeight = (cell?.textLabel?.frame.height)!
                return cell!
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "image") as! PostImageTableViewCell
                if currentPost?.problem_photo_gs != "" {
                    let imageUrl = URL(string:(currentPost?.problem_photo_gs!)!)
                    if currentPost?.problem_photo_gs?.first == "g" {
                        storageRef = storage.reference(forURL: (currentPost?.problem_photo_gs!)!)
                        storageRef.downloadURL { (url, error) in
                            cell.postImageView?.kf.setImage(with: url)
                            cell.postImageView?.frame.size = CGSize(width: self.view.frame.width - 30, height: 250)
                            tableView.reloadData()
                        }
                    } else {
                        cell.postImageView?.kf.setImage(with: imageUrl)
                    }
                } else {
                    tableView.reloadData()
                }
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "postResponse") as! PostResponseTableViewCell
            cell.userLabel.text = tutorsArray[indexPath.item].username
            let imageUrl = URL(string : tutorsArray[indexPath.item].photo_gs)
            if tutorsArray[indexPath.item].photo_gs.first == "g" {
                storageRef = storage.reference(forURL: (tutorsArray[indexPath.item].photo_gs))
                storageRef.downloadURL { (url, error) in
                    cell.userImage.kf.setImage(with: url)
                }
            } else {
                cell.userImage.kf.setImage(with: imageUrl)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0{
                return 80
            } else if indexPath .row == 1{
                return descriptionTableViewCellHeight + 10.0
            } else {
                if currentPost?.problem_photo_gs != "" {
                    return 400
                } else {
                    return 0.0
                }
            }
        } else {
            return 100.0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 1 {
            let headerView = view as? UITableViewHeaderFooterView
            headerView?.textLabel?.text = "Responses"
            headerView?.textLabel?.textColor = colors.blueColor
            headerView?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            if tutorsArray.count > 0 {
                return 30.0
            } else {
                return 0.0
            }
        } else {
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.section == 1 {
            let messageButton = UITableViewRowAction(style: .normal, title: "") { (rowAction, indexPath) in
            }
            messageButton.backgroundColor = UIColor.init(patternImage: UIImage(named : "messageAction")!)
            return [messageButton]
        } else {
            return []
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}

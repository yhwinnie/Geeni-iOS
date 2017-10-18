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
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    var descriptionTableViewCellHeight : CGFloat = 0.0
    var currentPost : Post? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupProfileImageView()
        addTutorButton(true)
    }
    
    func setupTableView(){
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupProfileImageView(){
        let profileImageView = Bundle.main.loadNibNamed("ProfileImageXib", owner: self, options: nil)![0] as? ProfileImageXib
        profileImageView?.frame = CGRect(x: 0, y: -statusBarHeight, width: self.view.frame.width, height: 250)
        profileImageView?.center.x = self.view.center.x
        let userImageUrl = URL(string: (currentPost?.user_photo_gs!)!)
        if currentPost?.user_photo_gs!.first != "g" {
        profileImageView?.userImage.kf.setImage(with: userImageUrl)
        profileImageView?.backgroundImage.kf.setImage(with: userImageUrl)
        } else {
            storageRef = storage.reference(forURL: (currentPost?.user_photo_gs!)!)
            storageRef.downloadURL { (url, error) in
                profileImageView?.userImage.kf.setImage(with: url)
                profileImageView?.backgroundImage.kf.setImage(with: url)
            }
        }
        profileImageView?.userNameLabel.text = currentPost?.username!
        profileImageView?.subjectNameLabel.text = currentPost?.subject!
        profileView.frame.origin.y = -statusBarHeight
        profileView.frame = (profileImageView?.frame)!
        profileView.addSubview(profileImageView!)
        profileImageView?.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addTutorButton(_ bool : Bool){
        let tutorButton = UIButton()
        tutorButton.frame = CGRect(x: 0.0, y: self.view.frame.height - 75.0, width: self.view.frame.width, height: 75.0)
        tutorButton.setTitle("Tutor this student", for: .normal)
        tutorButton.backgroundColor = colors.blueColor
        tutorButton.setTitleColor(colors.whiteColor, for: .normal)
        self.view.addSubview(tutorButton)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 75, right: 0)
    }
}

extension EachPostViewController : UITableViewDelegate {
    
}

extension EachPostViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "postDetail") as! PostDetailTableViewCell
                cell.classNameLabel.text = currentPost?.subject
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yy"
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "postImage") as! PostImageTableViewCell
                if currentPost?.problem_photo_gs != "" {
                    let imageUrl = URL(string:(currentPost?.problem_photo_gs!)!)
                    if currentPost?.problem_photo_gs?.first == "g" {
                        storageRef = storage.reference(forURL: (currentPost?.user_photo_gs!)!)
                        storageRef.downloadURL { (url, error) in
                            cell.imageView?.kf.setImage(with: url)
                        }
                    } else {
                    cell.imageView?.kf.setImage(with: imageUrl)
                    }
                }
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "postResponse") as! PostResponseTableViewCell
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
                return 260.0
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
            return 30.0
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
        }else {
            return []
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }
}

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
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "postDescription")
                cell?.textLabel?.numberOfLines = 0
                cell?.textLabel?.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                cell?.textLabel?.sizeToFit()
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
                descriptionTableViewCellHeight = (cell?.textLabel?.frame.height)!
                return cell!
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "postImage") as! PostImageTableViewCell
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
                return 260.0
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

//
//  NewPostTableViewContoller.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 01/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit

class NewPostTableViewContoller: UITableViewController {
    
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var submitPostButton: UIButton!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "New Post")
        revealSideMenu(menuButton)
        setupSubmitButton()
        tableView.tableFooterView = UIView()
        setupTextFields()
        tableView.allowsSelection = false
        
    }
    
    
    
    func setupSubmitButton() {
        submitPostButton.createSubmitButton()
        submitPostButton.center.x = self.view.center.x
    }
    
    func setupTextFields() {
        locationTextField.setBottomLine()
        courseTextField.setBottomLine()
        dateTextField.setBottomLine()
        locationTextField.delegate = self
        courseTextField.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 8 || indexPath.row == 9 {
            return 70.0
        } else if indexPath.row == 7 {
            return 200.0
        } else {
            return 44.0
        }
    }
}

extension NewPostTableViewContoller : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

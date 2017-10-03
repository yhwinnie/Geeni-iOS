//
//  BecomeTutorPartOneTableViewController.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 01/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit

class BecomeTutorPartOneTableViewController: UITableViewController {
    
    @IBOutlet weak var majotTextField: UITextField!
    @IBOutlet weak var experienceTextField: UITextField!
    @IBOutlet weak var availabilityTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Become a Tutor")
        setupTextFields()
        setupContinueButton()
        revealSideMenu(menuButton)
        tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "Become a Tutor"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationItem.title = ""
    }
    
    func setupTextFields() {
        majotTextField.setBottomLine()
        experienceTextField.setBottomLine()
        availabilityTextField.setBottomLine()
        majotTextField.delegate = self
        experienceTextField.delegate = self
        availabilityTextField.delegate = self        
    }
    
    func setupContinueButton() {
        continueButton.createSubmitButton()
        continueButton.center.x = self.view.center.x
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "continueTutor", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 8 {
            return 70.0
        } else if indexPath.row == 7 {
            return 200.0
        } else {
            return 44.0
        }
    }
}

extension BecomeTutorPartOneTableViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


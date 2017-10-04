//
//  SettingsTableViewController.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 29/09/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SWRevealViewController

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var backButton : UIBarButtonItem!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var saveSettingsButton : UIButton!

    
    override func viewDidLoad() {        
        self.setupNavigationBar(title: "Settings")
        setupTableView()
        setupSaveSettingsButton()
    }
    
    func setupTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
    
    func setupSaveSettingsButton(){
        saveSettingsButton.setTitle("Save Settings", for: .normal)
        saveSettingsButton.setTitleColor(colors.whiteColor, for: .normal)
        saveSettingsButton.backgroundColor = colors.blueColor
    }
    
    
    @IBAction func backButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController : UITableViewDelegate {
    //todo
}

extension SettingsViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell") as! SettingsTableViewCell
        cell.cellLabel.text = "Field" + " \(indexPath.row + 1)"
        cell.cellTextField.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Personal Information"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let tableHeaderView = view as? UITableViewHeaderFooterView
        tableHeaderView?.textLabel?.textColor = colors.blueColor
        tableHeaderView?.textLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight = tableView.frame.height - 60.0
        return rowHeight/6
    }
}

extension SettingsViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

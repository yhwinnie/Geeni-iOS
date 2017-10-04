//
//  Extensions.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 29/09/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import Foundation
import UIKit
import SWRevealViewController

extension UIViewController {
    
    func showAlert(_ msg : String){
        let alertController = UIAlertController(title: "Geeni", message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupNavigationBar(title : String) {
        self.navigationController?.navigationBar.barTintColor = colors.blueColor
        self.navigationItem.title = title
        self.navigationController?.navigationBar.tintColor = colors.whiteColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : colors.whiteColor]
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    //reveal side menu
    func revealSideMenu(_ menuButton : UIBarButtonItem) {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
}

extension UIImageView {
    
    func makeRound() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    func setBorder( color : CGColor , width : CGFloat){
        self.layer.borderColor = color
        self.layer.borderWidth = width
    }
}

extension UITextField {
    
    func addDoneButton() {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        doneButton.tintColor = colors.blueColor
        toolbar.items = [doneButton]
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }
    
    func doneButtonPressed(){
        self.resignFirstResponder()
    }
}

extension UITextView {
    
    func addDoneButton() {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        doneButton.tintColor = colors.blueColor
        toolbar.items = [doneButton]
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }
    
    func doneButtonPressed(){
        self.resignFirstResponder()
    }
}

extension UIButton {
    func createSubmitButton(){
        self.backgroundColor = colors.blueColor
        self.setTitleColor(colors.whiteColor, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = true
        self.frame.size.width += 100
        self.frame.size.height = 50
        self.clipsToBounds = true
        self.layer.cornerRadius = 25
    }
}


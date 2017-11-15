//
//  SignUpTableViewController.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 13/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import SWRevealViewController
import Firebase
import Kingfisher
import Stripe

class SignUpTableViewController: UITableViewController {
    
    @IBOutlet weak var userPictureView : UIImageView!
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var majorsTextField : UITextField!
    @IBOutlet weak var yearTextField : UITextField!
    @IBOutlet weak var saveDetailsButton : UIButton!
    @IBOutlet weak var segmentController : UISegmentedControl!
    
    var imagePickerController = UIImagePickerController()
    var tutor_bool =  false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        setupNavigationBar(title: "Enter Personal Information")
        setupTextFields()
        setupImageView()
        setupSaveDetailsButton()
        imagePickerController.delegate  = self
        setupSegmentController()
    }
    
    func setupSegmentController(){
        segmentController.backgroundColor = colors.whiteColor
        segmentController.tintColor = colors.blueColor
        let font = UIFont.systemFont(ofSize: 16)
        segmentController.setTitleTextAttributes([NSFontAttributeName: font],
                                                for: .normal)
    }
    
    func setupImageView(){
        userPictureView.image = UIImage(named: "user_gray")
        userPictureView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userPictureTapped)))
        userPictureView.clipsToBounds = true
        userPictureView.isUserInteractionEnabled = true
        userPictureView.layer.cornerRadius = 75
        setupUserImage()
    }
    
    func setupSaveDetailsButton(){
        saveDetailsButton.createSubmitButton()
        saveDetailsButton.setTitle("SAVE DETAILS", for: .normal)
        saveDetailsButton.center.x = self.view.center.x
    }
    
    @IBAction func segmentControllerValueChanged(){
        if segmentController.selectedSegmentIndex == 0 {
            tutor_bool = false
        } else {
            tutor_bool = true
        }
    }
    
    func userPictureTapped(){
        let alertController = UIAlertController(title: "Upload Photo", message: "Please select from the following options", preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        let photoAlbumAction = UIAlertAction(title: "Photo Album", style: .default) { (action) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        let removeAction = UIAlertAction(title: "Remove Photo", style: .destructive) { (action) in
            self.userPictureView.image = UIImage(named : "user_gray")
        }
        
        let gmailAction = UIAlertAction(title : "Gmail Image", style : .default) { (action) in
            self.userPictureView.kf.setImage(with: FIRAuth.auth()?.currentUser?.photoURL)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoAlbumAction)
        alertController.addAction(gmailAction)
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupTextFields() {
        nameTextField.borderStyle = .none
        majorsTextField.borderStyle = .none
        yearTextField.borderStyle = .none
        nameTextField.delegate = self
        majorsTextField.delegate = self
        yearTextField.delegate = self
    }
    
    @IBAction func saveDetailsButtonPressed(){
        if  nameTextField.text != "" , majorsTextField.text != "" , yearTextField.text != ""  {
            //save user details
            FirebaseCalls().saveUserDetails(name: nameTextField.text!, majors: majorsTextField.text!, year: yearTextField.text!, tutor_bool : tutor_bool, completionHandler: { (bool) in
                if bool {
                    // After data is saved segue is performed
                    self.presentMainView()
                }else {
                    self.showAlert("Some unexpected error occured!")
                }
            })
        } else {
            showAlert("Fields cannot be empty")
        }
    }
    
    func setupUserImage() {
        let userImageUrl = FIRAuth.auth()?.currentUser?.photoURL
        userPictureView.kf.setImage(with: userImageUrl)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return 175.0
        } else if indexPath.item == 9 {
            return 60.0
        }else if indexPath.item == 7 {
            return 60.0
        } else {
            return 44.0
        }
    }
    
    func presentMainView() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard: UIStoryboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainPage") as! SWRevealViewController
        delegate.window?.rootViewController = initialViewController
        delegate.window?.makeKeyAndVisible()
    }
}

extension SignUpTableViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpTableViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        userPictureView.image = image
        self.dismiss(animated: true, completion: nil)
    }
}

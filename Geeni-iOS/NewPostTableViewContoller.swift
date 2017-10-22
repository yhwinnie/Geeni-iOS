//
//  NewPostTableViewContoller.swift
//  Geeni-iOS
//
//  Created by Sahil Dhawan on 01/10/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import Firebase

class NewPostTableViewContoller: UITableViewController {
    
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var submitPostButton: UIButton!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var postImageFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var durationTextField : UITextField!
    
    var selectedImages : [UIImage] = []
    let imagePickerController = UIImagePickerController()
    let datePicker = UIDatePicker()
    var courseDict : [String : AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "New Post")
        revealSideMenu(menuButton)
        setupSubmitButton()
        tableView.tableFooterView = UIView()
        setupTextFields()
        tableView.allowsSelection = false
        imagePickerController.delegate = self
        setupDatePicker()
        setupPostImageColelctionView()
    }
    
    func setupSubmitButton() {
        submitPostButton.createSubmitButton()
        submitPostButton.center.x = self.view.center.x
    }
    
    func setupPostImageColelctionView(){
        imageCollectionView.dataSource = self
        imageCollectionView.allowsSelection = false
        let imageSize = CGSize(width: 100.0, height: 50.0)
        let spacing : CGFloat = 5.0
        postImageFlowLayout.minimumLineSpacing = spacing
        postImageFlowLayout.minimumInteritemSpacing = spacing
        postImageFlowLayout.itemSize = imageSize
    }
    
    func setupTextFields() {
        locationTextField.borderStyle = .none
        courseTextField.borderStyle = .none
        dateTextField.borderStyle = .none
        durationTextField.addDoneButton()
        durationTextField.borderStyle = .none
        durationTextField.keyboardType = .decimalPad
        durationTextField.delegate = self
        locationTextField.delegate = self
        courseTextField.delegate = self
        descriptionTextView.text = ""
        descriptionTextView.addDoneButton()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 10 || indexPath.row == 11 {
            return 70.0
        } else if indexPath.row == 7 {
            return 150
        } else {
            return 44.0
        }
    }
    
    func setupDatePicker()
    {
        datePicker.datePickerMode = .dateAndTime
        dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: UIControlEvents.valueChanged)
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDatePickerPressed))
        toolbar.items = [doneButton]
        toolbar.sizeToFit()
        dateTextField.inputAccessoryView = toolbar
    }
    
    func doneDatePickerPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy H:mm:ss a"
        let dateString = dateFormatter.string(from: datePicker.date)
        dateTextField.text = dateString
        dateTextField.resignFirstResponder()
    }
    
    func datePickerChanged(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy H:mm:ss a"
        let dateString = dateFormatter.string(from: datePicker.date)
        dateTextField.text = dateString
    }
    
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Upload Photo", message: "Please select from the following options", preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        let albumAction = UIAlertAction(title: "Photo Album", style: .default) { (action) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(albumAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func submitButtonPressed() {
        if courseTextField.text == "" || locationTextField.text == "" || dateTextField.text == "" || descriptionTextView.text == "" || durationTextField.text == "" {
            showAlert("Text Fields cannot be empty!")
        } else {
            FirebaseCalls().getUserDetails(completionHandler: { (user, bool) in
                if bool {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy H:mm:ss a"
                    let timeStamp = [".sv": "timestamp"]
                    let timeStampString = FIRServerValue.timestamp()[".sv"] as! String
                    
                    let courseName = self.courseTextField.text
                    let courseLocation = self.locationTextField.text
                    let courseDate = self.dateTextField.text
                    let courseDescription = self.descriptionTextView.text
                    let courseDuration = self.durationTextField.text
                    self.courseDict["major"] = user?.major as AnyObject
                    self.courseDict["processed"] = false as AnyObject
                    self.courseDict["user_id"] = user?._id as AnyObject
                    self.courseDict["desc"] = courseDescription as AnyObject
                    self.courseDict["location"] = courseLocation as AnyObject
                    self.courseDict["start_time"] =  dateFormatter.date(from: courseDate!)?.timeIntervalSince1970 as AnyObject
                    self.courseDict["duration"] = (courseDuration! as NSString).floatValue * 60 * 60 * 1000 as AnyObject
                    self.courseDict["timestamp"] = timeStamp as AnyObject
                    self.courseDict["username"] = user?.username as AnyObject
                    self.courseDict["user_photo_gs"] = user?.photo_gs as AnyObject
                    self.courseDict["subject"] = courseName as AnyObject
                    self.courseDict["private_sort_tag"] =  (user?._id)! + " " +  timeStampString as AnyObject
                    if self.selectedImages.count > 0 {
                        FirebaseCalls().uploadImageToFirebase(self.selectedImages.first!, completionHandler: { (imageUrlString, error) in
                            if error == nil {
                                self.courseDict["problem_photo_gs"] = imageUrlString as AnyObject
                            } else {
                                self.showAlert("Could not save course description image")
                            }
                        })
                    }
                    FirebaseCalls().createNewPost(self.courseDict, completionHandler: { (bool) in
                        if bool {
                            let alertController = UIAlertController(title: "Geeni", message: "New post created", preferredStyle: .alert)
                            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
                                DispatchQueue.main.async {
                                    self.courseTextField.text = ""
                                    self.locationTextField.text = ""
                                    self.dateTextField.text = ""
                                    self.descriptionTextView.text = ""
                                    self.durationTextField.text = ""
                                    self.selectedImages = []
                                    self.imageCollectionView.reloadData()
                                }
                            })
                            alertController.addAction(dismissAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                        } else {
                            self.showAlert("Unexpected error occured!")
                        }
                    })
                } else {
                    self.showAlert("Unexpected error occurred!")
                }
            })
        }
    }
}

extension NewPostTableViewContoller : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NewPostTableViewContoller : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        self.selectedImages.append(image!)
        imageCollectionView.reloadData()
    }
}

extension NewPostTableViewContoller : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postImage", for: indexPath) as! PostImageCollectionViewCell
        cell.postImageView.image = selectedImages[indexPath.item]
        return cell
    }
}

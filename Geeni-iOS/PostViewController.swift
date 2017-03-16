//
//  PostViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 3/16/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Add scroll view
        scrollView.frame = view.bounds
        containerView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
    }
    
    func setup() {
        self.view.backgroundColor = UIColor.white
        
        // Setup scrollview delegate
        self.scrollView = UIScrollView()
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        
        // Container view on top of scroll view
        containerView = UIView()
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
        
        // Set navigation bar title and color
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.20, green:0.60, blue:1.00, alpha:1.0)
        self.navigationController?.navigationBar.topItem?.title = "New Post"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        var yPosition: CGFloat = 10
        // course label
        let courseLabel = UILabel(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width/2, height: 50))
        courseLabel.text = "COURSE NAME"
        courseLabel.textColor = UIColor.darkGray
        containerView.addSubview(courseLabel)
        
        yPosition += courseLabel.frame.height + 2
        // course textfield
        let courseTextField = UITextField(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width - 40, height: 40))
        //courseTextField.borderStyle = UITextBorderStyle.roundedRect
        containerView.addSubview(courseTextField)
        
        
        
        yPosition += courseTextField.frame.height + 2
        // location label
        let locationLabel = UILabel(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width/2, height: 50))
        locationLabel.text = "LOCATION"
        locationLabel.textColor = UIColor.darkGray
        containerView.addSubview(locationLabel)
        
        var lineView = UIView(frame: CGRect(x: 0, y: courseTextField.frame.height, width: self.view.frame.width - 40, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        courseTextField.addSubview(lineView)
        
        yPosition += locationLabel.frame.height + 2
        // location textfield
        let locationTextField = UITextField(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width - 40, height: 40))
        containerView.addSubview(locationTextField)
        
        yPosition += locationTextField.frame.height + 2
        // date label
        let dateLabel = UILabel(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width/2, height: 50))
        dateLabel.text = "DATE AND TIME"
        dateLabel.textColor = UIColor.darkGray
        containerView.addSubview(dateLabel)
        
        lineView = UIView(frame: CGRect(x: 0, y: locationTextField.frame.height, width: self.view.frame.width - 40, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        locationTextField.addSubview(lineView)
        
        yPosition += dateLabel.frame.height + 2
        // date textfield
        let dateTextField = UITextField(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width - 40, height: 40))
        containerView.addSubview(dateTextField)
        
        lineView = UIView(frame: CGRect(x: 0, y: locationTextField.frame.height, width: self.view.frame.width - 40, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        dateTextField.addSubview(lineView)
        
        yPosition += dateTextField.frame.height + 2
        // Description Label
        let descriptionLabel = UILabel(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width/2, height: 50))
        descriptionLabel.text = "DESCRIPTION"
        descriptionLabel.textColor = UIColor.darkGray
        containerView.addSubview(descriptionLabel)
        
        yPosition += descriptionLabel.frame.height + 2
        // Description textfield 
        let descriptionTextView = UITextView(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width - 40, height: 100))
//        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
//        descriptionTextView.layer.borderWidth = 0.5
        containerView.addSubview(descriptionTextView)
        
        lineView = UIView(frame: CGRect(x: 0, y: descriptionTextView.frame.height, width: self.view.frame.width - 40, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        descriptionTextView.addSubview(lineView)
        
        yPosition += descriptionTextView.frame.height + 5
        // Camera button
        let cameraButton = UIButton(frame: CGRect(x: 300, y: yPosition, width: 50, height: 50))
        
        let cameraImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        cameraImage.image = UIImage(named: "add-photo")
        
        cameraButton.setImage(UIImage(named: "add-photo"), for: .normal)
        cameraButton.isUserInteractionEnabled = true

        
        containerView.addSubview(cameraButton)
        
        // Submit button
        yPosition += cameraButton.frame.height + 20
        let submitButton = UIButton(frame: CGRect(x: self.view.frame.width/2 - 100, y: yPosition, width: 200, height: 50))
        submitButton.setTitle("SUBMIT POST", for: .normal)
        submitButton.backgroundColor = UIColor(red:0.20, green:0.60, blue:1.00, alpha:1.0)
        
        submitButton.layer.cornerRadius = 25.0
        submitButton.isUserInteractionEnabled = true
        
        containerView.addSubview(submitButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}



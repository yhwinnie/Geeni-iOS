//
//  AddCardViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 3/18/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit


class AddCardViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var containerView = UIView()
    var cardNumberLabel: UILabel!
    var cardNumberTextField: UITextField!
    var cvvLabel: UILabel!
    var cvvTextField: UITextField!
    var dateLabel: UILabel!
    var dateTextField: UITextField!
    var zipCodeLabel: UILabel!
    var zipCodeTextField: UITextField!
    var defaultButton: UIButton!
    var defaultImage: UIImageView!
    var submitButton: UIButton!
    var paymentDefaultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "New Card")
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
        
        var yPosition: CGFloat = 10
        // course label
        cardNumberLabel = UILabel(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width/2, height: 50))
        cardNumberLabel.text = "CARD NUMBER"
        cardNumberLabel.textColor = UIColor.darkGray
        containerView.addSubview(cardNumberLabel)
        
        yPosition += cardNumberLabel.frame.height
        // course textfield
        cardNumberTextField = UITextField(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width - 60, height: 40))
        //courseTextField.borderStyle = UITextBorderStyle.roundedRect
        containerView.addSubview(cardNumberTextField)
        
        yPosition += cardNumberTextField.frame.height + 2
        // location label
        cvvLabel = UILabel(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width/2, height: 50))
        cvvLabel.text = "CVV"
        cvvLabel.textColor = UIColor.darkGray
        containerView.addSubview(cvvLabel)
        
        var lineView = UIView(frame: CGRect(x: 0, y: cardNumberTextField.frame.height, width: self.view.frame.width - 60, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        cardNumberTextField.addSubview(lineView)
        
        yPosition += cvvLabel.frame.height + 2
        // location textfield
        cvvTextField = UITextField(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width - 60, height: 40))
        containerView.addSubview(cvvTextField)
        
        yPosition += cvvTextField.frame.height + 2
        // date label
        dateLabel = UILabel(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width/2, height: 50))
        dateLabel.text = "EXPIRATION DATE"
        dateLabel.textColor = UIColor.darkGray
        containerView.addSubview(dateLabel)
        
        lineView = UIView(frame: CGRect(x: 0, y: cvvTextField.frame.height, width: cvvLabel.frame.width + 5, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        cvvTextField.addSubview(lineView)
        
        yPosition += dateLabel.frame.height + 2
        // date textfield
        dateTextField = UITextField(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width - 40, height: 40))
        containerView.addSubview(dateTextField)
        
        lineView = UIView(frame: CGRect(x: 0, y: dateTextField.frame.height, width: self.view.frame.width - 60, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        dateTextField.addSubview(lineView)
        
        yPosition += dateTextField.frame.height + 2
        // Description Label
        zipCodeLabel = UILabel(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width/2, height: 50))
        zipCodeLabel.text = "ZIP CODE"
        zipCodeLabel.textColor = UIColor.darkGray
        containerView.addSubview(zipCodeLabel)
        
        yPosition += zipCodeLabel.frame.height + 2
        // Description textfield
        zipCodeTextField = UITextField(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width - 40, height: 40))
        
        containerView.addSubview(zipCodeTextField)
        
        yPosition += zipCodeTextField.frame.height
        
        lineView = UIView(frame: CGRect(x: 20, y: yPosition, width: zipCodeLabel.frame.width + 5, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        containerView.addSubview(lineView)
        
        yPosition += 20
        // Camera button
        defaultButton = UIButton(frame: CGRect(x: 20, y: yPosition, width: 20, height: 20))
        
        defaultImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        defaultImage.image = UIImage(named: "radio-button-unchecked")
        
        defaultButton.setImage(defaultImage.image, for: .normal)
        defaultButton.isUserInteractionEnabled = true
        
        containerView.addSubview(defaultButton)
        
        paymentDefaultLabel = UILabel(frame: CGRect(x: defaultButton.frame.width + 30, y: yPosition, width: self.view.frame.width - 20, height: 20))
        paymentDefaultLabel.text = "DEFAULT PAYMENT OPTION"
        
        paymentDefaultLabel.textColor = UIColor.darkGray
        containerView.addSubview(paymentDefaultLabel)

        
        // default button
        yPosition += defaultButton.frame.height + 40
        submitButton = UIButton(frame: CGRect(x: self.view.frame.width/2 - 100, y: yPosition, width: 200, height: 50))
        submitButton.setTitle("SAVE CARD", for: .normal)
        submitButton.backgroundColor = UIColor(red:0.20, green:0.60, blue:1.00, alpha:1.0)
        
        submitButton.layer.cornerRadius = 25.0
        submitButton.isUserInteractionEnabled = true
        
        containerView.addSubview(submitButton)
        
        //yPosition += submitButton.frame.height + 20
        
        //self.scrollView.contentSize.height = yPosition + 10
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


}

//
//  AddCardViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 3/18/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import Stripe

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

    var monthArray : [String] = ["January", "February", "March", "April", "May", "June", "July", "August" , "September", "October", "November", "December"]
    var yearArray : [Int] = []
    var selectedMonth : String = "01"
    var selectedYear : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "New Card")
        setup()
        setupTextFields()
    }
    
    func setupTextFields(){
        //delegates
        cardNumberTextField.delegate = self
        cvvTextField.delegate = self
        dateTextField.delegate = self
        zipCodeTextField.delegate = self
        
        //keyboard_types
        cvvTextField.keyboardType = .numberPad
        cardNumberTextField.keyboardType = .numberPad
        dateTextField.keyboardType = .numberPad
        zipCodeTextField.keyboardType = .numberPad
        
        //done buttons
        cvvTextField.addDoneButton()
        cardNumberTextField.addDoneButton()
        dateTextField.addDoneButton()
        zipCodeTextField.addDoneButton()
        
        //secure entry in cvv
        cvvTextField.isSecureTextEntry = true
        dateTextField.inputView = setupPickerView()

    }
    
    func setupPickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        setupYearArray()
        return pickerView
    }
    
    func setupYearArray(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let startingYearString = dateFormatter.string(from: Date())
        let startingYear = Int(startingYearString)!
        let endingYear = 2100
        selectedYear = "\(startingYear)"
        for date in startingYear..<endingYear {
            yearArray.append(date)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Add scroll view
        scrollView.frame = view.bounds
        containerView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
    }
    
    func monthValue(_ monthValue : Int) -> String {
        switch(monthValue){
        case 1: return "01"
        case 2: return "02"
        case 3: return "03"
        case 4: return "04"
        case 5: return "05"
        case 6: return "06"
        case 7: return "07"
        case 8: return "08"
        case 9: return "09"
        default : return "\(monthValue)"
        }
    }
    
    func setup() {
        self.view.backgroundColor = UIColor.white
        
        // Setup scrollview delegate
        self.scrollView = UIScrollView()
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: 0)
        
        // Container view on top of scroll view
        view.addSubview(scrollView)
        
        var yPosition: CGFloat = 10
        // course label
        cardNumberLabel = UILabel(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width/2, height: 50))
        cardNumberLabel.text = "CARD NUMBER"
        cardNumberLabel.textColor = UIColor.darkGray
        scrollView.addSubview(cardNumberLabel)
        yPosition += cardNumberLabel.frame.height
        
        // card number textfield
        cardNumberTextField = UITextField(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width - 60, height: 40))
        //courseTextField.borderStyle = UITextBorderStyle.roundedRect
        scrollView.addSubview(cardNumberTextField)
        yPosition += cardNumberTextField.frame.height + 2
        
        // location label
        cvvLabel = UILabel(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width/2, height: 50))
        cvvLabel.text = "CVV"
        cvvLabel.textColor = UIColor.darkGray
        scrollView.addSubview(cvvLabel)
        
        var lineView = UIView(frame: CGRect(x: 0, y: cardNumberTextField.frame.height, width: self.view.frame.width - 60, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        cardNumberTextField.addSubview(lineView)
        
        yPosition += cvvLabel.frame.height + 2
        // location textfield
        cvvTextField = UITextField(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width - 60, height: 40))
        scrollView.addSubview(cvvTextField)
        yPosition += cvvTextField.frame.height + 2
        
        // date label
        dateLabel = UILabel(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width/2, height: 50))
        dateLabel.text = "EXPIRATION DATE"
        dateLabel.textColor = UIColor.darkGray
        scrollView.addSubview(dateLabel)
        
        lineView = UIView(frame: CGRect(x: 0, y: cvvTextField.frame.height, width: cvvLabel.frame.width + 5, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        cvvTextField.addSubview(lineView)
        yPosition += dateLabel.frame.height + 2
        
        // date textfield
        dateTextField = UITextField(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width - 40, height: 40))
        scrollView.addSubview(dateTextField)
        
        lineView = UIView(frame: CGRect(x: 0, y: dateTextField.frame.height, width: self.view.frame.width - 60, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        dateTextField.addSubview(lineView)
        yPosition += dateTextField.frame.height + 2
        
        // zip code Label
        zipCodeLabel = UILabel(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width/2, height: 50))
        zipCodeLabel.text = "ZIP CODE"
        zipCodeLabel.textColor = UIColor.darkGray
        scrollView.addSubview(zipCodeLabel)
        yPosition += zipCodeLabel.frame.height + 2
        
        // zip code textfield
        zipCodeTextField = UITextField(frame: CGRect(x: 20, y: yPosition, width: self.view.frame.width - 40, height: 40))
        scrollView.addSubview(zipCodeTextField)
        yPosition += zipCodeTextField.frame.height
        
        lineView = UIView(frame: CGRect(x: 20, y: yPosition, width: zipCodeLabel.frame.width + 5, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        scrollView.addSubview(lineView)
        yPosition += 20
        
        // Camera button
        defaultButton = UIButton(frame: CGRect(x: 20, y: yPosition, width: 20, height: 20))
        
        defaultImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        defaultImage.image = UIImage(named: "radio-button-unchecked")
        
        defaultButton.setImage(defaultImage.image, for: .normal)
        defaultButton.isUserInteractionEnabled = true
        
//      scrollView.addSubview(defaultButton)
        
        paymentDefaultLabel = UILabel(frame: CGRect(x: defaultButton.frame.width + 30, y: yPosition, width: self.view.frame.width - 20, height: 20))
        paymentDefaultLabel.text = "DEFAULT PAYMENT OPTION"
        
        paymentDefaultLabel.textColor = UIColor.darkGray
//        scrollView.addSubview(paymentDefaultLabel)
        
        // default button
//        yPosition += defaultButton.frame.height + 40
        submitButton = UIButton(frame: CGRect(x: self.view.frame.width/2 - 100, y: yPosition, width: 200, height: 50))
        
        //submit button
        submitButton.setTitle("SAVE CARD", for: .normal)
        submitButton.backgroundColor = UIColor(red:0.20, green:0.60, blue:1.00, alpha:1.0)
        submitButton.addTarget(self, action: #selector(saveCardButtonPressed), for: .touchUpInside)
        submitButton.layer.cornerRadius = 25.0
        submitButton.isUserInteractionEnabled = true
        scrollView.addSubview(submitButton)
        
        scrollView.contentSize.height = yPosition + 60.0
    }
    
    func saveCardButtonPressed(){
        
        if cardNumberTextField.text == "" || cvvTextField.text == "" || dateTextField.text == "" || zipCodeTextField.text == "" {
            showAlert("Text Fields cannot be empty")
        } else {
            let cardNumber = cardNumberTextField.text
            let cvv = cvvTextField.text
            let zipCode = zipCodeTextField.text
            
            let dateString = dateTextField.text!
            let dateStringArray = dateString.components(separatedBy: "/")
            
            //adding card to stripe
            let stripeCardParams = STPCardParams()
            stripeCardParams.name = UserDetails.user?.username!
            stripeCardParams.cvc = cvv
            stripeCardParams.number = cardNumber
            stripeCardParams.expMonth = UInt(Int(dateStringArray[0])!)
            stripeCardParams.expYear = UInt(Int(dateStringArray[1])!)
            stripeCardParams.currency = "USD"
            //setting address
            let stripeAddress = STPAddress()
            stripeAddress.postalCode = zipCode
            
            stripeCardParams.address = stripeAddress
            
            STPAPIClient.shared().createToken(withCard: stripeCardParams, completion: { (token, error) in
                if let stripe_token = token {
                    //send stripe token to backend
                    ServerCalls().addNewCard(stripe_token, completionHandler: { (bool, errorMessage) in
                        if bool {
                            let alertController = UIAlertController(title: "Geeni", message: "Card added successfully", preferredStyle: .alert)
                            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
                                self.cardNumberTextField.text = ""
                                self.cvvTextField.text = ""
                                self.dateTextField.text = ""
                                self.zipCodeTextField.text = ""
                            })
                            alertController.addAction(dismissAction)
                            self.present(alertController, animated: true, completion: nil)
                        } else {
                            self.showAlert(errorMessage!)
                        }
                    })
                } else {
                    self.showAlert((error?.localizedDescription)!)
                }
            })
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddCardViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength : Int
        if textField == cvvTextField {
            maxLength = 3
            let currentString : NSString = textField.text! as NSString
            let newString : NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        } else if textField == cardNumberTextField {
            maxLength = 16
            let currentString : NSString = textField.text! as NSString
            let newString : NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        } else {
            return true
        }
        
    }
}

extension AddCardViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return monthArray.count
        } else {
            return yearArray.count
        }
    }
}

extension AddCardViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return monthArray[row]
        } else {
            return "\(yearArray[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedMonth = monthValue(row + 1)
        } else {
            selectedYear = "\(yearArray[row])"
        }
        dateTextField.text = selectedMonth + "/" + selectedYear
    }
}

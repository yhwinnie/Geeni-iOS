//
//  TimerViewController.swift
//  Geeni-iOS
//
//  Created by Winnie Wen on 4/2/17.
//  Copyright © 2017 wiwen. All rights reserved.
//

import UIKit
import CLTimer


class TimerViewController: UIViewController {
    
    @IBOutlet weak var timer: CLTimer!
    @IBOutlet weak var stopButton : UIButton!
    @IBOutlet weak var sessionLabel : UILabel!
    @IBOutlet weak var cancelButton : UIButton!
    @IBOutlet weak var retryButton : UIButton!
    
    var previousMinute : Int = 0
    var currentSession : Session?
    var sessionDuration : Double = 0
    var isTutor : Bool = false
    var currentTime : Int = 0
    var stopButtonPressed : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Current Session")
        setupButtons()
        setupTimer()
        timer.cltimer_delegate = self
        timer.startTimer(withSeconds: 0, format:.Minutes , mode: .Forward)

    }
    
    @IBAction func retryButtonTapped(){
        ServerCalls().retryPayment((currentSession?._id)!) { (message) in
            self.showAlert("message")
        }
    }
    
    func setupButtons(){
        cancelButton.backgroundColor = colors.blueColor
        cancelButton.setTitleColor(colors.whiteColor, for: .normal)
        stopButton.backgroundColor = colors.blueColor
        stopButton.setTitleColor(colors.whiteColor, for: .normal)
        retryButton.backgroundColor = colors.blueColor
        retryButton.setTitleColor(colors.whiteColor, for: .normal)
        cancelButton.clipsToBounds = true
        stopButton.clipsToBounds = true
        retryButton.clipsToBounds = true
        cancelButton.layer.cornerRadius = 20.0
        retryButton.layer.cornerRadius = 20.0
        stopButton.layer.cornerRadius = 20.0
        
        if UserDetails.user?.tutor_bool == false {
            cancelButton.isEnabled = true
            stopButton.isHidden = false
            retryButton.isEnabled = true
            stopButton.alpha = 0.5
        } else {
            stopButton.isEnabled = true
            retryButton.isHidden = true
            cancelButton.isEnabled = false
            cancelButton.alpha = 0.5
        }
    }
    
    func setupTimer(){
        timer.backgroundColor = colors.blueColor
        timer.tintColor = colors.whiteColor
        timer.clipsToBounds = true
        timer.layer.cornerRadius = timer.frame.width/2
    }
    
    @IBAction func stopTimer(_ sender: Any) {
        stopButtonPressed = true
        timer.stopTimer()
        ServerCalls().endSession(currentSession!,currentTime ) { (message) in
            if message == 1 {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.showAlert("Payment Failed")
            }
            self.stopButtonPressed = false
        }
    }

    @IBAction func cancelButtonPressed(_ sender : Any) {
        
        ServerCalls().cancelSession(sessionId: (currentSession?._id)!) { (message) in
            self.timer.stopTimer()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func hideCancelButton(_ bool : Bool){
        cancelButton.isHidden = bool
        cancelButton.isUserInteractionEnabled = !bool
    }
    
    func setupCancelButton(){
        cancelButton.setTitle("CANCEL", for: .normal)
        cancelButton.setTitleColor(colors.whiteColor, for: .normal)
        cancelButton.backgroundColor = colors.redColor
        cancelButton.createSubmitButton()
    }
}

extension TimerViewController : cltimerDelegate {
    
    func timerDidUpdate(time: Int) {
        
        currentTime  = time
        let minute = time / 60
        if time < Int(sessionDuration * 60) {
            // cancel button should be available only for 10 minutes
            if minute < 10 {
                hideCancelButton(false)
            } else {
                hideCancelButton((true))
            }
            
            if minute > previousMinute {
                previousMinute = minute
                let cost : CGFloat = CGFloat(previousMinute) * (18.4/60.0)
                sessionLabel.text = "Session Cost : " + "$" + String(format : "%.2f" , cost)
            }
        } else {
            if isTutor {
                //close button should pop up
            } else {
                timer.stopTimer()
            }
        }
    }
    
    func timerDidStop(time: Int) {
        if !stopButtonPressed {
            ServerCalls().endSession(currentSession!, currentTime) { (message) in
                if message == 1 {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showAlert("Payment Failed")
                }
            }
        }
    }
}



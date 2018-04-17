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
    
    var previousMinute : Int = 0
    var currentSession : Session?
    var sessionDuration : Double = 0
    var isTutor : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Current Session")
        setupButtons()
        setupTimer()
        timer.cltimer_delegate = self
        timer.startTimer(withSeconds: 0, format:.Minutes , mode: .Forward)

    }
    
    func setupButtons(){
        cancelButton.backgroundColor = colors.blueColor
        cancelButton.setTitleColor(colors.whiteColor, for: .normal)
        stopButton.backgroundColor = colors.blueColor
        stopButton.setTitleColor(colors.whiteColor, for: .normal)
        cancelButton.clipsToBounds = true
        stopButton.clipsToBounds = true
        cancelButton.layer.cornerRadius = 20.0
        stopButton.layer.cornerRadius = 20.0
        
        if UserDetails.user?.tutor_bool == false {
            cancelButton.isEnabled = true
            stopButton.isEnabled = false
            stopButton.alpha = 0.5
        } else {
            stopButton.isEnabled = true
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
        timer.stopTimer()
        timer.resetTimer()
    }
    
    
    
    @IBAction func cancelButtonPressed(_ sender : Any) {
        //cancel session
        //change the user for session cancelation i.e. $4
        //todo
        
        ServerCalls().cancelSession(sessionId: (currentSession?._id)!) { (message) in
            self.showAlert(message)
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
        let cost : CGFloat = CGFloat(time/3600) * 18.4
        sessionLabel.text = "Session Cost : " + "$" + String(format : "%.2f" , cost)

        self.showAlert("Session Ended")
    }
}



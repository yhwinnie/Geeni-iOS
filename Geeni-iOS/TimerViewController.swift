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
    @IBOutlet weak var startButton : UIButton!
    @IBOutlet weak var stopButton : UIButton!
    @IBOutlet weak var sessionLabel : UILabel!
    
    var previousMinute : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Current Session")
        setupButtons()
        setupTimer()
        timer.cltimer_delegate = self
    }
    
    func setupButtons(){
        startButton.backgroundColor = colors.blueColor
        startButton.setTitleColor(colors.whiteColor, for: .normal)
        stopButton.backgroundColor = colors.blueColor
        stopButton.setTitleColor(colors.whiteColor, for: .normal)
        startButton.clipsToBounds = true
        stopButton.clipsToBounds = true
        startButton.layer.cornerRadius = 20.0
        stopButton.layer.cornerRadius = 20.0
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
    
    @IBAction func startTimer(_ sender: Any) {
        timer.startTimer(withSeconds: 0, format:.Minutes , mode: .Forward)
    }
}

extension TimerViewController : cltimerDelegate {
    
    func timerDidUpdate(time: Int) {
        let minute = time / 60
        if minute > previousMinute {
            previousMinute = minute
            let cost : CGFloat = CGFloat(previousMinute) * (17.0/60.0)
            sessionLabel.text = "Session Cost : " + String(format : "%.2f" , cost) + "$"
        }
    }
}



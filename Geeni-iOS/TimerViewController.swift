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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Timer")
    }

    func resetTimer() {
        timer.resetTimer()

    }
    
    @IBAction func stopTimer(_ sender: Any) {
        timer.stopTimer()

    }
    @IBAction func startTimer(_ sender: Any) {
        timer.startTimer(withSeconds: 3600, format:.Minutes , mode: .Reverse)

    }
}

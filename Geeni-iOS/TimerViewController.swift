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

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

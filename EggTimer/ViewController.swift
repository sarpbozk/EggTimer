//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer!
    var remainingTime = 0
    var timer = Timer()
    let eggTimes: [String: Int] = ["Soft": 5, "Medium": 8, "Hard": 12]
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
     }
    func hardnessSelected(_ hardness: String) {
        progressView.progress = 0.0
        titleLabel.text = hardness
        if let time = eggTimes[hardness] {
            remainingTime = time
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        } else {
            print("unknown hardness parameter")
        }
    }
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func hardnessClicked(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle ?? ""
        sender.alpha = 0.5
        hardnessSelected(hardness)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
        
    }
    
    @objc func fireTimer (_ seconds: Int) {
        if remainingTime > 0 {
            progressView.progress = 1.0 / Float(remainingTime)
            remainingTime -= 1

        } else {
            titleLabel.text = "DONE!"
            playSound()
            timer.invalidate()
        }
    }
}

//
//  PlaySoundViewController.swift
//  pitch perfect
//
//  Created by mac pro on 14/07/1440 AH.
//  Copyright © 1440 mac pro. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundViewController: UIViewController {
    
    @IBOutlet weak var slowButtun: UIButton!
    @IBOutlet weak var fastButtun: UIButton!
    @IBOutlet weak var highPitchButtun: UIButton!
    @IBOutlet weak var lowPitchButtun: UIButton!
    @IBOutlet weak var echoButtun: UIButton!
    @IBOutlet weak var erverbButtun: UIButton!
    @IBOutlet weak var stopButtun: UIButton!
    
    var RecordAudioUrl :URL!
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    // MARK: play sound function
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    // MARK: press stop function Function

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
stopAudio()
}
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
}

//  RecordSoundViewController.swift
//  pitch perfect

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate{
    
    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButtun: UIButton!
    @IBOutlet weak var recordingButtun: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButtun.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    // MARK: recording Function
    @IBAction func recording(_ sender: Any) {
        stopButtun.isEnabled = true
        recordingButtun.isEnabled = false
        recordingLabel.text = "recording in progress"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    // MARK: stop recording Function
    @IBAction func sropRecording(_ sender: Any) {
        recordingButtun.isEnabled = true
        stopButtun.isEnabled = false
        recordingLabel.text = "Tap to record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    // MARK: save the recorded audio and send it as url
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
    print("recording was not successfully ")
    }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let PlaySoundsVC = segue.destination as! PlaySoundViewController
            let recordedAudioURL = sender as! URL
            PlaySoundsVC.RecordAudioUrl = recordedAudioURL

        }
    }
}


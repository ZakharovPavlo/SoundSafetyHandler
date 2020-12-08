//
//  ViewController.swift
//  SoundNotficationHandler
//
//  Created by Pavlo Zakharov on 12/6/20.
//

import UIKit
import MediaPlayer
import AVKit

class BlankViewController: AVPlayerViewController {

    // MARK: Lifecycle
    
    var threshold: Float = 1.0
    
    var volumeView: MPVolumeView!

    override func viewDidLoad () {
        super.viewDidLoad ()
        let path = Bundle.main.path(forResource: "Placeholder", ofType: "MOV")!
        let url = URL(fileURLWithPath: path)
        self.player = AVPlayer(url: url)
        volumeView = MPVolumeView (frame: CGRect.zero)
        self.view.addSubview (volumeView)
        NotificationCenter.default.addObserver (self, selector: #selector (BlankViewController.volumeChanged (notification :)), name:
            NSNotification.Name ("AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
    }
    
    @objc func volumeChanged (notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let volumeChangeType = userInfo ["AVSystemController_AudioVolumeChangeReasonNotificationParameter"] as? String {
                if volumeChangeType == "ExplicitVolumeChange" {
                    MPVolumeView.setVolume(threshold)
                }
            }
        }
    }
}

//Update system volume
extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}


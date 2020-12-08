//
//  VolumeSelectionViewController.swift
//  SoundNotficationHandler
//
//  Created by Pavlo Zakharov on 12/8/20.
//

import UIKit

class VolumeSelectionViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? BlankViewController {
            dest.threshold = slider.value
        }
    }
}

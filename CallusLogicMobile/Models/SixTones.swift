//
//  SixTones.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 2/11/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import UIKit
import AudioKit

class SixTones {
    
    var arrayOfOscillators = [AKOscillator]()
    
    let arrayOfNoteFrequencies = NoteFrequencies().arrayOfNoteFrequencies
    let arrayOfNoteAmplitudes = NoteFrequencies().arrayOfAmplitudes
    
    init() {
            createArrayOfOscillators()
        
    }
    
    // Create 1 oscillator for each string.
    func createArrayOfOscillators() {
        for _ in 0...5 {
            let os = AKOscillator()
            os.amplitude = 0
            //os.frequency = 660 + index * 40
            os.start()
            arrayOfOscillators.append(os)
        }
    }
    
    func rampUpStart(_ index: Int, zeroTo36Number: Int) {
        let os = arrayOfOscillators[index]
        os.rampTime = 0.02
        os.frequency = arrayOfNoteFrequencies[zeroTo36Number]
        os.amplitude = arrayOfNoteAmplitudes[zeroTo36Number]
       
        
    }
    
    func rampDownStop(_ stringIndex: Int) {
        let os = arrayOfOscillators[stringIndex]
        os.rampTime = 0.8
        os.amplitude = 0
    }
    
    
}
 

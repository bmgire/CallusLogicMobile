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
    
    let square = AKTable(.square, count: 256)
    // Other default AKTable values that could be used but don't sound as good. 
    // let sine = AKTable(.sine, count: 256)
    // let sawtooth = AKTable(.sawtooth, count: 256)
    
    var arrayOfOscillators = [AKOscillator]()
    
    let arrayOfNoteFrequencies = NoteFrequencies().arrayOfNoteFrequencies
    let arrayOfNoteAmplitudes = NoteFrequencies().arrayOfAmplitudes
    
    var allowsRampUp = true
    
    init() {
            createArrayOfOscillators()
        
    }
    
    // Create 1 oscillator for each string.
    func createArrayOfOscillators() {
        for _ in 0...5 {
            let os = AKOscillator(waveform: square)
            os.amplitude = 0
            //os.frequency = 660 + index * 40
            os.start()
            arrayOfOscillators.append(os)
        }
    }
    
    func rampUpStart(_ index: Int, zeroTo36Number: Int) {
        if allowsRampUp {
            let os = arrayOfOscillators[index]
            os.rampTime = 0.01
            os.frequency = arrayOfNoteFrequencies[zeroTo36Number]
            os.amplitude = arrayOfNoteAmplitudes[zeroTo36Number]
        }
        
        
    }
    
    func rampDownStop(_ stringIndex: Int) {
        let os = arrayOfOscillators[stringIndex]
        os.rampTime = 0.8
        os.amplitude = 0
        
    }
    
    func stopPlayingAllNotes() {
        for os in arrayOfOscillators {
            allowsRampUp = false
            os.amplitude = 0
            os.stop()
            
        }
    }
    
    func startPlayingAllNotes() {
        for os in arrayOfOscillators {
            allowsRampUp = true
            os.amplitude = 0
            os.start()
            
        }
    }
    
    func limitedDurationPlay(_ index: Int, zeroTo36Number: Int) {
        if allowsRampUp {
            let os = arrayOfOscillators[index]
            os.rampTime = 0.01
            os.frequency = arrayOfNoteFrequencies[zeroTo36Number]
            
            let amplitude = arrayOfNoteAmplitudes[zeroTo36Number]
            os.amplitude = amplitude * 0.5
            
            // wait 2 seconds to rampDown the notes.
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
                self.rampDownStop(index)
            })
            
        }
    }
    
}
 

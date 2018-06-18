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
        for index in 0...95 {
            //let os = AKOscillator()
            let os = AKOscillator(waveform: square)
            os.amplitude = 0
            var offset = 0
                 if index < 16 { offset = 0}
            else if index < 32 && index > 15 {offset = -11}
            else if index < 48 && index > 31 {offset = -22}
            else if index < 64 && index > 47 {offset = -33}
            else if index < 80 && index > 63 {offset = -45}
            else {offset = -56}
            
            // Set frequency:
            os.frequency = arrayOfNoteFrequencies[index + offset]
         
            arrayOfOscillators.append(os)
            
        }
    }
    
    
    func rampUpStart(_ stringIndex: Int, zeroTo36Number: Int, viewNumber: Int) {
       // print(#function)
        
        if allowsRampUp {
            
            let os = arrayOfOscillators[viewNumber]
            os.stop()
            os.rampDuration = 0
            os.amplitude = 0
            //os.stop()
            os.start()
            
            
           // if arrayOfNoteRampups[stringIndex] == true
            
            //os.frequency = arrayOfNoteFrequencies[zeroTo36Number]
            os.amplitude = arrayOfNoteAmplitudes[zeroTo36Number]
            
        }
    }
    
    func rampDownStop(_ stringIndex: Int, zeroTo36Number: Int,viewNumber: Int) {
        // print(#function)
        let os = arrayOfOscillators[viewNumber]
        
        //let freqToStop = arrayOfNoteFrequencies[zeroTo36Number]
        
          //  if os.frequency == freqToStop {
                os.rampDuration = 0.5
                os.amplitude = 0
            //}

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
            os.rampDuration = 0
            
            // All os's are being started in function call appDidBecomeActive.
            // This is to help stop then restart the notes when the app becomes inactive.
            // Preventing notes from gettings stuck playing.
            //os.start()
            
        }
    }
    
    func limitedDurationPlay(_ stringIndex: Int, zeroTo36Number: Int, viewNumber: Int) {
        if allowsRampUp {
            let os = arrayOfOscillators[viewNumber]
            os.stop()
            os.rampDuration =  0.005
            os.start()
            
            let amplitude = arrayOfNoteAmplitudes[zeroTo36Number]
            os.amplitude = amplitude * 0.54
         //   os.frequency = arrayOfNoteFrequencies[zeroTo36Number]
            
            // wait 2 seconds to rampDown the notes.
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
                self.rampDownStop(stringIndex, zeroTo36Number: zeroTo36Number, viewNumber: viewNumber)
            })
            
        }
    }
    
}
 

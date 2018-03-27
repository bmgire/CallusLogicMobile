//
//  ChordCreator.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 3/26/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import Foundation

class ChordCreator {
    let toneArraysCreator = ToneArraysCreator()
    let fretboardModel = FretboardModel()
    let chordFormulas = ChordFormulas()
    
    let major = "Major Arpeggio"
    let minor = "Minor Arpeggio"
    let dominant_7th = "Dominant 7th Arpeggio"
    
    func buildChord(root: String, accidental: String, chord: String) {
        var arpeggio = ""
        
        // Determine the correct arrpegio to build the scale from
        // Minor, Major, or Dominant 7th Arpeggio
        switch chord {
        case "Major Chord":
            arpeggio = major
        case "Minor Chord (I)":
            arpeggio = minor
        case "Dominant 7th Chord":
            arpeggio = dominant_7th
        default:
            arpeggio = "Major"
            print("Error in \(#function): chord type has no associated shape.")
        }
        
        // Build the scale in the toneArraysCreator.
        toneArraysCreator.updateWithValues(root, accidental: accidental, scaleName: arpeggio)
        
        // Load the scale into the fretboard
        fretboardModel.loadNewNotesNumbersAndIntervals(toneArraysCreator.getArrayOfToneArrays())
        
        // Obtain chordShape from ChordFormulas
        // For now, just use minor since that's all we have.
        
        let formula = chordFormulas.dictOfChordNamesAndFormulas["Minor Chord (I)"]

        // remove all notes but the chord.
        fretboardModel.removeNotesNotInChord(chordFormula: formula!)

    }
}

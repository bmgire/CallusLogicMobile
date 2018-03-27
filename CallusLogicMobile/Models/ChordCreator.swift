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
    
    func buildChord(root: String, accidental: String, chord: String) {
        
        // Find the correct arpeggio
        if let arpeggio = chordFormulas.dictOfChordNamesAndShapes[chord]?.arpeggioToBuildChordFrom {
            
            // create tone arrays of arpeggio
            toneArraysCreator.updateWithValues(root, accidental: accidental, scaleName: arpeggio)
            
            // Load the arpeggio into the fretboard
            fretboardModel.loadNewNotesNumbersAndIntervals(toneArraysCreator.getArrayOfToneArrays())
            
            // Obtain chordShape from ChordFormulas
            // For now, just use minor since that's all we have.
            let formula = chordFormulas.dictOfChordNamesAndShapes[chord]
            
            // remove all notes but the chord.
            fretboardModel.removeNotesNotInChord(chordFormula: formula!.arrayOfIntervals)
            // Otherwise the arpeggio was not found.
            // Print an error statement.
        }   else {
                print("Error in \(#function): arpeggio not found in chordFormulas.dictOfChordNamesAndShapes")
        }
        
    }
}

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
      
        // Combine root and accidental
        var fullRoot = root
        if accidental != "Natural" {
            fullRoot.append(accidental)
        }
        
        // Attempt to get the chord shape model from the dictionary
        if let chordShapeModel = chordFormulas.dictOfChordNamesAndShapes[chord] {
            
            let arpeggio = chordShapeModel.arpeggioToBuildChordFrom
            
            if arpeggio == "" {
                print("Error in \(#function): no arpeggio string found in ChordShapeModel")
            }
            
            // create tone arrays of arpeggio
            toneArraysCreator.updateWithValues(root, accidental: accidental, scaleName: arpeggio)
            
            // Load the arpeggio into the fretboard
            fretboardModel.loadNewNotesNumbersAndIntervals(toneArraysCreator.getArrayOfToneArrays())
            
            // Obtain chordShape from ChordFormulas
            var altChordShapeName = ""
            
            if chordShapeModel.arrayOfInvalidRootNotes.contains(fullRoot) {
                altChordShapeName = chordShapeModel.alternateChordShapeName
                
            }
            
            var formula = [String]()
            
            // If there is an altChordShapeName, get its formula.
            if altChordShapeName != "" {
                formula = (chordFormulas.dictOfChordNamesAndShapes[altChordShapeName]?.arrayOfIntervals)!
                // Otherwise get the normal formula
            }   else {
                formula = (chordFormulas.dictOfChordNamesAndShapes[chord]?.arrayOfIntervals)!
            }
            
            // remove all notes but the chord.
            fretboardModel.removeNotesNotInChord(chordFormula: formula)
            
            // Otherwise the chordShapeModel was not found.
            // Print an error statement.
        }   else {
            print("Error in \(#function): chordShapeModel not found in chordFormulas.dictOfChordNamesAndShapes[chord]")
        }
    }
}

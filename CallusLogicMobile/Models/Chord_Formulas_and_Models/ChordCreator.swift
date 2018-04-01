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
    let basicChordFormulas = BasicChordFormulas()
    
    func buildChord(root: String, accidental: String, chord: String, isBasicChord: Bool) {
        
        var formula = [String]()
        var fingerings = [String]()
        var scaleToBuildFrom = ""
        
        // Combine root and accidental
        var fullRoot = root
        if accidental != "Natural" {
            fullRoot.append(accidental)
        }
        
        if isBasicChord {
            let chordModel = basicChordFormulas.dictOfBasicChordNamesAndShapes[chord]
            formula = (chordModel?.shapeModel.arrayOfIntervals)!
            fingerings = (chordModel?.shapeModel.arrayOfFingers)!
            scaleToBuildFrom = (chordModel?.shapeModel.arpeggioToBuildChordFrom)!
                
                
                //toneArraysCreator.updateWithValues(fullRoot, accidental: "Natural", scaleName: arpeggio)
        }
            
        else {
            
            
            // Attempt to get the chord shape model from the dictionary
            if let chordShapeModel = chordFormulas.dictOfChordNamesAndShapes[chord] {
                
                scaleToBuildFrom = chordShapeModel.arpeggioToBuildChordFrom
                
                if scaleToBuildFrom == "" {
                    print("Error in \(#function): no arpeggio string found in ChordShapeModel")
                }
                
                // create tone arrays of arpeggio
                //toneArraysCreator.updateWithValues(root, accidental: accidental, scaleName: arpeggio)
                
                // Load the arpeggio into the fretboard
                //fretboardModel.loadNewNotesNumbersAndIntervals(toneArraysCreator.getArrayOfToneArrays())
                
                // ################################################
                // Check if an alternate chordShape is needed.
                var altChordShapeName = ""
                
                if chordShapeModel.arrayOfInvalidRootNotes.contains(fullRoot) {
                    altChordShapeName = chordShapeModel.alternateChordShapeName
                }
                
                // If there is an alternate chord shape, load those settings.
                if altChordShapeName != "" {
                    formula = (chordFormulas.dictOfChordNamesAndShapes[altChordShapeName]?.arrayOfIntervals)!
                    fingerings = (chordFormulas.dictOfChordNamesAndShapes[altChordShapeName]?.arrayOfFingers)!
                    // Otherwise get the normal formula
                }
                // Otherwise, no alternate chordShape is needed. use the regular one.
                else {
                    formula = (chordFormulas.dictOfChordNamesAndShapes[chord]?.arrayOfIntervals)!
                    fingerings = (chordFormulas.dictOfChordNamesAndShapes[chord]?.arrayOfFingers)!
                }
                
                
                // Otherwise the chordShapeModel was not found.
                // Print an error statement.
            }   else {
                print("Error in \(#function): chordShapeModel not found in chordFormulas.dictOfChordNamesAndShapes[chord]")
            }
        }
        
        toneArraysCreator.updateWithValues(fullRoot, accidental: "Natural", scaleName: scaleToBuildFrom)
        fretboardModel.loadNewNotesNumbersAndIntervals(toneArraysCreator.getArrayOfToneArrays())
        
        // remove all notes but the chord.
        fretboardModel.removeNotesNotInChord(chordFormula: formula, chordFingering: fingerings)
    }
}

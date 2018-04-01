//
//  ChordFormulas.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 3/23/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import Foundation


class ChordFormulas {
    
    var arrayOfShapeNames = [String]()
    var dictOfChordNamesAndShapes = [ String : ChordShapeModel]()
    
    init() {
       

        
       
        //################################################
        // Major Chords.
        
        createChordShapeModel(shapeName: "Major Chord (v1)",
                              arrayOfIntervals: ["root", "P5", "root", "M3", "P5", "root"],
                              arrayOfFingerings: ["I", "R", "P", "M", "I", "I"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "Major Chord (v2)",
                              arpeggioToBuildChordFrom: "Major Arpeggio")
        
        createChordShapeModel(shapeName: "Major Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "root", "M3", ""],
                              arrayOfFingerings: ["", "I", "R", "R", "R", ""],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "Major Chord (v1)",
                              arpeggioToBuildChordFrom: "Major Arpeggio")
        
        createChordShapeModel(shapeName: "Major Chord (v3)",
                              arrayOfIntervals: ["", "root", "M3", "P5", "root", "M3"],
                              arrayOfFingerings: ["", "P", "R", "I", "M", "I"],
                              arrayOfInvalidRootNotes: ["A#", "Bb", "B", "Cb"],
                              alternateChordShapeName: "Major Chord (v2)",
                              arpeggioToBuildChordFrom: "Major Arpeggio")
        
        createChordShapeModel(shapeName: "Major Chord (v4)",
                              arrayOfIntervals: ["", "", "root", "P5", "root", "M3"],
                              arrayOfFingerings: ["", "", "I", "M", "P", "R"],
                              arrayOfInvalidRootNotes: ["B#", "C", "C#", "Db"],
                              alternateChordShapeName: "Major Chord (v3)",
                              arpeggioToBuildChordFrom: "Major Arpeggio")
        
        
        //################################################
        // Minor Chords.
        createChordShapeModel(shapeName: "Minor Chord (v1)",
                              arrayOfIntervals: ["root", "P5", "root", "m3", "P5", "root"],
                              arrayOfFingerings: ["I", "R", "P", "I", "I", "I"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "Minor Chord (v2)",
                              arpeggioToBuildChordFrom: "Minor Arpeggio")
        
        createChordShapeModel(shapeName: "Minor Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "root", "m3", "P5"],
                              arrayOfFingerings: ["", "I", "R", "P", "M", "I"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "Minor Chord (v1)",
                              arpeggioToBuildChordFrom: "Minor Arpeggio")
        
        createChordShapeModel(shapeName: "Minor Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "P5", "root", "m3"],
                              arrayOfFingerings: ["", "", "I", "R", "P", "M"],
                              arrayOfInvalidRootNotes: ["C", "C#", "Db"],
                              alternateChordShapeName: "Minor Chord (v2)",
                              arpeggioToBuildChordFrom: "Minor Arpeggio")
        
        
        //################################################
        // 6 Chords.
        
        createChordShapeModel(shapeName: "6 Chord (v1)",
                              arrayOfIntervals: ["root", "", "M6", "M3", "P5", ""],
                              arrayOfFingerings: ["M", "", "I", "P", "R", ""],
                              arrayOfInvalidRootNotes: ["E", "Fb"],
                              alternateChordShapeName: "6 Chord (v2)",
                              arpeggioToBuildChordFrom: "6 Arpeggio")
        
        createChordShapeModel(shapeName: "6 Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "root", "M3", "M6"],
                              arrayOfFingerings: ["", "I", "R", "R", "R", "R"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "6 Chord (v3)",
                              arpeggioToBuildChordFrom: "6 Arpeggio")
        
        createChordShapeModel(shapeName: "6 Chord (v3)",
                              arrayOfIntervals: ["", "P5", "root", "M3", "M6", ""],
                              arrayOfFingerings: ["", "M", "R", "I", "P", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "6 Arpeggio")
        
        //################################################
        // m6 Chords.
        
        createChordShapeModel(shapeName: "m6 Chord (v1)",
                              arrayOfIntervals: ["root", "", "M6", "m3", "P5", ""],
                              arrayOfFingerings: ["M", "", "I", "R", "P", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m6 Arpeggio")
        
        createChordShapeModel(shapeName: "m6 Chord (v2)",
                              arrayOfIntervals: ["", "root", "", "M6", "m3", "P5"],
                              arrayOfFingerings: ["", "M", "", "I", "P", "R"],
                              arrayOfInvalidRootNotes: ["A"],
                              alternateChordShapeName: "m6 Chord (v3)",
                              arpeggioToBuildChordFrom: "m6 Arpeggio")
        
        createChordShapeModel(shapeName: "m6 Chord (v3)",
                              arrayOfIntervals: ["", "", "P5", "root", "m3", "M6"],
                              arrayOfFingerings: ["", "", "M", "R", "I", "P"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m6 Arpeggio")
        
        createChordShapeModel(shapeName: "m6 Chord (v4)",
                              arrayOfIntervals: ["", "", "M6", "m3", "P5", "root"],
                              arrayOfFingerings: ["", "", "I", "M", "M", "M"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m6 Arpeggio")
        
        
        //################################################
        // Dominant 7th Chords.
        
        createChordShapeModel(shapeName: "7 Chord (v1)",
                              arrayOfIntervals: ["root", "P5", "m7", "M3", "P5", "root"],
                              arrayOfFingerings: ["I", "R", "I", "M", "I", "I"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "7 Chord (v2)",
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        
        createChordShapeModel(shapeName: "7 Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "m7", "M3", "P5"],
                              arrayOfFingerings: ["", "I", "R", "I", "P", "I"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "7 Chord (v3)",
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        
        createChordShapeModel(shapeName: "7 Chord (v3)",
                              arrayOfIntervals: ["", "root", "M3", "m7", "root", ""],
                              arrayOfFingerings: [ "", "R", "M", "P", "I", ""],
                              arrayOfInvalidRootNotes: [ "A#", "Bb"],
                              alternateChordShapeName: "7 Chord (v2)",
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        
        createChordShapeModel(shapeName: "7 Chord (v4)",
                              arrayOfIntervals: ["", "", "root", "P5", "m7", "M3"],
                              arrayOfFingerings: ["", "", "I", "R", "M", "P"],
                              arrayOfInvalidRootNotes: ["C#", "Db"],
                              alternateChordShapeName: "7 Chord (v2)",
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        createChordShapeModel(shapeName: "7 Chord (v5)",
                              arrayOfIntervals: ["", "", "", "root", "M3", "m7"],
                              arrayOfFingerings: ["", "", "", "I", "I", "M"],
                              arrayOfInvalidRootNotes: ["NA"],   // no invalid values
                              alternateChordShapeName: "NA",     // no alternate chordShape
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        //################################################
        // Major 7th Chords.
        createChordShapeModel(shapeName: "maj7 Chord (v1)",
                              arrayOfIntervals: ["root", "", "M7", "M3", "P5", ""],
                              arrayOfFingerings: ["I", "", "R", "P", "M", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Maj7 Arpeggio")
        
        createChordShapeModel(shapeName: "maj7 Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "M7", "M3", "P5"],
                              arrayOfFingerings: ["", "I", "R", "M", "P", "I"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "maj7 Chord (v3)",
                              arpeggioToBuildChordFrom: "Maj7 Arpeggio")
        
        createChordShapeModel(shapeName: "maj7 Chord (v3)",
                              arrayOfIntervals: ["", "","root", "P5", "M7", "M3"],
                              arrayOfFingerings: ["", "", "I", "R", "R", "R"],
                              arrayOfInvalidRootNotes: ["C#", "Db"],
                              alternateChordShapeName: "maj7 Chord (v4)",
                              arpeggioToBuildChordFrom: "Maj7 Arpeggio")
        
        createChordShapeModel(shapeName: "maj7 Chord (v4)",
                              arrayOfIntervals: ["", "","root", "M3", "P5", "M7"],
                              arrayOfFingerings: ["", "", "P", "R", "M", "I"],
                              arrayOfInvalidRootNotes: ["D#", "Eb", "E", "Fb"],
                              alternateChordShapeName: "maj7 Chord (v3)",
                              arpeggioToBuildChordFrom: "Maj7 Arpeggio")
      
        //################################################
        // Minor 7 Chords.
        
        createChordShapeModel(shapeName: "m7 Chord (v1)",
                              arrayOfIntervals: ["root", "", "m7", "m3", "P5", "root"],
                              arrayOfFingerings: ["M", "", "R", "R", "R", "R"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m7 Arpeggio")
        
        createChordShapeModel(shapeName: "m7 Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "m7", "m3", "P5"],
                              arrayOfFingerings: ["", "I", "R", "I", "M", "I"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "m7 Chord (v3)",
                              arpeggioToBuildChordFrom: "m7 Arpeggio")
        
        createChordShapeModel(shapeName: "m7 Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "P5", "m7", "m3"],
                              arrayOfFingerings: ["", "", "I", "R", "M", "M"],
                              arrayOfInvalidRootNotes: ["C#", "Db"],
                              alternateChordShapeName: "m7 Chord (v2)",
                              arpeggioToBuildChordFrom: "m7 Arpeggio")
        
        //################################################
        // m7b5 Chords.
        
        createChordShapeModel(shapeName: "m7b5 Chord (v1)",
                              arrayOfIntervals: ["root", "", "m7", "m3", "D5", ""],
                              arrayOfFingerings: ["M", "", "R", "P", "I", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m7b5 Arpeggio")
        
        createChordShapeModel(shapeName: "m7b5 Chord (v2)",
                              arrayOfIntervals: ["", "root", "D5", "m7", "m3", ""],
                              arrayOfFingerings: ["", "I", "R", "M", "P", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m7b5 Arpeggio")
        
        createChordShapeModel(shapeName: "m7b5 Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "D5", "m7", "m3"],
                              arrayOfFingerings: ["", "", "I", "M", "M", "M"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m7b5 Arpeggio")
        
        
        //################################################
        // dim7 Chords.
        
        createChordShapeModel(shapeName: "dim7 Chord (v1)",
                              arrayOfIntervals: ["root", "", "D7", "m3", "D5", ""],
                              arrayOfFingerings: ["M", "", "I", "R", "I", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "dim7 Arpeggio")
        
        createChordShapeModel(shapeName: "dim7 Chord (v2)",
                              arrayOfIntervals: ["", "root", "D5", "D7", "m3", ""],
                              arrayOfFingerings: ["", "M", "R", "I", "P", ""],
                              arrayOfInvalidRootNotes: ["A"],
                              alternateChordShapeName: "dim7 Chord (v3)",
                              arpeggioToBuildChordFrom: "dim7 Arpeggio")
        
        createChordShapeModel(shapeName: "dim7 Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "D5", "D7", "m3"],
                              arrayOfFingerings: ["", "", "I", "R", "M", "P"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "dim7 Arpeggio")
        
    
        
        
        //################################################
        // 9 Chords.
        
        createChordShapeModel(shapeName: "9 Chord (v1)",
                              arrayOfIntervals: [ "root", "M3", "m7", "M2", "", ""],
                              arrayOfFingerings: ["M", "I", "R", "I", "", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Mixolydian Mode")
        
        createChordShapeModel(shapeName: "9 Chord (v2)",
                              arrayOfIntervals: ["", "root", "M3", "m7", "M2", "P5"],
                              arrayOfFingerings: ["", "M", "I", "R", "R", "R"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Mixolydian Mode")
        
        createChordShapeModel(shapeName: "9 Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "M3", "m7", "M2"],
                              arrayOfFingerings: ["", "", "M", "I", "P", "R"],
                              arrayOfInvalidRootNotes: ["D"],
                              alternateChordShapeName: "9 Chord (v2)",
                              arpeggioToBuildChordFrom: "Mixolydian Mode")
        
        
        //################################################
        // Major 9 Chords.
        
        createChordShapeModel(shapeName: "maj9 Chord (v1)",
                              arrayOfIntervals: [  "", "root", "M3", "M7", "M2", ""],
                              arrayOfFingerings: ["", "M", "I", "P", "R", ""],
                              arrayOfInvalidRootNotes: ["A"],
                              alternateChordShapeName: "maj9 Chord (v2)",
                              arpeggioToBuildChordFrom: "Ionian Mode")
        
        createChordShapeModel(shapeName: "maj9 Chord (v2)",
                              arrayOfIntervals: [  "", "", "M7", "M3", "P5", "M2"],
                              arrayOfFingerings: ["", "", "M", "R", "I", "P"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "maj9 Chord (v1)",
                              arpeggioToBuildChordFrom: "Ionian Mode")
        
        createChordShapeModel(shapeName: "maj9 Chord (v3)",
                              arrayOfIntervals: [  "", "", "M3", "M7", "M2", "P5"],
                              arrayOfFingerings: ["", "", "I", "R", "M", "M"],
                              arrayOfInvalidRootNotes:  ["A"], //["G#", "Ab"],
                              alternateChordShapeName: "maj9 Chord (v2)",
                              arpeggioToBuildChordFrom: "Ionian Mode")
        
    
        //################################################
        // Minor 9 Chords.
    
        createChordShapeModel(shapeName: "m9 Chord (v1)",
                              arrayOfIntervals: [ "root", "", "m7", "m3", "P5", "M2"],
                              arrayOfFingerings: ["M", "", "R", "R", "R", "P"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "m9 Chord (v2)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "m9 Chord (v2)",
                              arrayOfIntervals: [ "", "root", "m3", "m7", "M2", "P5"],
                              arrayOfFingerings: ["", "M", "I", "R", "R", "R"],
                              arrayOfInvalidRootNotes: ["A#", "Bb"],
                              alternateChordShapeName: "m9 Chord (v1)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "m9 Chord (v3)",
                              arrayOfIntervals: [ "", "", "root", "m3", "P5", "M2" ],
                              arrayOfFingerings: ["", "", "R", "I", "I", "P"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "m9 Chord (v2)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
    
   
    
    
        //################################################
        // 13 Chords.
        
        createChordShapeModel(shapeName: "13 Chord (v1)",
                              arrayOfIntervals: [ "root", "", "m7", "M3", "M6", ""],
                              arrayOfFingerings: ["I", "", "M", "R", "P", ""],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "13 Chord (v3)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "13 Chord (v2)",
                              arrayOfIntervals: [ "", "", "m7", "M3", "M6", "root"],
                              arrayOfFingerings: ["", "", "I", "M", "R", "I"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "13 Chord (v3)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "13 Chord (v3)",
                              arrayOfIntervals: [ "", "root", "", "m7", "M3", "M6"],
                              arrayOfFingerings: ["", "I", "", "M", "P", "P"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "13 Chord (v2)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        

    }
    
    
    
    // Also adds to the dictionary.
    func createChordShapeModel(shapeName: String,
                               arrayOfIntervals: [String],
                               arrayOfFingerings: [String],
                               arrayOfInvalidRootNotes: [String],
                               alternateChordShapeName: String,
                               arpeggioToBuildChordFrom: String) {
        
        let model = ChordShapeModel()
        model.arrayOfIntervals = arrayOfIntervals
        model.arrayOfFingers = arrayOfFingerings
        model.arrayOfInvalidRootNotes = arrayOfInvalidRootNotes
        model.alternateChordShapeName = alternateChordShapeName
        model.arpeggioToBuildChordFrom = arpeggioToBuildChordFrom
        
        dictOfChordNamesAndShapes[shapeName] = model
        
        arrayOfShapeNames.append(shapeName)
    }
    
    
    // This funct might not be needed. 
    func getInvalidChordNamesForRoot(fullRoot: String)-> [String] {
        var arrayOfInvalidChordNamesForRoot = [String]()
        
        for (shapeName, chordShapeModel) in dictOfChordNamesAndShapes {
            if chordShapeModel.arrayOfInvalidRootNotes.contains(fullRoot) {
                arrayOfInvalidChordNamesForRoot.append(shapeName)
            }
        }
        return arrayOfInvalidChordNamesForRoot
    }
}

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
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "Major Chord (v2)",
                              arpeggioToBuildChordFrom: "Major Arpeggio")
        
        createChordShapeModel(shapeName: "Major Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "root", "M3", "P5"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "Major Chord (v1)",
                              arpeggioToBuildChordFrom: "Major Arpeggio")
        
        createChordShapeModel(shapeName: "Major Chord (v3)",
                              arrayOfIntervals: ["", "root", "M3", "P5", "root", "M3"],
                              arrayOfInvalidRootNotes: ["A#", "Bb", "B", "Cb"],
                              alternateChordShapeName: "Major Chord (v2)",
                              arpeggioToBuildChordFrom: "Major Arpeggio")
        
        createChordShapeModel(shapeName: "Major Chord (v4)",
                              arrayOfIntervals: ["", "", "root", "P5", "root", "M3"],
                              arrayOfInvalidRootNotes: ["B#", "C", "C#", "Db"],
                              alternateChordShapeName: "Major Chord (v3)",
                              arpeggioToBuildChordFrom: "Major Arpeggio")
        
        
        //################################################
        // Minor Chords.
        createChordShapeModel(shapeName: "Minor Chord (v1)",
                              arrayOfIntervals: ["root", "P5", "root", "m3", "P5", "root"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "Minor Chord (v2)",
                              arpeggioToBuildChordFrom: "Minor Arpeggio")
        
        createChordShapeModel(shapeName: "Minor Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "root", "m3", "P5"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "Minor Chord (v1)",
                              arpeggioToBuildChordFrom: "Minor Arpeggio")
        
        createChordShapeModel(shapeName: "Minor Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "P5", "root", "m3"],
                              arrayOfInvalidRootNotes: ["C", "C#", "Db"],
                              alternateChordShapeName: "Minor Chord (v2)",
                              arpeggioToBuildChordFrom: "Minor Arpeggio")
        
        
        //################################################
        // 6 Chords.
        
        createChordShapeModel(shapeName: "6 Chord (v1)",
                              arrayOfIntervals: ["root", "", "M6", "M3", "P5", ""],
                              arrayOfInvalidRootNotes: ["E", "Fb"],
                              alternateChordShapeName: "6 Chord (v2)",
                              arpeggioToBuildChordFrom: "6 Arpeggio")
        
        createChordShapeModel(shapeName: "6 Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "root", "M3", "M6"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "6 Chord (v3)",
                              arpeggioToBuildChordFrom: "6 Arpeggio")
        
        createChordShapeModel(shapeName: "6 Chord (v3)",
                              arrayOfIntervals: ["", "P5", "root", "M3", "M6", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "6 Arpeggio")
        
        //################################################
        // m6 Chords.
        
        createChordShapeModel(shapeName: "m6 Chord (v1)",
                              arrayOfIntervals: ["root", "", "M6", "m3", "P5", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m6 Arpeggio")
        
        createChordShapeModel(shapeName: "m6 Chord (v2)",
                              arrayOfIntervals: ["", "root", "", "M6", "m3", "P5"],
                              arrayOfInvalidRootNotes: ["A"],
                              alternateChordShapeName: "m6 Chord (v3)",
                              arpeggioToBuildChordFrom: "m6 Arpeggio")
        
        createChordShapeModel(shapeName: "m6 Chord (v3)",
                              arrayOfIntervals: ["", "", "P5", "root", "m3", "M6"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m6 Arpeggio")
        
        createChordShapeModel(shapeName: "m6 Chord (v4)",
                              arrayOfIntervals: ["", "", "M6", "m3", "P5", "root"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m6 Arpeggio")
        
        
        //################################################
        // Dominant 7th Chords.
        
        createChordShapeModel(shapeName: "7 Chord (v1)",
                              arrayOfIntervals: ["root", "P5", "m7", "M3", "P5", "root"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "7 Chord (v2)",
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        
        createChordShapeModel(shapeName: "7 Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "m7", "M3", "P5"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "7 Chord (v3)",
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        
        createChordShapeModel(shapeName: "7 Chord (v3)",
                              arrayOfIntervals: ["", "root", "M3", "m7", "root", ""],
                              arrayOfInvalidRootNotes: [ "A#", "Bb"],
                              alternateChordShapeName: "7 Chord (v2)",
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        
        createChordShapeModel(shapeName: "7 Chord (v4)",
                              arrayOfIntervals: ["", "", "root", "P5", "m7", "M3"],
                              arrayOfInvalidRootNotes: ["C#", "Db"],
                              alternateChordShapeName: "7 Chord (v2)",
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        createChordShapeModel(shapeName: "7 Chord (v5)",
                              arrayOfIntervals: ["", "", "", "root", "M3", "m7"],
                              arrayOfInvalidRootNotes: ["NA"],   // no invalid values
                              alternateChordShapeName: "NA",     // no alternate chordShape
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        //################################################
        // Major 7th Chords.
        createChordShapeModel(shapeName: "maj7 Chord (v1)",
                              arrayOfIntervals: ["root", "", "M7", "M3", "P5", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Maj7 Arpeggio")
        
        createChordShapeModel(shapeName: "maj7 Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "M7", "M3", "P5"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "maj7 Chord (v3)",
                              arpeggioToBuildChordFrom: "Maj7 Arpeggio")
        
        createChordShapeModel(shapeName: "maj7 Chord (v3)",
                              arrayOfIntervals: ["", "","root", "P5", "M7", "M3"],
                              arrayOfInvalidRootNotes: ["C#", "Db"],
                              alternateChordShapeName: "maj7 Chord (v4)",
                              arpeggioToBuildChordFrom: "Maj7 Arpeggio")
        
        createChordShapeModel(shapeName: "maj7 Chord (v4)",
                              arrayOfIntervals: ["", "","root", "M3", "P5", "M7"],
                              arrayOfInvalidRootNotes: ["D#", "Eb", "E", "Fb"],
                              alternateChordShapeName: "maj7 Chord (v3)",
                              arpeggioToBuildChordFrom: "Maj7 Arpeggio")
      
        //################################################
        // Minor 7 Chords.
        
        createChordShapeModel(shapeName: "m7 Chord (v1)",
                              arrayOfIntervals: ["root", "", "m7", "m3", "P5", "root"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m7 Arpeggio")
        
        createChordShapeModel(shapeName: "m7 Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "m7", "m3", "P5"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "m7 Chord (v3)",
                              arpeggioToBuildChordFrom: "m7 Arpeggio")
        
        createChordShapeModel(shapeName: "m7 Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "P5", "m7", "m3"],
                              arrayOfInvalidRootNotes: ["C#", "Db"],
                              alternateChordShapeName: "m7 Chord (v2)",
                              arpeggioToBuildChordFrom: "m7 Arpeggio")
        
        //################################################
        // m7b5 Chords.
        
        createChordShapeModel(shapeName: "m7b5 Chord (v1)",
                              arrayOfIntervals: ["root", "", "m7", "m3", "D5", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m7b5 Arpeggio")
        
        createChordShapeModel(shapeName: "m7b5 Chord (v2)",
                              arrayOfIntervals: ["", "root", "D5", "m7", "m3", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m7b5 Arpeggio")
        
        createChordShapeModel(shapeName: "m7b5 Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "D5", "m7", "m3"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m7b5 Arpeggio")
        
        
        //################################################
        // dim7 Chords.
        
        createChordShapeModel(shapeName: "dim7 Chord (v1)",
                              arrayOfIntervals: ["root", "", "D7", "m3", "D5", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "dim7 Arpeggio")
        
        createChordShapeModel(shapeName: "dim7 Chord (v2)",
                              arrayOfIntervals: ["", "root", "D5", "D7", "m3", ""],
                              arrayOfInvalidRootNotes: ["A"],
                              alternateChordShapeName: "dim7 Chord (v3)",
                              arpeggioToBuildChordFrom: "dim7 Arpeggio")
        
        createChordShapeModel(shapeName: "dim7 Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "D5", "D7", "m3"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "dim7 Arpeggio")
        
    
        
        
        //################################################
        // 9 Chords.
        
        createChordShapeModel(shapeName: "9 Chord (v1)",
                              arrayOfIntervals: [ "root", "M3", "m7", "M2", "", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Mixolydian Mode")
        
        createChordShapeModel(shapeName: "9 Chord (v2)",
                              arrayOfIntervals: ["", "root", "M3", "m7", "M2", "P5"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Mixolydian Mode")
        
        createChordShapeModel(shapeName: "9 Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "M3", "m7", "M2"],
                              arrayOfInvalidRootNotes: ["D"],
                              alternateChordShapeName: "9 Chord (v2)",
                              arpeggioToBuildChordFrom: "Mixolydian Mode")
        
        
        //################################################
        // Major 9 Chords.
        
        createChordShapeModel(shapeName: "maj9 Chord (v1)",
                              arrayOfIntervals: [  "", "root", "M3", "M7", "M2", ""],
                              arrayOfInvalidRootNotes: ["A"],
                              alternateChordShapeName: "maj9 Chord (v2)",
                              arpeggioToBuildChordFrom: "Ionian Mode")
        
        createChordShapeModel(shapeName: "maj9 Chord (v2)",
                              arrayOfIntervals: [  "", "", "M7", "M3", "P5", "M2"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "maj9 Chord (v1)",
                              arpeggioToBuildChordFrom: "Ionian Mode")
        
        createChordShapeModel(shapeName: "maj9 Chord (v3)",
                              arrayOfIntervals: [  "", "", "M3", "M7", "M2", "P5"],
                              arrayOfInvalidRootNotes:  ["A"], //["G#", "Ab"],
                              alternateChordShapeName: "maj9 Chord (v2)",
                              arpeggioToBuildChordFrom: "Ionian Mode")
        
    
        //################################################
        // Minor 9 Chords.
    
        createChordShapeModel(shapeName: "m9 Chord (v1)",
                              arrayOfIntervals: [ "root", "", "m7", "m3", "P5", "M2"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "m9 Chord (v2)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "m9 Chord (v2)",
                              arrayOfIntervals: [ "", "root", "m3", "m7", "M2", "P5"],
                              arrayOfInvalidRootNotes: ["A#", "Bb"],
                              alternateChordShapeName: "m9 Chord (v1)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "m9 Chord (v3)",
                              arrayOfIntervals: [ "", "", "root", "m3", "P5", "M2" ],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "m9 Chord (v2)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
    
   
    
    
        //################################################
        // 13 Chords.
        
        createChordShapeModel(shapeName: "13 Chord (v1)",
                              arrayOfIntervals: [ "root", "", "m7", "M3", "M6", ""],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "13 Chord (v3)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "13 Chord (v2)",
                              arrayOfIntervals: [ "", "", "m7", "M3", "M6", "root"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "13 Chord (v3)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "13 Chord (v3)",
                              arrayOfIntervals: [ "", "root", "", "m7", "M3", "M6"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "13 Chord (v2)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        

    }
    
    
    
    // Also adds to the dictionary.
    func createChordShapeModel(shapeName: String,
                               arrayOfIntervals: [String],
                               arrayOfInvalidRootNotes: [String],
                               alternateChordShapeName: String,
                               arpeggioToBuildChordFrom: String) {
        
        let model = ChordShapeModel()
        model.arrayOfIntervals = arrayOfIntervals
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

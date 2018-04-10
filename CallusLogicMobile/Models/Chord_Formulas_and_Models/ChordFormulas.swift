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
                              arrayOfOpenStringFingers: ["O", "M", "R", "I", "O", "O"],
                              arrayOfRootNotesForOpenStringFingers: ["E", "Fb"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "Major Chord (v2)",
                              arpeggioToBuildChordFrom: "Major Arpeggio")
        
        createChordShapeModel(shapeName: "Major Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "root", "M3", ""],
                              arrayOfFingerings: ["", "I", "R", "R", "R", ""],
                              arrayOfOpenStringFingers: ["", "O", "I", "I", "I", ""],
                              arrayOfRootNotesForOpenStringFingers: ["A"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "Major Chord (v1)",
                              arpeggioToBuildChordFrom: "Major Arpeggio")
        
        createChordShapeModel(shapeName: "Major Chord (v3)",
                              arrayOfIntervals: ["", "root", "M3", "P5", "root", "M3"],
                              arrayOfFingerings: ["", "P", "R", "I", "M", "I"],
                              arrayOfOpenStringFingers: ["", "R", "M", "O", "I", "O"],
                              arrayOfRootNotesForOpenStringFingers: ["C", "B#"],
                              arrayOfInvalidRootNotes: ["A#", "Bb", "B", "Cb"],
                              alternateChordShapeName: "Major Chord (v2)",
                              arpeggioToBuildChordFrom: "Major Arpeggio")
        
        createChordShapeModel(shapeName: "Major Chord (v4)",
                              arrayOfIntervals: ["", "", "root", "P5", "root", "M3"],
                              arrayOfFingerings: ["", "", "I", "M", "P", "R"],
                              arrayOfOpenStringFingers: ["", "", "O", "I", "R", "M"],
                              arrayOfRootNotesForOpenStringFingers: ["D"],
                              arrayOfInvalidRootNotes: ["B#", "C", "C#", "Db"],
                              alternateChordShapeName: "Major Chord (v3)",
                              arpeggioToBuildChordFrom: "Major Arpeggio")
        
        
        //################################################
        // Minor Chords.
        createChordShapeModel(shapeName: "Minor Chord (v1)",
                              arrayOfIntervals: ["root", "P5", "root", "m3", "P5", "root"],
                              arrayOfFingerings: ["I", "R", "P", "I", "I", "I"],
                              arrayOfOpenStringFingers: ["O", "M", "R", "O", "O", "O"],
                              arrayOfRootNotesForOpenStringFingers: ["E", "Fb"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "Minor Chord (v2)",
                              arpeggioToBuildChordFrom: "Minor Arpeggio")
        
        createChordShapeModel(shapeName: "Minor Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "root", "m3", "P5"],
                              arrayOfFingerings: ["", "I", "R", "P", "M", "I"],
                              arrayOfOpenStringFingers: ["", "O", "M", "R", "I", "O"],
                              arrayOfRootNotesForOpenStringFingers: ["A"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "Minor Chord (v1)",
                              arpeggioToBuildChordFrom: "Minor Arpeggio")
        
        createChordShapeModel(shapeName: "Minor Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "P5", "root", "m3"],
                              arrayOfFingerings: ["", "", "I", "R", "P", "M"],
                              arrayOfOpenStringFingers: ["", "", "O", "M", "R", "I"],
                              arrayOfRootNotesForOpenStringFingers: ["D"],
                              arrayOfInvalidRootNotes: ["C", "C#", "Db"],
                              alternateChordShapeName: "Minor Chord (v2)",
                              arpeggioToBuildChordFrom: "Minor Arpeggio")
        
        
        
        //################################################
        // Power Chords.
      
        createChordShapeModel(shapeName: "Power Chord (v1)",
                              arrayOfIntervals: ["root", "P5", "", "", "", ""],
                              arrayOfFingerings: ["I", "R", "", "", "", ""],
                              arrayOfOpenStringFingers: ["O", "I", "", "", "", ""],
                              arrayOfRootNotesForOpenStringFingers: ["E", "Fb"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "Power Chord (v3)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        
        createChordShapeModel(shapeName: "Power Chord (v2)",
                              arrayOfIntervals: ["root", "P5", "root", "", "", ""],
                              arrayOfFingerings: ["I", "R", "P", "", "", ""],
                              arrayOfOpenStringFingers: ["O", "I", "I", "", "", ""],
                              arrayOfRootNotesForOpenStringFingers: ["E", "Fb"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "Power Chord (v4)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "Power Chord (v3)",
                              arrayOfIntervals: ["", "root", "P5", "", "", ""],
                              arrayOfFingerings: ["", "I", "R", "", "", ""],
                              arrayOfOpenStringFingers: ["", "O", "I", "", "", ""],
                              arrayOfRootNotesForOpenStringFingers: ["A"],
                              arrayOfInvalidRootNotes: ["G#", "Bb"],
                              alternateChordShapeName: "Power Chord (v1)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "Power Chord (v4)",
                              arrayOfIntervals: ["", "root", "P5", "root", "", ""],
                              arrayOfFingerings: ["", "I", "R", "P", "", ""],
                              arrayOfOpenStringFingers: ["", "O", "I", "I", "", ""],
                              arrayOfRootNotesForOpenStringFingers: ["A"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "Power Chord (v2)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        
        
        //################################################
        // 6 Chords.
        
        createChordShapeModel(shapeName: "6 Chord (v1)",
                              arrayOfIntervals: ["root", "", "M6", "M3", "P5", ""],
                              arrayOfFingerings: ["M", "", "I", "P", "R", ""],
                              arrayOfOpenStringFingers: ["I", "", "O", "R", "M", ""],
                              arrayOfRootNotesForOpenStringFingers: ["E#", "F"],
                              arrayOfInvalidRootNotes: ["E", "Fb"],
                              alternateChordShapeName: "6 Chord (v3)",
                              arpeggioToBuildChordFrom: "6 Arpeggio")
        
        createChordShapeModel(shapeName: "6 Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "root", "M3", "M6"],
                              arrayOfFingerings: ["", "I", "R", "R", "R", "R"],
                              arrayOfOpenStringFingers: ["", "O", "I", "I", "I", "I"],
                              arrayOfRootNotesForOpenStringFingers: ["A"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "6 Chord (v3)",
                              arpeggioToBuildChordFrom: "6 Arpeggio")
        
        createChordShapeModel(shapeName: "6 Chord (v3)",
                              arrayOfIntervals: ["", "P5", "root", "M3", "M6", ""],
                              arrayOfFingerings: ["", "M", "R", "I", "P", ""],
                              arrayOfOpenStringFingers: ["", "I", "M", "O", "R", ""],
                              arrayOfRootNotesForOpenStringFingers: ["D#", "Eb"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "6 Arpeggio")
        
        //################################################
        // m6 Chords.
        
        createChordShapeModel(shapeName: "m6 Chord (v1)",
                              arrayOfIntervals: ["root", "", "M6", "m3", "P5", ""],
                              arrayOfFingerings: ["M", "", "I", "R", "P", ""],
                              arrayOfOpenStringFingers: ["I", "", "O", "M", "R", ""],
                              arrayOfRootNotesForOpenStringFingers: ["E#", "F"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m6 Arpeggio")
        
        createChordShapeModel(shapeName: "m6 Chord (v2)",
                              arrayOfIntervals: ["", "root", "", "M6", "m3", "P5"],
                              arrayOfFingerings: ["", "M", "", "I", "P", "R"],
                              arrayOfOpenStringFingers: ["", "I", "", "O", "R", "M"],
                              arrayOfRootNotesForOpenStringFingers: ["A#", "Bb"],
                              arrayOfInvalidRootNotes: ["A"],
                              alternateChordShapeName: "m6 Chord (v3)",
                              arpeggioToBuildChordFrom: "m6 Arpeggio")
        
        createChordShapeModel(shapeName: "m6 Chord (v3)",
                              arrayOfIntervals: ["", "", "P5", "root", "m3", "M6"],
                              arrayOfFingerings: ["", "", "M", "R", "I", "P"],
                              arrayOfOpenStringFingers: ["", "", "I", "M", "O", "R"],
                              arrayOfRootNotesForOpenStringFingers: ["G#", "Ab"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m6 Arpeggio")
        
        createChordShapeModel(shapeName: "m6 Chord (v4)",
                              arrayOfIntervals: ["", "", "M6", "m3", "P5", "root"],
                              arrayOfFingerings: ["", "", "I", "M", "M", "M"],
                              arrayOfOpenStringFingers: ["", "", "O", "I", "I", "I"],
                              arrayOfRootNotesForOpenStringFingers: ["E#", "F"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m6 Arpeggio")
        
        
        //################################################
        // Dominant 7th Chords.
        
        createChordShapeModel(shapeName: "7 Chord (v1)",
                              arrayOfIntervals: ["root", "P5", "m7", "M3", "P5", "root"],
                              arrayOfFingerings: ["I", "R", "I", "M", "I", "I"],
                              arrayOfOpenStringFingers: ["O", "M", "O", "I", "O", "O"],
                              arrayOfRootNotesForOpenStringFingers: ["E", "Fb"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "7 Chord (v4)",
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        
        createChordShapeModel(shapeName: "7 Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "m7", "M3", "P5"],
                              arrayOfFingerings: ["", "I", "R", "I", "P", "I"],
                              arrayOfOpenStringFingers: ["", "O", "M", "O", "R", "O"],
                              arrayOfRootNotesForOpenStringFingers: ["A"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "7 Chord (v5)",
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        
        createChordShapeModel(shapeName: "7 Chord (v3)",
                              arrayOfIntervals: ["", "root", "M3", "m7", "root", ""],
                              arrayOfFingerings: [ "", "R", "M", "P", "I", ""],
                              arrayOfOpenStringFingers: ["", "M", "I", "R", "O", ""],
                              arrayOfRootNotesForOpenStringFingers: ["B", "Cb"],
                              arrayOfInvalidRootNotes: [ "A#", "Bb"],
                              alternateChordShapeName: "7 Chord (v2)",
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        
        createChordShapeModel(shapeName: "7 Chord (v4)",
                              arrayOfIntervals: ["", "", "root", "P5", "m7", "M3"],
                              arrayOfFingerings: ["", "", "I", "R", "M", "P"],
                              arrayOfOpenStringFingers: ["", "", "O", "M", "I", "R"],
                              arrayOfRootNotesForOpenStringFingers: ["D"],
                              arrayOfInvalidRootNotes: ["C#", "Db"],
                              alternateChordShapeName: "7 Chord (v2)",
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        createChordShapeModel(shapeName: "7 Chord (v5)",
                              arrayOfIntervals: ["", "", "", "root", "M3", "m7"],
                              arrayOfFingerings: ["", "", "", "I", "I", "M"],
                              arrayOfOpenStringFingers: ["", "", "", "O", "O", "I"],
                              arrayOfRootNotesForOpenStringFingers: ["G"],
                              arrayOfInvalidRootNotes: ["NA"],   // no invalid values
                              alternateChordShapeName: "NA",     // no alternate chordShape
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        //################################################
        // Major 7th Chords.
        createChordShapeModel(shapeName: "maj7 Chord (v1)",
                              arrayOfIntervals: ["root", "", "M7", "M3", "P5", ""],
                              arrayOfFingerings: ["I", "", "R", "P", "M", ""],
                              arrayOfOpenStringFingers: ["O", "", "M", "R", "O", ""],
                              arrayOfRootNotesForOpenStringFingers: ["E", "Fb"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Maj7 Arpeggio")
        
        createChordShapeModel(shapeName: "maj7 Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "M7", "M3", "P5"],
                              arrayOfFingerings: ["", "I", "R", "M", "P", "I"],
                              arrayOfOpenStringFingers: ["", "O", "M", "I", "R", "O"],
                              arrayOfRootNotesForOpenStringFingers: ["A"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "maj7 Chord (v3)",
                              arpeggioToBuildChordFrom: "Maj7 Arpeggio")
        
        createChordShapeModel(shapeName: "maj7 Chord (v3)",
                              arrayOfIntervals: ["", "","root", "P5", "M7", "M3"],
                              arrayOfFingerings: ["", "", "I", "R", "R", "R"],
                              arrayOfOpenStringFingers: ["", "", "O", "M", "M", "M"],
                              arrayOfRootNotesForOpenStringFingers: ["D"],
                              arrayOfInvalidRootNotes: ["C#", "Db"],
                              alternateChordShapeName: "maj7 Chord (v2)",
                              arpeggioToBuildChordFrom: "Maj7 Arpeggio")
        
        createChordShapeModel(shapeName: "maj7 Chord (v4)",
                              arrayOfIntervals: ["", "","root", "M3", "P5", "M7"],
                              arrayOfFingerings: ["", "", "P", "R", "M", "I"],
                              arrayOfOpenStringFingers: ["", "", "R", "M", "I", "O"],
                              arrayOfRootNotesForOpenStringFingers: ["E#", "F"],
                              arrayOfInvalidRootNotes: ["D#", "Eb", "E", "Fb"],
                              alternateChordShapeName: "maj7 Chord (v3)",
                              arpeggioToBuildChordFrom: "Maj7 Arpeggio")
      
        //################################################
        // Minor 7 Chords.
        
        createChordShapeModel(shapeName: "m7 Chord (v1)",
                              arrayOfIntervals: ["root", "", "m7", "m3", "P5", "root"],
                              arrayOfFingerings: ["M", "", "R", "R", "R", "R"],
                              arrayOfOpenStringFingers: ["O", "", "O", "O", "O", "O"],
                              arrayOfRootNotesForOpenStringFingers: ["E", "Fb"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m7 Arpeggio")
        
        createChordShapeModel(shapeName: "m7 Chord (v2)",
                              arrayOfIntervals: ["", "root", "P5", "m7", "m3", "P5"],
                              arrayOfFingerings: ["", "I", "R", "I", "M", "I"],
                              arrayOfOpenStringFingers: ["", "O", "M", "O", "I", "O"],
                              arrayOfRootNotesForOpenStringFingers: ["A"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "m7 Chord (v3)",
                              arpeggioToBuildChordFrom: "m7 Arpeggio")
        
        createChordShapeModel(shapeName: "m7 Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "P5", "m7", "m3"],
                              arrayOfFingerings: ["", "", "I", "R", "M", "M"],
                              arrayOfOpenStringFingers: ["", "", "O", "M", "I", "I"],
                              arrayOfRootNotesForOpenStringFingers: ["D"],
                              arrayOfInvalidRootNotes: ["C#", "Db"],
                              alternateChordShapeName: "m7 Chord (v2)",
                              arpeggioToBuildChordFrom: "m7 Arpeggio")
        
        //################################################
        // m7b5 Chords.
        
        createChordShapeModel(shapeName: "m7b5 Chord (v1)",
                              arrayOfIntervals: ["root", "", "m7", "m3", "D5", ""],
                              arrayOfFingerings: ["M", "", "R", "P", "I", ""],
                              arrayOfOpenStringFingers: ["I", "", "M", "R", "O", ""],
                              arrayOfRootNotesForOpenStringFingers: ["E#", "F"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m7b5 Arpeggio")
        
        createChordShapeModel(shapeName: "m7b5 Chord (v2)",
                              arrayOfIntervals: ["", "root", "D5", "m7", "m3", ""],
                              arrayOfFingerings: ["", "I", "R", "M", "P", ""],
                              arrayOfOpenStringFingers: ["", "O", "I", "O", "M", ""],
                              arrayOfRootNotesForOpenStringFingers: ["A"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m7b5 Arpeggio")
        
        createChordShapeModel(shapeName: "m7b5 Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "D5", "m7", "m3"],
                              arrayOfFingerings: ["", "", "I", "M", "M", "M"],
                              arrayOfOpenStringFingers: ["", "", "O", "I", "I", "I"],
                              arrayOfRootNotesForOpenStringFingers: ["D"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "m7b5 Arpeggio")
        
        
        //################################################
        // m7#5 Chords.
        
        createChordShapeModel(shapeName: "7#5 Chord (v1)",
                              arrayOfIntervals: ["root", "", "m7", "M3", "A5", ""],
                              arrayOfFingerings: ["I", "", "M", "R", "P", ""],
                              arrayOfOpenStringFingers: ["O", "", "O", "I", "M", ""],
                              arrayOfRootNotesForOpenStringFingers: ["E", "Fb"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "7#5 Arpeggio")
        
        createChordShapeModel(shapeName: "7#5 Chord (v2)",
                              arrayOfIntervals: ["", "root", "", "m7", "M3", "A5"],
                              arrayOfFingerings: ["", "I", "", "M", "P", "R"],
                              arrayOfOpenStringFingers: ["", "O", "", "O", "R", "M"],
                              arrayOfRootNotesForOpenStringFingers: ["A"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "7#5 Chord (v1)",
                              arpeggioToBuildChordFrom: "7#5 Arpeggio")
        
        //################################################
        // dim7 Chords.
        
        createChordShapeModel(shapeName: "dim7 Chord (v1)",
                              arrayOfIntervals: ["root", "", "D7", "m3", "D5", ""],
                              arrayOfFingerings: ["M", "", "I", "R", "I", ""],
                              arrayOfOpenStringFingers: ["M", "", "O", "R", "O", ""],
                              arrayOfRootNotesForOpenStringFingers: ["E#" , "F"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "dim7 Arpeggio")
        
        createChordShapeModel(shapeName: "dim7 Chord (v2)",
                              arrayOfIntervals: ["", "root", "D5", "D7", "m3", ""],
                              arrayOfFingerings: ["", "M", "R", "I", "P", ""],
                              arrayOfOpenStringFingers: ["", "M", "R", "O", "P", ""],
                              arrayOfRootNotesForOpenStringFingers: ["A#", "Bb"],
                              arrayOfInvalidRootNotes: ["A"],
                              alternateChordShapeName: "dim7 Chord (v3)",
                              arpeggioToBuildChordFrom: "dim7 Arpeggio")
        
        createChordShapeModel(shapeName: "dim7 Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "D5", "D7", "m3"],
                              arrayOfFingerings: ["", "", "I", "R", "M", "P"],
                              arrayOfOpenStringFingers: ["", "", "O", "I", "O", "M"],
                              arrayOfRootNotesForOpenStringFingers: ["D"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "dim7 Arpeggio")
        
    
        
        
        //################################################
        // 9 Chords.
        
        createChordShapeModel(shapeName: "9 Chord (v1)",
                              arrayOfIntervals: [ "root", "M3", "m7", "M2", "", ""],
                              arrayOfFingerings: ["M", "I", "R", "I", "", ""],
                              arrayOfOpenStringFingers: ["I", "O", "M", "O", "", ""],
                              arrayOfRootNotesForOpenStringFingers: ["E#", "F"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Mixolydian Mode")
        
        createChordShapeModel(shapeName: "9 Chord (v2)",
                              arrayOfIntervals: ["", "root", "M3", "m7", "M2", "P5"],
                              arrayOfFingerings: ["", "M", "I", "R", "R", "R"],
                              arrayOfOpenStringFingers: ["", "M", "O", "R", "R", "R"],
                              arrayOfRootNotesForOpenStringFingers: ["A#", "Bb"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Mixolydian Mode")
        
        createChordShapeModel(shapeName: "9 Chord (v3)",
                              arrayOfIntervals: ["", "", "root", "M3", "m7", "M2"],
                              arrayOfFingerings: ["", "", "M", "I", "P", "R"],
                              arrayOfOpenStringFingers: ["", "", "I", "O", "R", "M"],
                              arrayOfRootNotesForOpenStringFingers: ["D#", "Eb"],
                              arrayOfInvalidRootNotes: ["D"],
                              alternateChordShapeName: "9 Chord (v2)",
                              arpeggioToBuildChordFrom: "Mixolydian Mode")
        
        
        //################################################
        // Major 9 Chords.
        
        
        createChordShapeModel(shapeName: "maj9 Chord (v1)",
                              arrayOfIntervals: [ "root", "M3", "M7", "M2", "", ""],
                              arrayOfFingerings: ["M", "I", "R", "I", "", ""],
                              arrayOfOpenStringFingers: ["I", "O", "R", "O", "", ""],
                              arrayOfRootNotesForOpenStringFingers: ["E#",  "F"],
                              arrayOfInvalidRootNotes: ["E", "Fb"],
                              alternateChordShapeName: "maj9 Chord (v3)",
                              arpeggioToBuildChordFrom: "Ionian Mode")
        
        createChordShapeModel(shapeName: "maj9 Chord (v2)",
                              arrayOfIntervals: [  "", "root", "M3", "M7", "M2", ""],
                              arrayOfFingerings: ["", "M", "I", "P", "R", ""],
                              arrayOfOpenStringFingers: ["", "I", "O", "R", "M", ""],
                              arrayOfRootNotesForOpenStringFingers: ["A#", "Bb"],
                              arrayOfInvalidRootNotes: ["A"],
                              alternateChordShapeName: "maj9 Chord (v3)",
                              arpeggioToBuildChordFrom: "Ionian Mode")
        
        createChordShapeModel(shapeName: "maj9 Chord (v3)",
                              arrayOfIntervals: [  "", "", "M7", "M3", "P5", "M2"],
                              arrayOfFingerings: ["", "", "M", "R", "I", "P"],
                              arrayOfOpenStringFingers: ["", "", "I", "M", "O", "P"],
                              arrayOfRootNotesForOpenStringFingers: ["E", "Fb"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "maj9 Chord (v1)",
                              arpeggioToBuildChordFrom: "Ionian Mode")
        
  
        
    
        //################################################
        // Minor 9 Chords.
    
        createChordShapeModel(shapeName: "m9 Chord (v1)",
                              arrayOfIntervals: [ "root", "", "m7", "m3", "P5", "M2"],
                              arrayOfFingerings: ["M", "", "R", "R", "R", "P"],
                              arrayOfOpenStringFingers: ["O", "", "O", "O", "O", "R"],
                              arrayOfRootNotesForOpenStringFingers: ["E", "Fb"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "m9 Chord (v2)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "m9 Chord (v2)",
                              arrayOfIntervals: [ "", "root", "m3", "m7", "M2", "P5"],
                              arrayOfFingerings: ["", "M", "I", "R", "R", "R"],
                              arrayOfOpenStringFingers: ["", "M", "O", "R", "R", "R"],
                              arrayOfRootNotesForOpenStringFingers: ["B", "Cb"],
                              arrayOfInvalidRootNotes: ["A#", "Bb"],
                              alternateChordShapeName: "m9 Chord (v1)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "m9 Chord (v3)",
                              arrayOfIntervals: [ "", "", "root", "m3", "P5", "M2" ],
                              arrayOfFingerings: ["", "", "R", "I", "I", "P"],
                              arrayOfOpenStringFingers: ["", "", "M", "O", "O", "R"],
                              arrayOfRootNotesForOpenStringFingers: ["E", "Fb"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "m9 Chord (v2)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
    
   
    
    
        //################################################
        // 13 Chords.
        
        createChordShapeModel(shapeName: "13 Chord (v1)",
                              arrayOfIntervals: [ "root", "", "m7", "M3", "M6", ""],
                              arrayOfFingerings: ["I", "", "M", "R", "P", ""],
                              arrayOfOpenStringFingers: ["O", "", "O", "M", "R", ""],
                              arrayOfRootNotesForOpenStringFingers: ["E", "Fb"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "13 Chord (v3)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "13 Chord (v2)",
                              arrayOfIntervals: [ "", "", "m7", "M3", "M6", "root"],
                              arrayOfFingerings: ["", "", "I", "M", "R", "I"],
                              arrayOfOpenStringFingers: ["", "", "O", "I", "R", "O"],
                              arrayOfRootNotesForOpenStringFingers: ["E", "Fb"],
                              arrayOfInvalidRootNotes: ["D#", "Eb"],
                              alternateChordShapeName: "13 Chord (v3)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(shapeName: "13 Chord (v3)",
                              arrayOfIntervals: [ "", "root", "", "m7", "M3", "M6"],
                              arrayOfFingerings: ["", "I", "", "M", "P", "P"],
                              arrayOfOpenStringFingers: ["", "O", "", "O", "M", "R"],
                              arrayOfRootNotesForOpenStringFingers: ["A"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "13 Chord (v2)",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        

    }
    
    
    
    // Also adds to the dictionary.
    func createChordShapeModel(shapeName: String,
                               arrayOfIntervals: [String],
                               arrayOfFingerings: [String],
                               arrayOfOpenStringFingers: [String],
                               arrayOfRootNotesForOpenStringFingers: [String],
                               arrayOfInvalidRootNotes: [String],
                               alternateChordShapeName: String,
                               arpeggioToBuildChordFrom: String) {
        
        let model = ChordShapeModel()
        model.arrayOfIntervals = arrayOfIntervals
        model.arrayOfFingers = arrayOfFingerings
        model.arrayOfOpenStringFingers = arrayOfOpenStringFingers
        model.arrayOfRootNotesForOpenStringFingers = arrayOfRootNotesForOpenStringFingers
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

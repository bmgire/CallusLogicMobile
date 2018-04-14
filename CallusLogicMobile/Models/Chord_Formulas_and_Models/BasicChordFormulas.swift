//
//  BasicChordFormulas.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 3/29/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import Foundation

class BasicChordFormulas {
    
    var arrayOfBasicChordNames = [String]()
    var dictOfBasicChordNamesAndShapes = [ String : BasicChordModel]()
    
    init() {
        
        //################################################
        // A
        createChordShapeModel(fullRoot: "A",
                              chordName: " Chord",
                              arrayOfIntervals: ["", "root", "P5", "root", "M3", "P5"],
                              arrayOfChordFingerings: ["", "O", "I", "M", "R", "O"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Major Arpeggio")
        
        createChordShapeModel(fullRoot: "A",
                              chordName: "m Chord",
                              arrayOfIntervals: ["", "root", "P5", "root", "m3", "P5"],
                              arrayOfChordFingerings: ["", "O", "M", "R", "I", "O"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Minor Arpeggio")
        
        
        createChordShapeModel(fullRoot: "A",
                              chordName: "7 Chord",
                              arrayOfIntervals: ["", "root", "P5", "m7", "M3", "P5"],
                              arrayOfChordFingerings: ["", "O", "M", "O", "R", "O"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Dominant 7th Arpeggio")
        
        //################################################
        // B
        createChordShapeModel(fullRoot: "B",
                              chordName: " Chord",
                              arrayOfIntervals: ["", "root", "P5", "root", "M3", ""],
                              arrayOfChordFingerings: ["", "I", "M", "M", "M", ""],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(fullRoot: "B",
                              chordName: "m Chord",
                              arrayOfIntervals: ["", "root", "P5", "root", "m3", "P5"],
                              arrayOfChordFingerings: ["", "I", "R", "P", "M", "I"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(fullRoot: "B",
                              chordName: "7 Chord",
                              arrayOfIntervals: ["", "root", "M3", "m7", "root", "P5"],
                              arrayOfChordFingerings: ["", "M", "I", "R", "O", "P"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        //################################################
        // C
        createChordShapeModel(fullRoot: "C",
                              chordName: " Chord",
                              arrayOfIntervals: ["", "root", "M3", "P5", "root", "M3"],
                              arrayOfChordFingerings: ["", "R", "M", "O", "I", "O"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(fullRoot: "C",
                              chordName: "m Chord",
                              arrayOfIntervals: ["", "root", "P5", "root", "m3", "P5"],
                              arrayOfChordFingerings: ["", "I", "R", "P", "M", "I"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(fullRoot: "C",
                              chordName: "7 Chord",
                              arrayOfIntervals: ["", "root", "M3", "m7", "root", "M3"],
                              arrayOfChordFingerings: ["", "R", "M", "P", "I", "O"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        //################################################
        // D
        createChordShapeModel(fullRoot: "D",
                              chordName: " Chord",
                              arrayOfIntervals: ["", "", "root", "P5", "root", "M3"],
                              arrayOfChordFingerings: ["", "", "O", "I", "R", "M"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(fullRoot: "D",
                              chordName: "m Chord",
                              arrayOfIntervals: ["", "", "root", "P5", "root", "m3"],
                              arrayOfChordFingerings: ["", "", "O", "M", "R", "I"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(fullRoot: "D",
                              chordName: "7 Chord",
                              arrayOfIntervals: ["", "", "root", "P5", "m7", "M3"],
                              arrayOfChordFingerings: ["", "", "O", "M", "I", "R"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        
        //################################################
        // E
        createChordShapeModel(fullRoot: "E",
                              chordName: " Chord",
                              arrayOfIntervals: ["root", "P5", "root", "M3", "P5", "root"],
                              arrayOfChordFingerings: ["O", "M", "R", "I", "O", "O"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
       
        createChordShapeModel(fullRoot: "E",
                              chordName: "m Chord",
                              arrayOfIntervals: ["root", "P5", "root", "m3", "P5", "root"],
                              arrayOfChordFingerings: ["O", "M", "R", "O", "O", "O"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        
        createChordShapeModel(fullRoot: "E",
                              chordName: "7 Chord",
                              arrayOfIntervals: ["root", "P5", "m7", "M3", "P5", "root"],
                              arrayOfChordFingerings: ["O", "M", "O", "I", "O", "O"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        //################################################
        // F
        createChordShapeModel(fullRoot: "F",
                              chordName: " Chord",
                              arrayOfIntervals: ["", "", "root", "M3", "P5", "root"],
                              arrayOfChordFingerings: ["", "", "R", "M", "I", "I"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(fullRoot: "F",
                              chordName: "m Chord",
                              arrayOfIntervals: ["", "", "root", "m3", "P5", "root"],
                              arrayOfChordFingerings: ["", "", "R", "I", "I", "I"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(fullRoot: "F",
                              chordName: "7 Chord",
                              arrayOfIntervals: ["root", "P5", "m7", "M3", "P5", "root"],
                              arrayOfChordFingerings: ["I", "R", "I", "M", "I", "I"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        //################################################
        // G
        createChordShapeModel(fullRoot: "G",
                              chordName: " Chord",
                              arrayOfIntervals: ["root", "M3", "P5", "root", "M3", "root"],
                              arrayOfChordFingerings: ["R", "M", "O", "O", "O", "P"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(fullRoot: "G",
                              chordName: "m Chord",
                              arrayOfIntervals: ["", "", "root", "m3", "P5", "root"],
                              arrayOfChordFingerings: ["", "", "R", "I", "I", "I"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
        createChordShapeModel(fullRoot: "G",
                              chordName: "7 Chord",
                              arrayOfIntervals: ["root", "P5", "m7", "M3", "P5", "root"],
                              arrayOfChordFingerings: ["I", "R", "I", "M", "I", "I"],
                              arrayOfInvalidRootNotes: ["NA"],
                              alternateChordShapeName: "NA",
                              arpeggioToBuildChordFrom: "Chromatic Scale")
        
    }

    func createChordShapeModel(fullRoot: String,
                               chordName: String,
                               arrayOfIntervals: [String],
                               arrayOfChordFingerings: [String],
                               arrayOfInvalidRootNotes: [String],
                               alternateChordShapeName: String,
                               arpeggioToBuildChordFrom: String) {
        
        let model = BasicChordModel()
        model.fullRoot = fullRoot
        model.shapeModel.arrayOfIntervals = arrayOfIntervals
        model.shapeModel.arrayOfFingers = arrayOfChordFingerings
    //    model.shapeModel.arrayOfInvalidRootNotes = arrayOfInvalidRootNotes
        model.shapeModel.alternateChordShapeName = alternateChordShapeName
        model.shapeModel.arpeggioToBuildChordFrom = arpeggioToBuildChordFrom
        
         let name = fullRoot + chordName
        dictOfBasicChordNamesAndShapes[name] = model
        arrayOfBasicChordNames.append(name)
    }


}

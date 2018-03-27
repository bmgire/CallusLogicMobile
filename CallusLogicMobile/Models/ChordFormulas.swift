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
       
        
        createChordShapeModel(shapeName: "Minor Chord (shape 1)",
                              arrayOfIntervals: ["root", "P5", "root", "m3", "P5", "root"],
                              arrayOfInvalidRootNotes: ["D", "D#", "Eb"],
                              alternateChordShapeName: "Minor Chord (shape 2)",
                              arpeggioToBuildChordFrom: "Minor Arpeggio")
        
        createChordShapeModel(shapeName: "Minor Chord (shape 2)",
                              arrayOfIntervals: ["", "root", "P5", "root", "m3", "P5"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "Minor Chord (shape 1)",
                              arpeggioToBuildChordFrom: "Minor Arpeggio")
        
        createChordShapeModel(shapeName: "Minor Chord (shape 3)",
                              arrayOfIntervals: ["", "", "root", "P5", "root", "m3"],
                              arrayOfInvalidRootNotes: ["G#", "Ab"],
                              alternateChordShapeName: "Minor Chord (shape 1)",
                              arpeggioToBuildChordFrom: "Minor Arpeggio")
        
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
    
 /*   func getChordNames()-> [String] {

    } */
}

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

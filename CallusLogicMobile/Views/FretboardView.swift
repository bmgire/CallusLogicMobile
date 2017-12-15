//
//  FretboardView.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 12/11/17.
//  Copyright © 2017 Gire. All rights reserved.
//

import UIKit

class FretboardView: UIImageView {
    
    let NOTES_PER_STRING = 13
    let NOTES_ON_FRETBOARD =  78
    let noteView = NoteView()
    //#####################################
    // right handed fretboardView dimensions. 1024 * 307
    
    let fretPositions: [CGFloat] =
            [0, // 0
            0.086,
            0.182,
            0.274, // 3
            0.360,
            0.445, // 5
            0.525,
            0.60, // 7
            0.671,
            0.743,
            0.81, // 10
            0.875,
            0.94] // 12
    
    //#####################################
    let noteWidths: [CGFloat] =
        [ 58,
          80,
          80,
          80,
          80,
          80,
          80,
          80,
          80,
          76, //9
          72,
          68,
          64]
    
    //#####################################
    // Radians for guitar string rotation, ordered from lowest pitched string to highest.
    let radians: [CGFloat] =
        [0.035,
         0.025,
         0.01,
         0.00,
        -0.01,
        -0.024]
    
    //#####################################
    // Multipliers to correctly place each set of notes onto the appropriate
    //guitar String, relative to the pictures bounds.
    let stringHeightMultipliers: [CGFloat] =
        [0.75,
         0.63,
         0.50,
         0.37,
         0.25,
         0.12]
    
    //#####################################
    var arrayOfNoteRects = [CGRect]()
    var arrayOfNoteViews = [NoteView]()
    
   // An empty implementation adversely affects performance during animation.

    //override func draw(_ rect: CGRect) {
    //}

    //#####################################
    override func awakeFromNib() {
        
        // Build rects for each guitar string of notes.
        for index in 0...5{
            buildNoteRects(stringHeightMultipliers[index], radians: radians[index])
       }
        buildNoteViews()
        addSubviews()
        
        
        
        
        
        
        /*    let point = CGPoint(x: 66, y: 220)
        let size = CGSize(width: 88, height: 40)
        
        
        // the frame has to be set for the noteView, or it screws up.
        // previously I was setting the noteView.bounds property but that wasn't working
        
        noteView.frame = CGRect(origin: point, size: size)
        
        // OMG!!! isOpaque needs to be set to false so the note will not include a black background.
        // I don't know why that is.
        noteView.isOpaque = false
        
        addSubview(noteView)
 
         */
        
    }
    //#####################################
    // Build Note Rects. Build 13 rects and reuse them on each string.
    fileprivate func buildNoteRects(_ yMultiplier: CGFloat,  radians: CGFloat)  {
        
        // Create a temp array and copy any rects in rectArray to it.
        var tempRects = [CGRect]()
        
       let length = bounds.maxX * 0.998
      
         // Adjusts the lengths of the bottom 3 strings on a right handed guitar
        // for aesthetic purposes.
   /*    if radians < 0 {
            length *= 0.998
        }
   */
        let height = bounds.maxY
        
        // the X value of the first NoteViews Rect.
        var noteX = CGFloat(0)
        
        // For all notes.
        for index in 0...NOTES_PER_STRING - 1 {
            
            // Calculate the X position.
            noteX = length * fretPositions[index]
            // Build the rect and append
            //tempRects.append(CGRect(x: noteX, y: height * yMultiplier + sin(radians) * noteX , width: noteWidths[index], height: 25))
            tempRects.append(CGRect(x: noteX, y: height * yMultiplier + sin(radians) * noteX, width: noteWidths[index], height: 40))
        }
        
        // update RectArray.
        arrayOfNoteRects += tempRects
    }
    
    //#####################################
    // Builds the noteViewsArray.
    fileprivate func buildNoteViews() {
        
        // String index represents each guitar string. 0 is highest pitch, 5 is lowest.
        for stringIndex in 0...5 {
            
            // rectIndex is the index of each notes rect on each guitar string.
            for noteIndex in 0...(NOTES_PER_STRING - 1) {
                let note = NoteView()
                
                let index = noteIndex + stringIndex * NOTES_PER_STRING
                
                // Update the appropriate frame.
                note.frame = arrayOfNoteRects[index]
                // Adjust fonts for frets with small widths.
                
                // The views number in the fretboard, for NoteView identification for Event notifications.
             note.viewNumberDict = ["number" : index]
                
                // If the NoteView isn't at the nut, rotate it.
       /*      if noteIndex != 0 {
                note.rotate(byDegrees: radians[stringIndex] * CGFloat(180/Double.pi))
                }
            */
               note.isOpaque = false
                arrayOfNoteViews.append(note)
            }
        }
    }
    
    //#####################################
    // Add all NoteViews as subviews.
    fileprivate func addSubviews() {
        for index in 0...(arrayOfNoteViews.count - 1) {
            addSubview(arrayOfNoteViews[index])
        }
    }

    // Updates the contents of each noteView.
    func updateSubviews(_ fretboardArray: [NoteModel], displayMode: String) {
        for index in 0...NOTES_ON_FRETBOARD - 1  {
            let view = subviews[index] as! NoteView
            let noteModel = fretboardArray[index]
            
            var displayText = ""
            
            switch displayMode {
            case "Fret Numbers":
                displayText = noteModel.getFretNumber()
            case "Intervals":
                displayText = noteModel.getInterval()
            case "Numbers 0-11":
                displayText = noteModel.getNumber0to11()
            case "Numbers 0-46":
                displayText = noteModel.getNumber0to46()
            default:
                displayText = noteModel.getNote()
            }
            
            // Update noteView
            view.updateNoteView(noteModel, display: displayText)
            
        }
        // needsDisplay = true
    }
}

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
    let noteView = NoteView()
    //#####################################
    let frets: [CGFloat] =
        [0, // 0
            0.1,
            0.19,
            0.25, // 3
            0.265,
            0.322, // 5
            0.375,
            0.426, // 7
            0.475,
            0.521,
            0.564, // 10
            0.606,
            0.645] // 12
    
    //#####################################
    let noteWidths: [CGFloat] =
        [ 54,
          59,
          59,
          59,
          59,
          59,
          59,
          59,
          58,
          58,
          58,
          58,
          58]
    
    //#####################################
    // Radians for guitar string rotation, ordered from lowest pitched string to highest.
    let radians: [CGFloat] =
        [-0.02094,
         -0.01604,
         -0.01,
         0.00046,
         0.00796,
         0.01396]
    
    //#####################################
    // Multipliers to correctly place each set of notes onto the appropriate
    //guitar String, relative to the pictures bounds.
    let stringHeightMultipliers: [CGFloat] =
        [0.13,
         0.269,
         0.38,
         0.49,
         0.6,
         0.71]
    
    //#####################################
    var arrayOfNoteRects = [CGRect]()
    var arrayOfNoteViews = [NoteView]()
    
/*    // An empty implementation adversely affects performance during animation.
override func draw(_ rect: CGRect) {

    }
 */
    //#####################################
    override func awakeFromNib() {
        
        // Build rects for each guitar string of notes.
      //  for index in 0...5{
            buildNoteRects(stringHeightMultipliers[0]) /*, radians: radians[index]) */
        //}
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


    // Build Note Rects.
    fileprivate func buildNoteRects(_ yMultiplier: CGFloat) /*,  radians: CGFloat) */ {
        
        // Create a temp array and copy any rects in rectArray to it.
        var tempRects = [CGRect]()
        
   /*     let length = bounds.maxX
        
         // Adjusts the lengths of the bottom 3 strings on a right handed guitar
        // for aesthetic purposes.
       if radians < 0 {
            length *= 0.998
        }
        */
        let height = bounds.maxY
        
        // the X value of the first NoteViews Rect.
        var noteX = CGFloat(0)
        
        // For all notes.
        for index in 0...NOTES_PER_STRING - 1 {
            
            // Calculate the X position.
            noteX = CGFloat(index * 75)
            // Build the rect and append
            //tempRects.append(CGRect(x: noteX, y: height * yMultiplier + sin(radians) * noteX , width: noteWidths[index], height: 25))
            tempRects.append(CGRect(x: noteX, y: height * yMultiplier , width: 80, height: 45))
        }
        
        // update RectArray.
        arrayOfNoteRects = tempRects
    }
    
    //#####################################
    // Builds the noteViewsArray.
    fileprivate func buildNoteViews() {
        
        // String index represents each guitar string. 0 is highest pitch, 5 is lowest.
     //   for stringIndex in 0...5 {
        let stringIndex = 0
            // rectIndex is the index of each notes rect on each guitar string.
            for noteIndex in 0...(NOTES_PER_STRING - 1) {
                let note = NoteView()
                
                let index = noteIndex + stringIndex * NOTES_PER_STRING
                
                // Update the appropriate frame.
                note.frame = arrayOfNoteRects[index]
                // Adjust fonts for frets with small widths.
                
                // The views number in the fretboard, for NoteView identification for Event notifications.
             //   note.viewNumberDict = ["number" : index]
                
                // If the NoteView isn't at the nut, rotate it.
             /*   if noteIndex != 0 {
                //    note.rotate(byDegrees: radians[stringIndex] * CGFloat(180/Double.pi))
                }
            */
               note.isOpaque = false
                arrayOfNoteViews.append(note)
            }
      //  }
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
        for index in 0...12  {
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

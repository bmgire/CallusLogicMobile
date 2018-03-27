//
//  FretboardModel.swift
//  CallusLogic
//
//  Copyright © 2016 Gire. All rights reserved.
//  This holds all the setting for creating a Fretboard. 

import UIKit


class FretboardModel: NSObject, NSCoding {
    
    let NOTES_PER_STRING = 13
    let NOTES_ON_FRETBOARD = 78
    let offset = 12
    
    // Offsets for toneNumber for each open string in standard tuning.
    let offsets = [12, 17, 22, 27, 31, 36]
    //##########################################################
    // MARK: - Variables
    //##########################################################


    // Variables that need to loaded whenever a fretboard is loaded.
    fileprivate var arrayOfNoteModels: [NoteModel] = []
    var rootNote = 4  // E
    var accidental = 0 // Natural
    var scaleIndexPath = IndexPath(row: 1, section: 0) // Minor Pentatonic.
    var chordIndexPath = IndexPath(row: 0, section: 0)
    
    var allowsCustomizations = false
    var doShowScales = true
    
    fileprivate var isLocked = false
    fileprivate var displayMode = 0
    fileprivate var userColor = UIColor.yellow
    fileprivate var fretboardTitle: String = "Untitled"
    
    //##########################################################
    // MARK: - Encoding
    //##########################################################
    func encode(with aCoder: NSCoder) {
        
        // Encode arrayOfNoteModels
        
        for index in 0...77 {
            aCoder.encode(arrayOfNoteModels[index], forKey: "noteModel\(index)")
        }
        aCoder.encode(rootNote, forKey: "rootNote")
        aCoder.encode(accidental, forKey: "accidental")
        aCoder.encode(scaleIndexPath, forKey: "scaleIndexPath")
        aCoder.encode(chordIndexPath, forKey: "chordIndexPath")
        
        aCoder.encode(allowsCustomizations, forKey: "allowsCustomizations")
        aCoder.encode(doShowScales, forKey: "showsScales")
        
        aCoder.encode(isLocked, forKey: "isLocked")
        aCoder.encode(displayMode, forKey: "displayMode")
        aCoder.encode(userColor, forKey: "userColor")
        aCoder.encode(fretboardTitle, forKey: "fretboardTitle")
    }
    
    
    //##########################################################
    // MARK: - Decoding
    //##########################################################
    required init?(coder aDecoder: NSCoder) {
        
        // Decode fretboardArray
        for index in 0...77 {
            if let noteModel = aDecoder.decodeObject(forKey: "noteModel\(index)"){
                arrayOfNoteModels.append(noteModel as! NoteModel)
            }
        }
        
        rootNote = aDecoder.decodeInteger(forKey: "rootNote")
        accidental = aDecoder.decodeInteger(forKey: "accidental")
        scaleIndexPath = aDecoder.decodeObject(forKey: "scaleIndexPath") as! IndexPath
        chordIndexPath = aDecoder.decodeObject(forKey: "chordIndexPath") as! IndexPath
        allowsCustomizations = aDecoder.decodeBool(forKey: "allowsCustomizations")
        doShowScales = aDecoder.decodeBool(forKey: "showsScales")
        
        isLocked = aDecoder.decodeBool(forKey: "isLocked")
        displayMode = aDecoder.decodeInteger(forKey: "displayMode")
        userColor = aDecoder.decodeObject(forKey: "userColor") as! UIColor
        fretboardTitle = aDecoder.decodeObject(forKey: "fretboardTitle") as! String
        
        super.init()
        // Set fret numbers when decoding, don't bother checking anything.
        setFretNumbers()
        
    }
    
    // Reqiured init.
    override init(){
        super.init()
        
        // If no encoded fretboardModel was loaded, build a fretboard model.
        if arrayOfNoteModels.count == 0 {
            // Build 77 item array of NoteModels.
            var temp : [NoteModel] = []
            for _ in 0...77 {
                temp.append(NoteModel())
            }
            swap(&arrayOfNoteModels, &temp)
        }
        setFretNumbers()
    }
    
    fileprivate func setFretNumbers() {
    
        var fret = 0
        for note in arrayOfNoteModels {
            note.setFretNumber(String(fret))
            fret += 1
            if fret == NOTES_PER_STRING {
                fret = 0
            }
        }
    }
    /* ArrayOfArrays order:
     0 = zeroTo11Array
     1 = zeroTo46Array
     2 = notesArray
     3 = intervalsArray
    */
    // Function takes an array of tone arrays and updates the appropriate noteModels.
    func loadNewNotesNumbersAndIntervals(_ anArrayOfToneArrays: [[String]]) {
        // For each string
        for stringIndex in 0...5 {
            // For each fret along the string.
            for fretIndex in 0...NOTES_PER_STRING - 1 {
                //get the array values and plug update the fretboard model.
                
                let toneIndex = fretIndex + offsets[stringIndex]
                let noteModel = arrayOfNoteModels[fretIndex  + stringIndex * NOTES_PER_STRING] //{
                
                noteModel.setNumber0to11(anArrayOfToneArrays[0][toneIndex])
                noteModel.setNumber0to36(anArrayOfToneArrays[1][toneIndex])
                noteModel.setNote(anArrayOfToneArrays[2][toneIndex])
                noteModel.setInterval(anArrayOfToneArrays[3][toneIndex])
                noteModel.setIsGhost(false)
                if noteModel.getNote() != "" {
                    noteModel.setIsDisplayed(true)
                    noteModel.setMyColor(userColor)
                } else {
                    noteModel.setIsDisplayed(false)
                }
            }
        }
    }
    

    
    // Used to add notes from chords. 
    func addNoteModels(newArray: [NoteModel]){
        for index in 0..<newArray.count {
            
            /*Find each newArray Model that is displayed
             and copy the values over. */
        
            let importModel = newArray[index]
            let modelToUpdate = arrayOfNoteModels[index]
            
            // Check for allows customization.
            // If allows customizations == true
            if allowsCustomizations {
                // if the newModel isDisplayed
                if importModel.getIsDisplayed() {
                    
                    // and if the modelToUpdate is not displayed or is a ghost,
                    if modelToUpdate.getIsDisplayed() == false || modelToUpdate.getIsGhost() {
                        copyModelData(importModel: importModel, modelToUpdate: modelToUpdate)
                    }
                }
            }
            // Otherwise, allowsCustomizations == false, update all fretboardModels.
            else {
                copyModelData(importModel: importModel, modelToUpdate: modelToUpdate)
            }
       }
    }


    
    func copyModelData(importModel: NoteModel, modelToUpdate: NoteModel) {
        modelToUpdate.setNumber0to11(importModel.getNumber0to11())
        modelToUpdate.setNumber0to36(importModel.getNumber0to36())
        modelToUpdate.setNote(importModel.getNote())
        modelToUpdate.setInterval(importModel.getInterval())
        modelToUpdate.setMyColor(userColor)
        modelToUpdate.setIsDisplayed(importModel.getIsDisplayed())
        if allowsCustomizations {
            modelToUpdate.setIsGhost(true)
        } else {
            modelToUpdate.setIsGhost(false)
        }
    }
    
    
    //var count = 0
    
    func removeNotesNotInChord(chordFormula: [String]) {
        // This function will be called after all noteModels (78 on a 12 fret 6 string guitar) have been created.
        
        // For each string
        for stringIndex in 0...5 {
            // Search all the frets for the interval.
            
            var noteHasNotBeenFound = true
            
            for fretIndex in 0..<NOTES_PER_STRING  {
                
                let noteModel = arrayOfNoteModels[fretIndex  + stringIndex * NOTES_PER_STRING]
                // If there is a note for the chord along that string.
                if chordFormula[stringIndex] == "" {
                    
                    noteModel.setIsDisplayed(false)
                    // Otherwise there is a note.
                    // Find the note and delete it.
                }   else {
                    
                    
                    
                    // only check notes that are displayed.
                    
                    if noteModel.getIsDisplayed() {
                        
                        // if the note hasn't been found yet.
                        if noteHasNotBeenFound {
                            
                            // Check for the interval.
                            // If the intervals don't match. set noteModel to not display.
                            if chordFormula[stringIndex] != noteModel.getInterval() {
                                // print("match has not been found")
                                noteModel.setIsDisplayed(false)
                            }
                                // Else the interval matches.
                            else {
                                noteHasNotBeenFound = false
                                //  print("note has been found")
                            }
                        }
                            // Else the note has been found, just set isDisplayed to false without checking.
                        else {
                            
                            noteModel.setIsDisplayed(false)
                            //print("match has not been found")
                        }
                    }
                }
            }
        }
    }
    
    func setIsGhostForAllDisplayedNoteModels(isGhost: Bool) {
        for model in arrayOfNoteModels {
            if model.getIsDisplayed() {
                model.setIsGhost(isGhost)
            }
        }
    }
    

    func clearGhostedNotes(){
        for model in arrayOfNoteModels {
            if model.getIsGhost() {
                model.setIsDisplayed(false)
            }
        }
    }
    
    func updateSingleNoteModel(modelNumber: Int, flipIsGhost: Bool, flipIsKept: Bool) {
        let model = arrayOfNoteModels[modelNumber]
        if flipIsGhost { model.flipIsGhost() }
        model.setMyColor(userColor)
    }
    
    
    //##########################################################
    // MARK: - Getters and Setters.
    //##########################################################
    func getFretboardArray()-> [NoteModel] {
        return arrayOfNoteModels
    }
    
    func getFretboardArrayCopy()-> [NoteModel] {
        var array:[NoteModel] = []
        
        for index in 0...(arrayOfNoteModels.count - 1) {
            
           
            let note = NoteModel()
            note.setNoteModel(arrayOfNoteModels[index])
            array.append(note)
        }
        
        return array
    }
    
    func setFretboardArray(_ newArray: [NoteModel]) {
        arrayOfNoteModels = newArray
    }
    
    func getFretboardTitle()-> String {
        return fretboardTitle
    }
    
    func setFretboardTitle(_ newTitle: String) {
        fretboardTitle = newTitle
    }
    
    func getUserColor()-> UIColor {
        return userColor
    }
    
    func setUserColor(_ newColor: UIColor) {
        userColor = newColor
    }
    
    func setIsLocked(_ state: Bool) {
        isLocked = state
    }
    func getIsLocked()->Bool {
        return isLocked
    }

    func setDisplayMode(index: Int) {
        displayMode = index
    }
    func getDisplayMode()->(Int) {
        return displayMode
    }

    func flipAllowsCustomizations() {
        allowsCustomizations = !allowsCustomizations
    }
}


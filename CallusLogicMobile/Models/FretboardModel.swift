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
    var scaleIndexPath = IndexPath(row: 0, section: 0) // Minor Pentatonic.
    var allowsCustomizations = false
    
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
        aCoder.encode(allowsCustomizations, forKey: "allowsCustomizations")
        
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
        allowsCustomizations = aDecoder.decodeBool(forKey: "allowsCustomization")
            
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
            // Build 138 item array of NoteModels.
            var temp : [NoteModel] = []
            for _ in 0...137 {
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
            // For each fret along the string. Total frets = 23 counting 0 as 1.
            for fretIndex in 0...NOTES_PER_STRING - 1 {
                //get the array values and plug update the fretboard model.
                
                let toneIndex = fretIndex + offsets[stringIndex]
                let noteModel = arrayOfNoteModels[fretIndex  + stringIndex * NOTES_PER_STRING] //{
                // If the noteModel isGhost update fretboard.
                if noteModel.getIsGhost() || allowsCustomizations == false {
                    noteModel.setNumber0to11(anArrayOfToneArrays[0][toneIndex])
                    noteModel.setNumber0to36(anArrayOfToneArrays[1][toneIndex])
                    noteModel.setNote(anArrayOfToneArrays[2][toneIndex])
                    noteModel.setInterval(anArrayOfToneArrays[3][toneIndex])
                }
            }
        }
    }
    
    
    func updateNoteModelDisplaySettings() {
        for model in arrayOfNoteModels {
            // If the note is an empty string, don't display and set to ghost.
            // Setting isGhost = true is precautionary.
            if model.getNote() == "" {
                model.setIsDisplayed(false)
                model.setIsGhost(true)
            }
            // Otherwise the note has a value.
            else {
                // Set that note needs to be displayed.
                model.setIsDisplayed(true)
                // If customizations are not allowed,
                // set isGhost = false (the note is selected)
                // set the userColor.
                if allowsCustomizations == false  {
                    model.setIsGhost(false)
                    model.setMyColor(userColor)
                }
                // otherwise customizations are allowed
                else {
                    // if isDisplayed = true
                    if model.getIsDisplayed(){
                        // and if does isGhost = true, set the color.
                        if model.getIsGhost() == true {
                            model.setMyColor(userColor)
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


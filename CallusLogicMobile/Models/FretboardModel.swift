//
//  FretboardModel.swift
//  CallusLogic
//
//  Copyright © 2016 Gire. All rights reserved.
//  This holds all the setting for creating a Fretboard. 

import UIKit


class FretboardModel /*: NSObject, NSCoding */ {
    
    let NOTES_PER_STRING = 13
    let NOTES_ON_FRETBOARD = 78
    let offset = 12
    
    // Offsets for toneNumber for each open string in standard tuning.
    let offsets = [12, 17, 22, 27, 31, 36]
    //##########################################################
    // MARK: - Variables
    //##########################################################
    
    // The array of noteModels that make up the fretboard.
    // why is this an optional
    fileprivate var arrayOfNoteModels: [NoteModel] = []
    
    // The fretboards Title
    fileprivate var fretboardTitle: String? = "Untitled"
    
   
    // The userColor for note selection.
    fileprivate var userColor = UIColor.yellow
    
    fileprivate var isLocked = true
    fileprivate var zoomLevel = 100.0
    fileprivate var showAdditionalNotes = 0
    
    fileprivate var displayMode = 0
    
    fileprivate var allowsGhostAll = false
    fileprivate var allowsSelectAll = false
    fileprivate var allowsClear = false
    
    var allowsCustomizations = false
    
    /*
    //##########################################################
    // MARK: - Encoding
    //##########################################################
    func encode(with aCoder: NSCoder) {
        
        // Encode fretboardArray.
        if let fretboardArray = fretboardArray {
            for index in 0...137 {
                aCoder.encode(fretboardArray[index], forKey: "noteModel\(index)")
            }
        }
        // Encode fretboardTitle.
        if let fretboardTitle = fretboardTitle {
            aCoder.encode(fretboardTitle, forKey: "fretboardTitle")
        }
        // Encode userColor.
        if let userColor = userColor {
            aCoder.encode(userColor, forKey: "userColor")
        }
        // Encode isLocked.
        aCoder.encode(isLocked, forKey: "isLocked")
        
        //Encode zoomLevel
        aCoder.encode(zoomLevel, forKey: "zoomLevel")
        
        // Encode showAdditionalNotes.
        aCoder.encode(showAdditionalNotes, forKey: "showAdditionalNotes")
        
        
        // Encode displayMode.
        aCoder.encode(displayMode, forKey: "displayMode")
    
        aCoder.encode(allowsGhostAll, forKey: "allowsGhostAll")
        aCoder.encode(allowsSelectAll, forKey: "allowsSelectAll")
        aCoder.encode(allowsClear, forKey: "allowsClear")
    }
    
    
    //##########################################################
    // MARK: - Decoding
    //##########################################################
    required init?(coder aDecoder: NSCoder) {
        
        // Decode fretboardArray
        for index in 0...137 {
            if let noteModel = aDecoder.decodeObject(forKey: "noteModel\(index)"){
                fretboardArray!.append(noteModel as! NoteModel)
            }
        }
        
        // Decode fretboardTitle
        fretboardTitle = aDecoder.decodeObject(forKey: "fretboardTitle") as! String?
        
        userColor = aDecoder.decodeObject(forKey: "userColor") as! NSColor?
        
        // Decode isLocked.
        isLocked = aDecoder.decodeInteger(forKey: "isLocked")
        
        // Decode zoomLevel
        // Check for the coded value, if available, decode... else it's set to 100.
        if aDecoder.containsValue(forKey: "zoomLevel") {
            zoomLevel = aDecoder.decodeDouble(forKey: "zoomLevel")
        }

        showAdditionalNotes = aDecoder.decodeInteger(forKey: "showAdditionalNotes")
        displayMode = aDecoder.decodeInteger(forKey: "displayMode")
        
        allowsGhostAll = aDecoder.decodeBool(forKey: "allowsGhostAll")
        allowsSelectAll = aDecoder.decodeBool(forKey: "allowsSelectAll")
        allowsClear = aDecoder.decodeBool(forKey: "allowsClear")
        
        super.init()
        // Set fret numbers when decoding, don't bother checking anything.
        setFretNumbers()
        
    }
    
    // Reqiured init.
    override init(){
        super.init()
        
        // If no encoded fretboardModel was loaded, build a fretboard model.
        if fretboardArray!.count == 0 {
            // Build 138 item array of NoteModels.
            var temp : [NoteModel] = []
            for _ in 0...137 {
                temp.append(NoteModel())
            }
            fretboardArray = temp
        }
        setFretNumbers()
    }
    */
    
    init() {
        // If no encoded fretboardModel was loaded, build a fretboard model.
       
        if arrayOfNoteModels.count == 0 {
            // Build 138 item array of NoteModels.
            var temp : [NoteModel] = []
            for _ in 0...NOTES_ON_FRETBOARD - 1 {
                temp.append(NoteModel())
            }
            arrayOfNoteModels = temp
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
                    noteModel.setNumber0to46(anArrayOfToneArrays[1][toneIndex])
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
                
                // Otherwise set to isDisplayed for some reason?
              //  model.setIsDisplayed(true)
                // If the note is ghosted and has a value, update the color.
                
                

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
    
    
    
    func lockOrUnlockFretboard(yesOrNo: Bool){
        for noteModel in arrayOfNoteModels {
            noteModel.isLocked = yesOrNo
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
        return fretboardTitle!
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
    
    func setZoomLevel(_ level: Double) {
        zoomLevel = level
    }
    
    func getZoomLevel()-> Double {
        return zoomLevel
    }
    
    func setShowAdditionalNotes(_ int: Int) {
        showAdditionalNotes = int
    }
    func getShowAdditionalNotes()->Int {
        return showAdditionalNotes
    }
    
    func setDisplayMode(_ index: Int) {
        displayMode = index
    }
    func getDisplayMode()->Int {
        return displayMode
    }

    func setAllowsGhostAll(_ bool: Bool) {
        allowsGhostAll = bool
    }
    
    func getAllowsGhostAll()-> Bool {
        return allowsGhostAll
    }
    
    func setAllowsSelectAll(_ bool: Bool) {
        allowsSelectAll = bool
    }
    
    func getAllowsSelectAll()-> Bool {
        return allowsSelectAll
    }
    
    func setAllowsClear(_ bool: Bool) {
        allowsClear = bool
    }
    
    func getAllowsClear()-> Bool {
        return allowsClear
    }
    func flipAllowsCustomizations() {
        allowsCustomizations = !allowsCustomizations
    }
}


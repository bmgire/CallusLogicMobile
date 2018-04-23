//
//  FretboardModel.swift
//  CallusLogic
//
//  Copyright © 2016 Gire. All rights reserved.
//  This holds all the setting for creating a Fretboard. 

import UIKit


class FretboardModel: NSObject, NSCoding {
    
  //  let NOTES_PER_STRING = 15
  //  let NOTES_ON_FRETBOARD = 90
  //  let offset = 12
    
    // Offsets for toneNumber for each open string in standard tuning.
    let offsets = [12, 17, 22, 27, 31, 36]
    //##########################################################
    // MARK: - Variables
    //##########################################################


    // Variables that need to loaded whenever a fretboard is loaded.
    fileprivate var arrayOfNoteModels: [NoteModel] = []
    
    var scaleSettings = RootScaleAndDisplaySelections(root: "E", accidental: "Natural", scaleOrChord: "Minor Pentatonic", displayMode: DisplayMode.notes)
    var chordSettings = RootScaleAndDisplaySelections(root: "E", accidental: "Natural", scaleOrChord: "Major Chord (v1)", displayMode: DisplayMode.notes)
    var basicChordSettings = RootScaleAndDisplaySelections(root: "NA", accidental: "NA", scaleOrChord: "A Chord", displayMode: DisplayMode.notes)
    
    var allowsCustomizations = false
    var doShowScales = 0
    
    fileprivate var isLocked = false

    fileprivate var userColor = UIColor.yellow
    fileprivate var fretboardTitle: String = "Untitled"
    
    //##########################################################
    // MARK: - Encoding
    //##########################################################
    func encode(with aCoder: NSCoder) {
        
        // Encode arrayOfNoteModels
        
        for index in 0...FretboardValues.totalNotesOnFretboard.rawValue - 1 {
            aCoder.encode(arrayOfNoteModels[index], forKey: "noteModel\(index)")
        }
        
        aCoder.encode(scaleSettings, forKey: "scaleSettings")
        aCoder.encode(chordSettings, forKey: "chordSettings")
        aCoder.encode(basicChordSettings, forKey: "basicChordSettings")
        
        aCoder.encode(allowsCustomizations as Bool?, forKey: "allowsCustomizations")
        aCoder.encode(doShowScales as Int?, forKey: "showsScales")
        
        //aCoder.encode(doShowScales as Int?, forKey: "test")
        
        aCoder.encode(isLocked as Bool?, forKey: "isLocked")
       // aCoder.encode(displayMode as Int?, forKey: "displayMode")
        aCoder.encode(userColor as UIColor?, forKey: "userColor")
        aCoder.encode(fretboardTitle as String?, forKey: "fretboardTitle")
    }
    
    
    //##########################################################
    // MARK: - Decoding
    //##########################################################
    required init?(coder aDecoder: NSCoder) {
        
        //var tempArrayOfNoteModels = [NoteModel]()
        // Decode fretboardArray
        for index in 0...FretboardValues.totalNotesOnFretboard.rawValue - 1 {
            
            if let noteModel = aDecoder.decodeObject(forKey: "noteModel\(index)") as? NoteModel {
                arrayOfNoteModels.append(noteModel)
            }
          /*  else {
                arrayOfNoteModels.append(NoteModel())
            } */
            
        }
    
        // Check the number of arrays written to the tempArrayOfNoteModels
        let count = arrayOfNoteModels.count
        
        // If the number doesn't match what is needed. Insert new NoteModels.
        if count != FretboardValues.totalNotesOnFretboard.rawValue {
            // If count is for 12 Notes
            if count == FretboardValues.twelveFretsTotalNotesOnFretboard.rawValue {
                
                let neededNotesPerString = FretboardValues.notesPerString.rawValue
                let insertPosition = FretboardValues.twelveFretsNotesPerString.rawValue
                
                for stringIndex in 0...5 {
                   
                    for insertAddition in 0...2 {
                        let location = neededNotesPerString * stringIndex + insertPosition + insertAddition
                        arrayOfNoteModels.insert(NoteModel(), at: location)
                    }
                }
            }
        }

        if let scaleSettings = aDecoder.decodeObject(forKey: "scaleSettings") as? RootScaleAndDisplaySelections {
            self.scaleSettings = scaleSettings
        }
        if let chordSettings = aDecoder.decodeObject(forKey: "chordSettings") as? RootScaleAndDisplaySelections {
            self.chordSettings = chordSettings
        }
        
        if let basicChordSettings = aDecoder.decodeObject(forKey: "basicChordSettings") as? RootScaleAndDisplaySelections {
            self.basicChordSettings = basicChordSettings
        }
        
        if let allowsCustomizations = aDecoder.decodeObject(forKey: "allowsCustomizations") as? Bool {
            self.allowsCustomizations = allowsCustomizations
        }
        
        if let doShowScales = aDecoder.decodeObject(forKey: "showsScales") as? Int {
            self.doShowScales = doShowScales
        }

        
        if let isLocked = aDecoder.decodeObject(forKey: "isLocked") as? Bool {
            self.isLocked = isLocked
        }
        
        if let userColor = aDecoder.decodeObject(forKey: "userColor") as? UIColor  {
            self.userColor = userColor
        }
        
        if let fretboardTitle = aDecoder.decodeObject(forKey: "fretboardTitle") as? String {
            self.fretboardTitle = fretboardTitle
        }
        
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
            for _ in 0...FretboardValues.totalNotesOnFretboard.rawValue - 1 {
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
            if fret == FretboardValues.notesPerString.rawValue {
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
            for fretIndex in 0...FretboardValues.notesPerString.rawValue - 1 {
                //get the array values and plug update the fretboard model.
                
                let toneIndex = fretIndex + offsets[stringIndex]
                let noteModel = arrayOfNoteModels[fretIndex  + stringIndex * FretboardValues.notesPerString.rawValue] //{
                
                noteModel.setNumber0to11(anArrayOfToneArrays[0][toneIndex])
                noteModel.setNumber0to39(anArrayOfToneArrays[1][toneIndex])
                noteModel.setNote(anArrayOfToneArrays[2][toneIndex])
                noteModel.setInterval(anArrayOfToneArrays[3][toneIndex])
                noteModel.setChordFinger("")
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
        modelToUpdate.setNumber0to39(importModel.getNumber0to39())
        modelToUpdate.setNote(importModel.getNote())
        modelToUpdate.setInterval(importModel.getInterval())
        modelToUpdate.setChordFinger(importModel.getChordFinger())
        modelToUpdate.setMyColor(userColor)
        modelToUpdate.setIsDisplayed(importModel.getIsDisplayed())
        if allowsCustomizations {
            modelToUpdate.setIsGhost(true)
        } else {
            modelToUpdate.setIsGhost(false)
        }
    }
    
    

    
    
    
    
    
    
    
    
   // ##################################################
    
    func removeNotesNotInChord(chordFormula: [String], chordFingering: [String]) {
        // This function will be called after all noteModels (78 on a 12 fret 6 string guitar) have been created.
        
        // For each string
        for stringIndex in 0...5 {
            // Search all the frets for the interval.
            var noteHasNotBeenFound = true
            
            for fretIndex in 0..<FretboardValues.notesPerString.rawValue {
                
                let noteModel = arrayOfNoteModels[fretIndex  + stringIndex * FretboardValues.notesPerString.rawValue]
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
                                noteModel.setChordFinger(chordFingering[stringIndex])
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
        fixChordNoteSpacingIssues()
    }
    
    
    // ##################################################
    func fixChordNoteSpacingIssues() {
        
        var arrayOfFretNumbers = [Int]()
        
        // Obtain all noteModels in chord.
        // Create arrayOfFretNumbers
        for model in arrayOfNoteModels {
            if model.getIsDisplayed() {
                if let number = Int(model.getFretNumber()) {
                    arrayOfFretNumbers.append(number)
                }   else {
                    print("Error in \(#function): failed to convert fretnumber to Int")
                }
            }
        }
        
        // Get the different in numbers.
        // Confirm no distance is greater than 4.
        arrayOfFretNumbers.sort()
        let difference = arrayOfFretNumbers.first! - arrayOfFretNumbers.last!
        
        // If the difference between the notes is
        if abs(difference) > 4 {
            // fix the spacing.
        // Find the notes on the zero fret and move to the 12th.
            for index in 0..<arrayOfNoteModels.count {
                let noteModel = arrayOfNoteModels[index]
                let fretNumber = noteModel.getFretNumber()
                // If the noteModel is displayed and the fretnumber value is "0" or "1"
                if noteModel.getIsDisplayed() &&
                    (fretNumber == "0" || fretNumber == "1" || fretNumber == "2" || fretNumber == "3") {
                    // Do note display noteModel
                    noteModel.setIsDisplayed(false)
                    // Do display the model 1 octave up.
                    let modelToDisplay = arrayOfNoteModels[index + 12]
                    modelToDisplay.setIsDisplayed(true)
                    modelToDisplay.setChordFinger(noteModel.getChordFinger())
                    
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

    func flipAllowsCustomizations() {
        allowsCustomizations = !allowsCustomizations
    }
}


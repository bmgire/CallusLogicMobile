//
//  noteModel.swift
//  StringNotesCalculator
//
//  Copyright © 2016 Gire. All rights reserved.
//  Model for the NoteView. 

import UIKit
class NoteModel : NSObject, NSCoding {
    
   // The position of the note on the entire fretboard. 0-77
    fileprivate var note = ""
    fileprivate var number0to11 = ""
    fileprivate var number0to36 = ""
    fileprivate var interval = ""
    fileprivate var fretNumber = ""
    fileprivate var chordFinger = ""
    
    fileprivate var isGhost = false
    fileprivate var isDisplayed = false
    fileprivate var isPassingNote = false
    
    fileprivate var myColor: UIColor = UIColor.red

     
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(note as String?, forKey: "note")
        aCoder.encode(number0to11 as String?, forKey: "number0to11")
        aCoder.encode(number0to36 as String?, forKey: "number0to36")
        aCoder.encode(interval as String?, forKey: "interval")
        aCoder.encode(fretNumber as String?, forKey: "fretNumber")
        aCoder.encode(chordFinger as String?, forKey: "chordFinger")
        
        aCoder.encode(isGhost as Bool?, forKey: "isGhost")
        aCoder.encode(isDisplayed as Bool?, forKey: "isDisplayed")
        aCoder.encode(isPassingNote as Bool?, forKey: "isPassingNote")
        aCoder.encode(myColor as UIColor?, forKey: "myColor")
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let note = aDecoder.decodeObject(forKey: "note") as? String {
            self.note = note
        }
        
        if let number0to11 = aDecoder.decodeObject(forKey: "number0to11") as? String {
            self.number0to11 = number0to11
        }
        
        if let number0to36 = aDecoder.decodeObject(forKey: "number0to36") as? String {
            self.number0to36 = number0to36
        }
        if let interval = aDecoder.decodeObject(forKey: "interval") as? String {
            self.interval = interval
        }
        if let fretNumber = aDecoder.decodeObject(forKey: "fretNumber") as? String {
            self.fretNumber = fretNumber
        }
        
        if let chordFinger = aDecoder.decodeObject(forKey: "chordFinger") as? String {
            self.chordFinger = chordFinger
        }
        
        if let isGhost = aDecoder.decodeObject(forKey: "isGhost") as? Bool {
            self.isGhost = isGhost
        }
        
        if let isDisplayed = aDecoder.decodeObject(forKey: "isDisplayed") as? Bool {
            self.isDisplayed = isDisplayed
        }
        if let isPassingNote = aDecoder.decodeObject(forKey: "isPassingNote") as? Bool {
            self.isPassingNote = isPassingNote
        }
        if let myColor = aDecoder.decodeObject(forKey: "myColor") as? UIColor {
            self.myColor = myColor
        }
        
        super.init()
    }
    
    override init() {
        super.init()
    }

    //####################################
    // Getters and setters.
    //####################################
    func getNote()-> String {
        return note
    }
    
    func setNote(_ newNote: String) {
        note = newNote
    }
    
    func getNumber0to11()-> String {
        return number0to11
    }
    
    func setNumber0to11(_ newNumber: String) {
        number0to11 = newNumber
    }
    
    func getNumber0to36()-> String {
        return number0to36
    }
    
    func setNumber0to36(_ newNumber: String) {
        number0to36 = newNumber
    }
    
    func getInterval()-> String {
        return interval
    }
    
    func setInterval(_ newInterval: String) {
        interval = newInterval
    }
    
    func getFretNumber()-> String {
        return fretNumber
    }
    
    func setFretNumber(_ newFretNumber: String) {
        fretNumber = newFretNumber
    }
    
    func getChordFinger()-> String {
        return chordFinger
    }
    
    func setChordFinger(_ newFinger: String) {
        chordFinger = newFinger
    }
    
    func getIsGhost()-> Bool {
        return isGhost
    }
    
    func setIsGhost(_ bool: Bool) {
        isGhost = bool
    }
    
    func getIsDisplayed()-> Bool {
        return isDisplayed
    }
    
    func setIsDisplayed(_ bool: Bool) {
        isDisplayed = bool
    }

    func getMyColor() -> UIColor {
        return myColor
    }
    
    func setMyColor(_ newColor: UIColor){
        myColor = newColor
    }

    func flipIsGhost(){
        isGhost = !isGhost
    }
    
    
    
    func setNoteModel(_ newModel: NoteModel) {
        note = newModel.getNote()
        number0to11 = newModel.getNumber0to11()
        number0to36 = newModel.getNumber0to36()
        interval = newModel.getInterval()
        if newModel.fretNumber != ""{
          fretNumber = newModel.getFretNumber()
        }
        isGhost = newModel.getIsGhost()
        isDisplayed = newModel.getIsDisplayed()
        myColor = newModel.getMyColor()
    }
}

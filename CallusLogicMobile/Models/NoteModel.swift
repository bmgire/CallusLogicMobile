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
    
    fileprivate var isGhost = true
    fileprivate var isDisplayed = false
    fileprivate var isPassingNote = false
    
    fileprivate var myColor: UIColor = UIColor.red

     
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(note, forKey: "note")
        aCoder.encode(number0to11, forKey: "number0to11")
        aCoder.encode(number0to36, forKey: "number0to36")
        aCoder.encode(interval, forKey: "interval")
        aCoder.encode(fretNumber, forKey: "fretNumber")
        
        aCoder.encode(isGhost, forKey: "isGhost")
        aCoder.encode(isDisplayed, forKey: "isDisplayed")
        aCoder.encode(isPassingNote, forKey: "isPassingNote")
        aCoder.encode(myColor, forKey: "myColor")
    }
    
    required init?(coder aDecoder: NSCoder) {
        note = aDecoder.decodeObject(forKey: "note") as! String
        number0to11 = aDecoder.decodeObject(forKey: "number0to11") as! String
        number0to36 = aDecoder.decodeObject(forKey: "number0to36") as! String
        interval = aDecoder.decodeObject(forKey: "interval") as! String
        fretNumber = aDecoder.decodeObject(forKey: "interval") as! String
        
        isGhost = aDecoder.decodeBool(forKey: "isGhost")
        isDisplayed = aDecoder.decodeBool(forKey: "isDisplayed")
        isPassingNote = aDecoder.decodeBool(forKey: "isPassingNote")
        myColor = aDecoder.decodeObject(forKey: "myColor") as! UIColor
        
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
    
    func getIsPassingNote()-> Bool {
        return isPassingNote
    }
    
    func setIsPassingNote(_ bool: Bool) {
        isPassingNote = bool
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

    func makePassingNote(_ bool: Bool) {
        if bool {
            note = addParentheses(note)
            number0to11 = addParentheses(number0to11)
            number0to36 = addParentheses(number0to36)
            interval = addParentheses(interval)
            if fretNumber != "" {
                fretNumber = addParentheses(fretNumber)
            }
        }
        else {
            note = removeParentheses(note)
            number0to11 = removeParentheses(number0to11)
            number0to36 = removeParentheses(number0to36)
            interval = removeParentheses(interval)
            fretNumber = removeParentheses(fretNumber)
            if fretNumber != "" {
                fretNumber = removeParentheses(fretNumber)
           }
        }
    }
    
    fileprivate func addParentheses(_ theNote: String)-> String {
        var temp = "("
        temp = temp + theNote
        temp = temp + ")"
        print(temp)
        return temp
    }
    
    // note being used yet.
    fileprivate func removeParentheses(_ theString: String)->String {
        var temp = theString
        
        let begin = temp.startIndex
        let end = temp.endIndex
        
        temp.remove(at: end)
        temp.remove(at: begin)
        return temp
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
        isPassingNote = newModel.getIsPassingNote()
        myColor = newModel.getMyColor()
    }
}

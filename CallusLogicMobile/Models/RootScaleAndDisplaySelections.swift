//
//  RootScaleAndDisplaySelections.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 4/3/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import UIKit

class RootScaleAndDisplaySelections: NSObject, NSCoding {
    
    var root = ""
    var accidental = ""
    var scaleOrChord = ""
    // Specifying the data type just to be extra clear.
    var displayMode: DisplayMode = DisplayMode.notes
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(root as String? , forKey: "root")
        aCoder.encode(accidental as String? , forKey: "accidental")
        aCoder.encode(scaleOrChord as String?, forKey: "scaleOrChord")
        
        let rawDisplayMode = displayMode.rawValue
        aCoder.encode(rawDisplayMode as String?, forKey: "rawDisplayMode")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let root = aDecoder.decodeObject(forKey: "root") as? String {
            self.root = root
        }
        if let accidental = aDecoder.decodeObject(forKey: "accidental") as? String {
            self.accidental = accidental
        } 
        if let scaleOrChord = aDecoder.decodeObject(forKey: "scaleOrChord") as? String {
            self.scaleOrChord = scaleOrChord
        }
        
        // if let to get the DisplayMode as a string.
        if let rawDisplayMode = aDecoder.decodeObject(forKey: "rawDisplayMode") as? String {
            // Convert the string displayMode into the enum.
            if let displayMode = DisplayMode(rawValue: rawDisplayMode) {
                self.displayMode = displayMode
            }
            // For updating previous versions of the app. 
            // If the DisplayMode rawValue conversion didn't work,
            // it's likely because the user is had the 0-36 number rather than the 0to39 number enum.
            // Check the text, if it is 0-36, use the 0-39
            else if rawDisplayMode == "Numbers 0-36" {
                self.displayMode = DisplayMode.numbers0to39
                
            }
        }
    }
    
  
    
    init(root: String, accidental: String, scaleOrChord: String, displayMode: DisplayMode) {
        self.root = root
        self.accidental = accidental
        self.scaleOrChord = scaleOrChord
        self.displayMode = displayMode
    }
   
    override convenience init() {
        self.init(root: "", accidental: "", scaleOrChord: "", displayMode: DisplayMode.notes)
    }
}

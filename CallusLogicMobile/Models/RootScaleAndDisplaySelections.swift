//
//  RootScaleAndDisplaySelections.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 4/3/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import Foundation

class RootScaleAndDisplaySelections {
    var root = ""
    var accidental = ""
    var scaleOrChord = ""
    // Specifying the data type just to be extra clear. 
    var displayMode: DisplayMode = DisplayMode.notes
    
    init(root: String, accidental: String, scaleOrChord: String, displayMode: DisplayMode) {
        self.root = root
        self.accidental = accidental
        self.scaleOrChord = scaleOrChord
        self.displayMode = displayMode
    }
    init() {
        
    }
}

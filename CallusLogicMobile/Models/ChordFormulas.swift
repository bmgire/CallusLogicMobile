//
//  ChordFormulas.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 3/23/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import Foundation


class ChordFormulas {
    
    var arrayOfArraysOfChordFormulas = [[String]]()
    var arrayOfChordNames = [String]()
    var dictOfChordNamesAndFormulas = [ String : [String] ]()
    
    init() {
        let minor_OnLowE = [ "root", "P5", "root", "m3", "P5", "root"]
        arrayOfArraysOfChordFormulas.append(minor_OnLowE)
        //arrayOfChordNames.append("Minor_OnLowE")
        arrayOfChordNames.append("Minor Chord (Root: Low E String)")
        dictOfChordNamesAndFormulas[arrayOfChordNames[0]] = arrayOfArraysOfChordFormulas[0]
    }
    
}

//
//  ViewController.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 12/11/17.
//  Copyright © 2017 Gire. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let ROW_HEIGHT = 30
    let ROOT_WIDTH = 50
    let ACCIDENTAL_WIDTH = 90
    let SCALE_WIDTH = 280
    let DISPLAYMODE_WIDTH = 180
    
    let toneArraysCreator = ToneArraysCreator()
 
    let arrrayOfDisplayModes = ["Notes", "Fret Numbers","Intervals", "Numbers 0-11", "Numbers 0-36"]
    let arrayOfRootNotes = ["A", "B", "C", "D", "E", "F", "G"]
    let arrayOfAccidentals = ["Natural", "b", "#" ]
    var arrayOfScaleNames = [String]()
    
    fileprivate var fretboardModelArray: [FretboardModel] = [FretboardModel()] /*{
        didSet {
            
            tableView?.reloadData()
            
        }
    }  */
    
    fileprivate var model = FretboardModel()
    
    fileprivate var modelIndex: Int = 0 {
        didSet{
            model = fretboardModelArray[modelIndex]
        }
    }
    
    
    @IBOutlet weak var rootPickerView: UIPickerView!
    @IBOutlet weak var accidentalPickerView: UIPickerView!
    @IBOutlet weak var scalePickerView: UIPickerView!
    
    @IBOutlet weak var addNotes: UIButton!
    @IBOutlet weak var displayModePickerView: UIPickerView!
    
    @IBOutlet weak var fretboardView: FretboardView!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buildArrayOfScaleNames()
        rootPickerView.selectRow(4, inComponent: 0, animated: false)
        scalePickerView.selectRow(21, inComponent: 0, animated: false)
 
        }
    
    // viewDidLayoutSubviews means autolayout has been applied and you can draw with bounds information.
 
    override func viewDidLayoutSubviews() {
        // update lengths and heights of noteview drawing.
        fretboardView.buildNoteRects()
        fretboardView.buildNoteViews()
        fretboardView.addSubviews()
        addNotesAction(addNotes)
    }
    
    @IBAction func addNotesAction(_ sender: UIButton){
        updateToneArraysCreator()
        updatefretboardModel()
    }
    func updateToneArraysCreator() {
        
        let arrayOfPickerStrings = getPickerValues()
        
        toneArraysCreator.updateWithValues(arrayOfPickerStrings[0],
                                           accidental: arrayOfPickerStrings[1],
                                           scaleName: arrayOfPickerStrings[2])
    }
    
    fileprivate func getPickerValues()->[String] {
  
        let rootRow = rootPickerView.selectedRow(inComponent: 0)
        let root = pickerView(rootPickerView, titleForRow: rootRow, forComponent: 0)!
        
        let accidentalRow = accidentalPickerView.selectedRow(inComponent: 0)
        let accidental = pickerView(accidentalPickerView, titleForRow: accidentalRow, forComponent: 0)!
        
        let scaleRow = scalePickerView.selectedRow(inComponent: 0)
        let scale = pickerView(scalePickerView, titleForRow: scaleRow, forComponent: 0)!
 
        
        
        var arrayOfStrings = [String]()
        arrayOfStrings.append(root)
        arrayOfStrings.append(accidental)
        arrayOfStrings.append(scale)
        return arrayOfStrings
    }
    

    func updatefretboardModel() {
        model.updateNoteModels(toneArraysCreator.getArrayOfToneArrays(), isInScale: true)
        
        fillSpacesWithChromatic()
        
      //  updateDisplayModeAction(displayModePopUp)
        
        model.showNotesOnFretboard(true, _isDisplayed: true, _isGhosted: true)
        
        updateFretboardView()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //#######################
/*
    fileprivate func setupPickerDataAndView(_  pickerView: UIPickerView,
                                            dataModel: PickerDataModel,
                                            array: [String],
                                            width: Int){
        // Set dataModels array
        dataModel.setDataArray(array)
        dataModel.setWidth(newWidth: width)
        // Set Delegate and DataSource
        pickerView.delegate = dataModel
        pickerView.dataSource = dataModel
        
    }
  */
    // Adds the scale names to the Scale PopUp
    func buildArrayOfScaleNames(){
        let scalesDict = ScalesByIntervals()
        for index in 0...(scalesDict.getScaleArray().count - 1){
            arrayOfScaleNames.append(scalesDict.getScaleArray()[index].getScaleName())
        }
    }
    
    func updateFretboardView() {
        // Close the color panel if still open.
        let displayModeRow = displayModePickerView.selectedRow(inComponent: 0)
        let displayMode = pickerView(displayModePickerView, titleForRow: displayModeRow, forComponent: 0)
        
        fretboardView.updateSubviews(model.getFretboardArray(), displayMode: displayMode!)
    }
   
    func fillSpacesWithChromatic()
    {
        
          let arrayOfPickerStrings = getPickerValues()
        toneArraysCreator.updateWithValues(arrayOfPickerStrings[0],
                                           accidental: arrayOfPickerStrings[1],
                                           scaleName: "Chromatic Scale")
        model.updateNoteModels(toneArraysCreator.getArrayOfToneArrays(), isInScale: false)
    }
    
    //##############################################
    // UIPickerView Data Model and Delegate funcs
    
    //#######################
    // UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
        case rootPickerView:
            return arrayOfRootNotes.count
        case accidentalPickerView:
            return arrayOfAccidentals.count
        case scalePickerView:
            return arrayOfScaleNames.count
        default:
            return arrrayOfDisplayModes.count
        }

    }
    
    //#######################
    // UI PickerViewDelegate
    //#######################
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(30)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch pickerView {
            case rootPickerView:
            return CGFloat(ROOT_WIDTH)
            
            case accidentalPickerView:
            return CGFloat(ACCIDENTAL_WIDTH)
            
            case scalePickerView:
            return CGFloat(SCALE_WIDTH)
            
            default:
            return CGFloat(DISPLAYMODE_WIDTH)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        // Include an if depending on the picker view selected
        
        switch pickerView {
        case rootPickerView:
            return arrayOfRootNotes[row]
        case accidentalPickerView:
            return arrayOfAccidentals[row]
        case scalePickerView:
            return arrayOfScaleNames[row]
        default:
            return arrrayOfDisplayModes[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        if pickerView == displayModePickerView {
            // update fretboardview with that display setting.
            updateFretboardView()
        }
    }
    
    
    
    
}


//
//  ViewController.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 12/11/17.
//  Copyright © 2017 Gire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let toneArraysCreator = ToneArraysCreator()
 
    let arrrayOfDisplayModes = ["Notes", "Fret Numbers","Intervals", "Numbers 0-11", "Numbers 0-46"]
    let arrayOfRootNotes = ["A", "B", "C", "D", "E", "F", "G"]
    let arrayOfAccidentals = ["Natural", "b", "#" ]
    var arrayOfScaleNames = [String]()
    
    
    var rootPickerData = PickerDataModel()
    var accidentalPickerData = PickerDataModel()
    var scalePickerData = PickerDataModel()
    var displayModePickerData = PickerDataModel()
    
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
        
        setupPickerDataAndView(rootPickerView, dataModel: rootPickerData, array: arrayOfRootNotes, width: 50)
        setupPickerDataAndView(accidentalPickerView, dataModel: accidentalPickerData, array: arrayOfAccidentals, width:90)
        buildArrayOfScaleNames()
        setupPickerDataAndView(scalePickerView, dataModel: scalePickerData, array: arrayOfScaleNames, width: 280)
        setupPickerDataAndView(displayModePickerView, dataModel: displayModePickerData, array: arrrayOfDisplayModes, width: 120)
        
        addNotesAction(addNotes)
        
        }
    
    @IBAction func addNotesAction(_ sender: UIButton){
        updateToneArraysCreator()
        updatefretboardModel()
    }
    func updateToneArraysCreator() {
        // Update Model with current values.
        let rootRow = rootPickerView.selectedRow(inComponent: 0)
        let root = rootPickerData.pickerView(rootPickerView, titleForRow: rootRow, forComponent: 0)
      
        let accidentalRow = accidentalPickerView.selectedRow(inComponent: 0)
        let accidental = accidentalPickerData.pickerView(accidentalPickerView, titleForRow: accidentalRow, forComponent: 0)
        
        let scaleRow = scalePickerView.selectedRow(inComponent: 0)
        let scale = scalePickerData.pickerView(scalePickerView, titleForRow: scaleRow, forComponent: 0)
        
        toneArraysCreator.updateWithValues(root!,
                                           accidental: accidental!,
                                           scaleName: scale!)
    }

    func updatefretboardModel() {
        model.updateNoteModels(toneArraysCreator.getArrayOfToneArrays(), isInScale: true)
        
        //fillSpacesWithChromatic()
        
      //  updateDisplayModeAction(displayModePopUp)
        
        model.showNotesOnFretboard(true, _isDisplayed: true, _isGhosted: true)
        
        updateFretboardView()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //#######################
    
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
    
    // Adds the scale names to the Scale PopUp
    func buildArrayOfScaleNames(){
        let scalesDict = ScalesByIntervals()
        for index in 0...(scalesDict.getScaleArray().count - 1){
            arrayOfScaleNames.append(scalesDict.getScaleArray()[index].getScaleName())
        }
    }
    
    func updateFretboardView() {
        // Close the color panel if still open.
        //NSColorPanel.shared.close()
        
        let displayModeRow = displayModePickerView.selectedRow(inComponent: 0)
        let displayMode = displayModePickerData.pickerView(displayModePickerView, titleForRow: displayModeRow, forComponent: 0)
        
        fretboardView.updateSubviews(model.getFretboardArray(), displayMode: displayMode!)
    }
    
}


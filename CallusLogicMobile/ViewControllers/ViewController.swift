//
//  ViewController.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 12/11/17.
//  Copyright © 2017 Gire. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPopoverPresentationControllerDelegate, ScalesTVCDelegate {

    
    //###################################
    // Integer Constants
    let ROW_HEIGHT = 30
    let ROOT_WIDTH = 50
    let ACCIDENTAL_WIDTH = 90
    let SCALE_WIDTH = 280
    let DISPLAYMODE_WIDTH = 180
    
    //###################################
    // Array Constants
    //############
    
    let toneArraysCreator = ToneArraysCreator()
    let arrrayOfDisplayModes = ["Notes", "Fret Numbers","Intervals", "Numbers 0-11", "Numbers 0-36"]
    let arrayOfRootNotes = ["A", "B", "C", "D", "E", "F", "G"]
    let arrayOfAccidentals = ["Natural", "b", "#" ]
    
    //###################################
    // Array Variables
    //############
    
    // The names of all selectable scales.
    // Is a variable because of the pointer swap in viewDidLoad()
  
     //  var arrayOfScaleNames = [String]()
    
    // Variable to keep track of views updated during a single view track event.
    // Is a dictionary of view IDs and Bools.
    // Bool: yes = canUpdate.
    // If I exited the views bounds, I can can update it,
    // if I didn't leave the bounds, I cannot update.
    var dictOfTouchedNoteViewNumbers = [Int: Bool]()
    
 
    
    let sixTonesController = SixTones()
    
    fileprivate var arrayOfTableViewCells = [UITableViewCell]()
    
    fileprivate var arrayOfFretboardModels: [FretboardModel] = [FretboardModel()] {
        // reload tableView if arrayOfFretboardModels is loaded from a saved file.
        didSet { tableView?.reloadData() }
    }
    
    fileprivate var selectedBoard = FretboardModel()
    
    fileprivate var modelIndex: Int = 0 {
        // switches the selectedBoard. Perhaps consider a better mechanism
        didSet { selectedBoard = arrayOfFretboardModels[modelIndex] }
    }
    //###################################
    // Outlets
    //############
    @IBOutlet weak var rootPickerView: UIPickerView!
    @IBOutlet weak var accidentalPickerView: UIPickerView!
    @IBOutlet weak var scalePickerView: UIPickerView!
    
    @IBOutlet weak var addNotes: UIButton!
    @IBOutlet weak var displayModePickerView: UIPickerView!
    
    @IBOutlet weak var fretboardView: FretboardView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addFretboardButton: UIButton!
    
    @IBOutlet weak var fretboardTitleTextField: UITextField!
    
    @IBOutlet var lockSwitchLabel: UILabel!
    
    
    
    @IBOutlet var scalesButton: UIButton!
    
    let scalesTVC = ScalesTVC()
    
    //###################################
    // Actions
    //
    //############
    @IBAction func addFretboardAction(_ sender: UIButton) {
        // Add a new blank fretboard Model
        arrayOfFretboardModels.append(FretboardModel())
        
        // add a new UITableViewCell
        let testCell2 = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: selectedBoard.getFretboardTitle())
        testCell2.textLabel!.text = "Untitled"
        arrayOfTableViewCells.append(testCell2)
       
        // load updated data model
        tableView?.reloadData()
        
        // Select row of added data.// Always loads from the back
        let row = arrayOfFretboardModels.endIndex - 1
        tableView.selectRow(at: IndexPath(row: row , section: 0 ), animated: false, scrollPosition: UITableViewScrollPosition.none)
        
        viewSelectedFretboard(row: row)
    }
    
    //############
    // remove a fretboard from the arrayOfFretbaords and the tableView.
    @IBAction func removeFretboardAction(_ sender: UIButton) {
        if arrayOfFretboardModels.count != 1  {
            let index = tableView!.indexPathForSelectedRow!.row - 1
            arrayOfFretboardModels.remove(at: index)
            arrayOfTableViewCells.remove(at: index)
            
            tableView?.reloadData()
            
            let lastRow = arrayOfFretboardModels.endIndex - 1
            tableView.selectRow(at: IndexPath(row: lastRow , section: 0 ), animated: false, scrollPosition: UITableViewScrollPosition.none)
            
            viewSelectedFretboard(row: lastRow)
        }
        
    }
    
    //############
    // add notes to the currentBoard
    @IBAction func addNotesAction(_ sender: UIButton) {
        updateToneArraysCreator()
        loadToneArraysIntoSelectedBoard()
    }
    
    
    @IBAction func lockFretboard(_ sender: UISwitch) {
        
      let isOn = sender.isOn
        
        selectedBoard.setIsLocked(isOn)
        let text = isOn ? "Locked" : "Unlock" 
        lockSwitchLabel.text = text
    }
    
    @IBAction func selectRootNote(_ sender: UIButton) {
        
        scalesTVC.modalPresentationStyle = .popover
        scalesTVC.preferredContentSize = CGSize(width: 300, height: 500)
        let popoverC = scalesTVC.popoverPresentationController
        popoverC?.sourceView = sender
        popoverC?.sourceRect = sender.bounds
        popoverC?.permittedArrowDirections = UIPopoverArrowDirection.up
        popoverC?.delegate = self
        
        present(scalesTVC, animated: true, completion: nil)
    }
    
    //###################################
    // UIViewController overridden functions
   
    //############
    // setup after viewLoads from the main.storyboard in memory
    override func viewDidLoad() {
    
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // buildArrayOfScaleNames()
        rootPickerView.selectRow(4, inComponent: 0, animated: false)
        scalePickerView.selectRow(28, inComponent: 0, animated: false)
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: selectedBoard.getFretboardTitle())
        cell.textLabel!.text = selectedBoard.getFretboardTitle()
        arrayOfTableViewCells.append(cell)
        
        let path = IndexPath(row: arrayOfFretboardModels.startIndex,  section: 0)
        tableView.selectRow(at: path, animated: false, scrollPosition: UITableViewScrollPosition.none)
        fretboardTitleTextField.text = selectedBoard.getFretboardTitle()
        //Sets the model to the 0 index in arrayOfFretboardModels.
        modelIndex = 0
        
        AudioKit.output = AKMixer(sixTonesController.arrayOfOscillators)
        AudioKit.start()
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryAmbient, with: AVAudioSessionCategoryOptions.mixWithOthers)
            //try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            print("Error: Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        scalesTVC.delegate = self
        scalesButton.setTitle(scalesTVC.selectedScale, for: .normal)
        
    }
    
    //############
    // Autolayout has been applied and you can draw with bounds information.
    override func viewDidLayoutSubviews() {
        // update lengths and heights of noteview drawing.
        fretboardView.buildNoteRects()
        fretboardView.buildNoteViews()
        fretboardView.addSubviews()
        addNotesAction(addNotes)
    }
    
    //###################################
    // Custom Functions
    
    //############
    // Load scale info into toneArraysCreator
    func updateToneArraysCreator() {
        let arrayOfPickerStrings = getPickerValues()
        toneArraysCreator.updateWithValues(arrayOfPickerStrings[0],
                                           accidental: arrayOfPickerStrings[1],
                                           scaleName: arrayOfPickerStrings[2])
    }
    
    //############
    // Get Root, Accidental, and Scale in a array of strings
    fileprivate func getPickerValues()->[String] {
  
        let rootRow = rootPickerView.selectedRow(inComponent: 0)
        let root = pickerView(rootPickerView, titleForRow: rootRow, forComponent: 0)!
        
        let accidentalRow = accidentalPickerView.selectedRow(inComponent: 0)
        let accidental = pickerView(accidentalPickerView, titleForRow: accidentalRow, forComponent: 0)!
        
        //let scaleRow = scalePickerView.selectedRow(inComponent: 0)
        //let scale = pickerView(scalePickerView, titleForRow: scaleRow, forComponent: 0)!
 
        let scale = scalesTVC.selectedScale
        
        var arrayOfStrings = [String]()
        arrayOfStrings.append(root)
        arrayOfStrings.append(accidental)
        arrayOfStrings.append(scale)
        return arrayOfStrings
    }
    
    //############
    // Loads ToneArrays into the selectedBoard and updates the view.
    func loadToneArraysIntoSelectedBoard() {
        selectedBoard.updateNoteModels(toneArraysCreator.getArrayOfToneArrays(), isInScale: true)
        fillSpacesWithChromatic()
        
      //  updateDisplayModeAction(displayModePopUp)
        
        selectedBoard.showNotesOnFretboard(true, _isDisplayed: true, _isGhosted: true)
        
        updateFretboardView()
    }
 /*
    //############
    // Adds the scale names to the Scale PopUp
    func buildArrayOfScaleNames(){
        let scalesDict = ScalesByIntervals()
        for index in 0...(scalesDict.getScaleArray().count - 1){
            arrayOfScaleNames.append(scalesDict.getScaleArray()[index].getScaleName())
        }
    }
 */
    //############
    func updateFretboardView() {
        // get the displayMode
        let displayModeRow = displayModePickerView.selectedRow(inComponent: 0)
        let displayMode = pickerView(displayModePickerView, titleForRow: displayModeRow, forComponent: 0)
        // Update View
        fretboardView.updateSubviews(selectedBoard.getFretboardArray(), displayMode: displayMode!)
    }
   
    //############
    // Fills notes not in the scale with chromatic notes.
    func fillSpacesWithChromatic()
    {
        
          let arrayOfPickerStrings = getPickerValues()
        toneArraysCreator.updateWithValues(arrayOfPickerStrings[0],
                                           accidental: arrayOfPickerStrings[1],
                                           scaleName: "Chromatic Scale")
       selectedBoard.updateNoteModels(toneArraysCreator.getArrayOfToneArrays(), isInScale: false)
    }
    
    //##############################################
    // UIPickerView DataSource functions
    
    //############
    // Return the number of componensts
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //############
    // return the count for each pickerview.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
        case rootPickerView:
            return arrayOfRootNotes.count
        case accidentalPickerView:
            return arrayOfAccidentals.count
        case scalePickerView:
            return scalesTVC.arrayOfScaleNames.count
        default:
            return arrrayOfDisplayModes.count
        }
    }
    
    //#######################
    // UIPickerViewDelegate functions
    
    //############
    // Sets the height for each component.
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(30)
    }
    
    //############
    // returns the widths for each off the pickerViews
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
    
    //############
    // Returns the String of each Row.
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        switch pickerView {
        case rootPickerView:
            return arrayOfRootNotes[row]
        case accidentalPickerView:
            return arrayOfAccidentals[row]
        case scalePickerView:
            return scalesTVC.selectedScale
        default:
            return arrrayOfDisplayModes[row]
        }
        
    }
    
    //############
    // Reacts when a selection is made with the displayModePickerView.
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        if pickerView == displayModePickerView {
            // update fretboardview with that display setting.
            updateFretboardView()
        }
    }

    //###################################
    // UITableView  DataSource functions
    
    //############
    // Returns the number of rows in the tableview.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arrayOfFretboardModels.count
    }
    
    //############
    // Returns the UITableCellView for each Row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return arrayOfTableViewCells[indexPath.row]
    }
    
    //############
    // FCN is informed when a new object is selected by the user. Not when a new board is added with the + button.
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        // change the displayed fretboard to match the selection.
        let myRow = indexPath.row
        
        viewSelectedFretboard(row: myRow)
        fretboardTitleTextField.text = selectedBoard.getFretboardTitle()
        
        fretboardTitleTextField.text = selectedBoard.getFretboardTitle()
        fretboardTitleTextField.resignFirstResponder()
        
    }
    
    //############
    // Custom function called by UITableView delegate methods
    // updates the selectedBoard and displays it.
    fileprivate func viewSelectedFretboard(row: Int){
        modelIndex = row
        updateFretboardView()
    }
    
    //###################################
    // UITextFieldDelegateMethods.
    
    //############
    // Is called when the return key is hit by the keyboard for the fretboardTitle textField.
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Update the currentBoard.title field. 
        
        // Close keyboard
        fretboardTitleTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let noteView = getNoteViewOrNil(touch.view) {
                if noteView.isDisplayed {
                    if noteView.isGhost == false {
                        addViewIdToDictionary(noteView)
                        // play sound.
                        
                        // Get zeroTo46Number
                        let zeroTo36Number = getZeroTo36Number(noteView)
                        sixTonesController.rampUpStart(noteView.stringNumber, zeroTo36Number: zeroTo36Number)
                    }
                }
            }
        }
        super.touchesBegan(touches, with: event)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       
        for touch in touches {
            if let noteView = getNoteViewOrNil(touch.view) {
                if noteView.isDisplayed {
                     sixTonesController.rampDownStop(noteView.stringNumber)
                }
            }
        }
        
        // Turn off all notes in the stored in the dictionary.
        // Maybe I should be removing dictionary entries when they are turned off. Maybe?
        for (noteViewNumber, _) in dictOfTouchedNoteViewNumbers {
            let stringNumber = fretboardView.arrayOfNoteViews[noteViewNumber].stringNumber
            sixTonesController.rampDownStop(stringNumber)
        }
        dictOfTouchedNoteViewNumbers.removeAll()
        super.touchesEnded(touches, with: event)
    }
    
  
    // I may need to override for playing notes.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // for all sent touches (probably only one touch.
        for touch in touches {
            // Search for location hits in NoteViews, handle ass approriate.
            for noteView in fretboardView.arrayOfNoteViews {
                if noteView.isDisplayed {
                    let (noteViewNumber, pointIsInNoteView) = getKeyTestPointHit(noteView, touch: touch)
                    if pointIsInNoteView {
                        // Check the dictionary for the key,
                        if let canTouchView = dictOfTouchedNoteViewNumbers[noteViewNumber] {
                            // respond to canUse value
                            if canTouchView {
                            playOrStopTouchAndUpdateDictionary(noteView)
                            }
                            // Else there is no entry for the key Dictionary record,
                        } else {
                            playOrStopTouchAndUpdateDictionary(noteView)
                        }
                        //Else, the NoteView DOES NOT contain the point
                        // so stop playing a note.
                    } else {
                        // if the dictionary canTouchView bool is false, update to true
                        if dictOfTouchedNoteViewNumbers[noteViewNumber] == false {
                            dictOfTouchedNoteViewNumbers[noteViewNumber] = true
                            sixTonesController.rampDownStop(noteView.stringNumber)
                            
                        }
                    }
                }
            }
        }
        super.touchesMoved(touches, with: event)
    }
    
    //########################################
    // return a noteView or nil
    func getNoteViewOrNil(_ view: UIView?)->NoteView? {
        if let noteView = view as? NoteView {
            return noteView
        }
        else {
            return nil
        }
    }
    
    //########################################
    // Add key to dictionary if need be
    func addViewIdToDictionary(_ noteView: NoteView){
        
            // so create a key and test if it's in the dictionary.
            let number = noteView.viewNumber
            // Create a dictionary entry if the key does not have an entry.
                if dictOfTouchedNoteViewNumbers[number] == nil {
                    dictOfTouchedNoteViewNumbers[number] = false
                }
    }
    
    //########################################
    // if getKeyIfNoteViewContainsPoint
    func getKeyTestPointHit(_ noteView: NoteView, touch: UITouch)->(Int, Bool) {
            // get the point relative to the view, and test for a point hit.
            let point = touch.location(in: noteView)
            let number = noteView.viewNumber
            // If the view's bounds contains the point,
            return (number, noteView.bounds.contains(point) ? true : false)
        
    }
    //########################################
    
    func playOrStopTouchAndUpdateDictionary(_ noteView: NoteView) {
        let stringNumber = noteView.stringNumber
        // Note, I'm playing then touching.
        let zeroTo36Number = getZeroTo36Number(noteView)
        if noteView.isGhost {
            sixTonesController.rampUpStart(stringNumber, zeroTo36Number: zeroTo36Number)
        } else {
            sixTonesController.rampDownStop(stringNumber)
        }
        noteView.touchThisView()
        dictOfTouchedNoteViewNumbers[noteView.viewNumber] = false
    }
    
    func getZeroTo36Number(_ noteView: NoteView)->Int {
        // Get zeroTo46Number
        let viewNumber = noteView.viewNumber
        return Int(selectedBoard.getFretboardArray()[viewNumber].getNumber0to46())!
    }
    
    func scaleChanged(text: String) {
        scalesButton.setTitle(text, for: .normal)
        scalesButton.setNeedsDisplay()
    }
    
 }


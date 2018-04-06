//
//  ViewController.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 12/11/17.
//  Copyright © 2017 Gire. All rights reserved.
//

import UIKit
import AudioKit
import StoreKit


class FBViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPopoverPresentationControllerDelegate, ScalesTVCDelegate, ColorSelectorTVCDelegate, CollectionsTVCDelegate {


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
    let chordCreator = ChordCreator()
    
     let arrayOfSampleScalesAndChords = ["Chromatic Scale",
                                         "Minor Pentatonic Scale",
                                         "Major Pentatonic Scale",
                                         "Major Chord (v1)",
                                         "Major Chord (v2)",
                                         "Major Chord (v3)",
                                         "Major Chord (v4)",
                                         "A Chord", "Am Chord", "A7 Chord"]
    
    let arrayOfScaleDisplayModes = ["Notes", "Fret Numbers","Intervals", "Numbers 0-11", "Numbers 0-36"]
    let arrayOfChordDisplayModes = ["Notes", "Fret Numbers","Intervals", "Chord Fingers", "Numbers 0-11", "Numbers 0-36"]
    let arrayOfRootNotes = ["A", "B", "C", "D", "E", "F", "G", "A", "B", "C", "D", "E", "F", "G", "A", "B", "C", "D", "E", "F", "G"]
    let arrayOfAccidentals = ["Natural", "b", "#" ]
    let chordFormulas = ChordFormulas()
    let basicChordFormulas = BasicChordFormulas()
    
    //###################################
    // Other Constants
    //############
    
    let lightYellowColor = UIColor(red: 1, green: 1, blue: 155/255, alpha: 1)
    let pinkColor = UIColor(red: 1, green: 0.5, blue: 0.5, alpha: 1)
    let sixTonesController = SixTones()
    
    let scalesTVC = ScalesTVC()
    let colorSelectorTVC = ColorSelectorTVC()
    let collectionsTVC = CollectionsTVC()
    
    
    //###################################
  
    //###################################
    // Array Variables
    //############
   
    var productStore: ProductStore!
    var fbCollectionStore: FBCollectionStore!
    
    // Variable to keep track of views updated during a single view track event.
    // Is a dictionary of view IDs and Bools.
    // FTY:   Bool: yes = canUpdate.
    // If I exited the views bounds, I can can update it,
    // if I didn't leave the bounds, I cannot update.
    var dictOfTouchedNoteViewNumbers = [Int: Bool]()
    
    // The index of the selected Collection.
    var selectedCollection: FBCollectionModel!
    fileprivate var selectedBoard = FretboardModel()
    var extraFretboardModel = FretboardModel()
    
    fileprivate var modelIndex: Int = 0 {
        // switches the selectedBoard. Perhaps consider a better mechanism
        didSet {
            selectedBoard = selectedCollection.arrayOfFretboardModels[modelIndex]
            // Saves which fretboard was selected in the collection.
             selectedCollection.modelIndex = modelIndex
        }
    }
    //###################################
    // Outlets
    //############
    @IBOutlet weak var rootPickerView: UIPickerView!
    @IBOutlet weak var accidentalPickerView: UIPickerView!
    

    @IBOutlet weak var displayModePickerView: UIPickerView!
    @IBOutlet weak var fretboardView: FretboardView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addFretboardButton: UIButton!
    @IBOutlet weak var fretboardTitleTextField: UITextField!
    @IBOutlet var scaleSelectionButton: UIButton!
    @IBOutlet var colorButton: UIButton!
    
    @IBOutlet var colorButtonBorderView: UIView!
    @IBOutlet var lockSwitch: UISwitch!
    @IBOutlet var LockedStatusLabel: UILabel!
    @IBOutlet var modeLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var clearGhostedNotesButton: UIButton!
    @IBOutlet var customizationSwitch: UISwitch!
    @IBOutlet var customizationLabel: UILabel!
 
    
    @IBOutlet var editTableViewButton: UIButton!
    @IBOutlet var collectionTitleTextField: UITextField!
    
    @IBOutlet var allCollectionsButton: UIButton!
    
    @IBOutlet var doShowScalesControl: UISegmentedControl!
    
    //###################################
    // Actions
    //
    //############
    
    @IBAction func strumAction(_ sender: UIButton) {
        // Locate the highest notes allong each string and strum them.
        let (arrayOfViewNumbers, arrayOfStringIndexes) = fretboardView.getViewNumbersForStrumming()
        for index in 0..<arrayOfViewNumbers.count {
            // strum the NoteView.
            // Try calling touchesBegan explicitly.
            let viewNumber = arrayOfViewNumbers[index]
            let zeroTo36Number = getZeroTo36Number(viewNumber)
            let stringIndex = arrayOfStringIndexes[index]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(stringIndex * 50), execute: {
                self.sixTonesController.limitedDurationPlay(stringIndex, zeroTo36Number: zeroTo36Number)
                let view = self.fretboardView.arrayOfNoteViews[viewNumber]
                view.flash()
            })
            //sixTonesController.limitedDurationPlay(stringIndex, zeroTo36Number: zeroTo36Number)
            //sixTonesController.rampUpStart(stringIndex, zeroTo36Number: zeroTo36Number)
           // let view = fretboardView.arrayOfNoteViews[viewNumber]
            //view.flash()
            //sixTonesController.rampDownStop(stringIndex)
        }
    
    }
    
    @IBAction func showScalesOrChords(_ sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
       
        // Show Scales
        if index == 0 {
            scalesTVC.doShowScales = 0
            selectedBoard.doShowScales = 0
            //scalesTVC.updateSelectedScaleOrChord(index: selectedBoard.scaleSelectedRow)
            scalesTVC.updateSelectedScaleOrChord(scaleOrChord: selectedBoard.scaleSettings.scaleOrChord)
            
            scaleSelectionButton.setTitle(scalesTVC.selectedScale, for: .normal)
            
            
            
            rootPickerView.isHidden = false
            accidentalPickerView.isHidden = false
            
            // Otherwise show chords
        }   else if index == 1 {
            scalesTVC.doShowScales = 1
            selectedBoard.doShowScales = 1
            scalesTVC.updateSelectedScaleOrChord(scaleOrChord: selectedBoard.chordSettings.scaleOrChord)
            //scalesTVC.updateSelectedScaleOrChord(index: selectedBoard.chordSelectedRow)
            scaleSelectionButton.setTitle(scalesTVC.selectedChord, for: .normal)
            
            
            rootPickerView.isHidden = false
            accidentalPickerView.isHidden = false
        
            // Otherwise, show basic chords
        }   else {
            
            // Only have 1 control that users can use to select the basic chords.
            // Use scalesTVC to show full chord names. 
            scalesTVC.doShowScales = 2
            selectedBoard.doShowScales = 2
            scalesTVC.updateSelectedScaleOrChord(scaleOrChord: selectedBoard.basicChordSettings.scaleOrChord)
            //scalesTVC.updateSelectedScaleOrChord(index: selectedBoard.basicChordSelectedRow)
            scaleSelectionButton.setTitle(scalesTVC.selectedBasicChord, for: .normal)
            
            
            rootPickerView.isHidden = true
            accidentalPickerView.isHidden = true
        }
        
        // I need to reload the data based selected saved row.
        scalesTVC.selectSavedRow()
       
        
        loadPickerViewSelections(doShowScalesIndex: scalesTVC.doShowScales)
        
        if selectedBoard.allowsCustomizations == false {
            addNotesAction()
            
            // Otherwise, Customizations are allowed.
            // Only update the fretboardView to reflect the displayMode change
        }   else {
            updateFretboardView()
        }
        
    }
    
    @IBAction func allCollectionsAction(_ sender: UIButton) {
        // print(#function) // Displays function when called.
        
        // setup popoverPrestationController
        let popC = collectionsTVC.popoverPresentationController
        popC?.sourceView = sender
        popC?.sourceRect = sender.bounds
        popC?.permittedArrowDirections = UIPopoverArrowDirection.up
        popC?.delegate = self
        //popC?.adaptivePresentationStyle 
        
        // Present
        present(collectionsTVC, animated: true, completion: nil)
    }
    
    
    
    @IBAction func editTableView(_ sender: UIButton) {
      // toggle edit mode.
        if tableView.isEditing == false {
            tableView.isEditing = true
            sender.setTitle("Done", for: .normal)
            tableView.selectRow(at: IndexPath(row: modelIndex, section: 0), animated: true, scrollPosition: .middle)
            // When done editing.
        } else {
            tableView.isEditing = false
            sender.setTitle("Edit Collection", for: .normal)
            // If there are any fretboards left select the top fretboard.
            
            // FYI: All updates to the model index are done in the moveRow and commit editing tableView functions.
            let indexPath = IndexPath(row: modelIndex, section: 0)
            
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
                loadSettingsFromSelectedBoard()
                updateFretboardView()
        }

    }
    
    @IBAction func changeCollectionTitle(_ sender: UITextField) {
        let text = sender.text!
        if text != "" {
            selectedCollection.title = sender.text!
        }
    }
    
    @IBAction func changeFretboardTitle(_ sender: UITextField) {
        // print(#function) // Displays function when called.
        
        selectedBoard.setFretboardTitle(sender.text!)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.reloadRows(at: [indexPath], with: .none)
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        } else {
            print("indexPath in method \(#function) was nil. No selection was made in the tableView.")
        }
    }
    
    
    
    @IBAction func addFretboardAction(_ sender: UIButton) {
        // print(#function) // Displays function when called.
        // Add a new blank fretboard Model
        
        
        //     if let indexPath = tableView.indexPathForSelectedRow {
        // Adding 1 to the row to get the row after the selected fretboard.
        let row = selectedCollection.arrayOfFretboardModels.count
        let lastIndexPath = IndexPath(row: row, section: 0)
        selectedCollection.arrayOfFretboardModels.append(FretboardModel())
        tableView.insertRows(at: [lastIndexPath], with: .automatic)
        tableView.selectRow(at: lastIndexPath, animated: true, scrollPosition: .middle)
        
        // save whether showing scales or chords. Also save copy.
        let doShowScalesCopy = selectedBoard.doShowScales
        let colorCopy = selectedBoard.getUserColor()
        
        // Updates seletedBoard.
        modelIndex = row
   
        // Load saved values into selected Board
        selectedBoard.doShowScales = doShowScalesCopy
        selectedBoard.setUserColor(colorCopy)
        scalesTVC.doShowScales = doShowScalesCopy
        
        // Load all settings from selected board.
        // add notes and update FBView.
        loadSettingsFromSelectedBoard()
        addNotesAction()
        updateFretboardView()
        
        hideOrShowEditTableViewButton()
    }

    
    //############
    // add notes to the currentBoard
    func addNotesAction() {
        // print(#function) // Displays function when called.
        if selectedBoard.allowsCustomizations {
            selectedBoard.clearGhostedNotes()
        }
        
        updateToneArraysCreator()
       
        loadToneArraysIntoSelectedBoard()
        updateFretboardView()
        
        
    }
    
    // Gets a readable title from the root, accidental, & scale selections
    // and updates the fretboard title.
    func autoSetFretboardTitle(arrayOfStrings: [String]) {
        // print(#function) // Displays function when called.
        
       
        let root = arrayOfStrings[0]
        var accidental = arrayOfStrings[1]
        if accidental == "Natural" {
            accidental = ""
        }
        
        var scale = ""
        
        if scalesTVC.doShowScales == 0 {
            scale = arrayOfStrings[2]
            
        }   else if scalesTVC.doShowScales == 1 {
                scale = scalesTVC.selectedChord
        
        }   else {
            scale = scalesTVC.selectedBasicChord
        }
        var newTitle = ""
        
        if scalesTVC.doShowScales != 2{
            newTitle = "\(root)\(accidental)  \(scale)"
        }
        else {
            newTitle = scale
        }
        
        //let newTitle = "\(root)\(accidental)  \(scale)"
        selectedBoard.setFretboardTitle(newTitle)
        fretboardTitleTextField.text = newTitle
        fretboardTitleTextField.setNeedsDisplay()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
        } else {
            // I should probably provide a default if the above if let statement fails.
            
        }
        
    }
    
    
    @IBAction func selectScale(_ sender: UIButton) {
        // print(#function) // Displays function when called.
        
        let popoverC = scalesTVC.popoverPresentationController
        popoverC?.sourceView = sender
        popoverC?.sourceRect = sender.bounds
        popoverC?.permittedArrowDirections = UIPopoverArrowDirection.up
        popoverC?.delegate = self
 
        present(scalesTVC, animated: true, completion: nil)
    }
    
    
    @IBAction func selectColor(_ sender: UIButton) {
        
        // print(#function) // Displays function when called.
        
        // Set height and width for colorSelectorTVC.preferredContentSize
        let width = sender.frame.width
        let cellHeight = UITableViewCell().contentView.frame.height
        let numberOfColors = CGFloat(colorSelectorTVC.arrayOfColors.count)
        let popoverHeight =  cellHeight * numberOfColors
        colorSelectorTVC.preferredContentSize = CGSize(width: width, height: popoverHeight)
        
        // setup popoverPrestationController
        let popC = colorSelectorTVC.popoverPresentationController
        popC?.sourceView = sender
        popC?.sourceRect = sender.bounds
        popC?.permittedArrowDirections = UIPopoverArrowDirection.up
        popC?.delegate = self
        
        // Present
        present(colorSelectorTVC, animated: true, completion: nil)
    }
    
    @IBAction func lockOrUnlockFretboard(_ sender: UISwitch) {
       // print(#function) // Displays function when called.
        let isLocked = sender.isOn
        
        // Show or hide fretboard editing controls based on swtich's isOn bool.
        rootPickerView.isHidden = isLocked
        accidentalPickerView.isHidden = isLocked
        scaleSelectionButton.isHidden = isLocked
        doShowScalesControl.isHidden = isLocked
        
        customizationLabel.isHidden = isLocked
        customizationSwitch.isHidden = isLocked
        // if isLocked is true, hide clear ghosted notes button.
        if isLocked {
            clearGhostedNotesButton.isHidden = true
        }
            // Otherwise if the fretboard is not locked.
            //  Check to see if the customizationSwitch is on.
            // If so, show clear Ghosted button
        else if customizationSwitch.isOn {
            clearGhostedNotesButton.isHidden = false
        }
            // Otherwise the FB is not locked, and the customizationSwitch is off,
            // so hide the clear ghosted Notes button.
        else {
            clearGhostedNotesButton.isHidden = true
        }
        
        colorButton.isHidden = isLocked
        colorButtonBorderView.isHidden = isLocked
        selectedBoard.setIsLocked(isLocked)
      
        // I will keep the displaymode picker available.
        
    }
    

    @IBAction func enableOrDisableCustomizations(_ sender: UISwitch) {
        // print(#function) // Displays function when called.
        selectedBoard.allowsCustomizations = sender.isOn
        // If switch is enabled (customizations are allowed)
        // Show the clear ghosted notes button.
        // Update label to Disable Customizations.
        // change backgroundViewColor.
        if sender.isOn {
            clearGhostedNotesButton.isHidden = false
            //customizationLabel.text = "Disable Customizations"
            backgroundView.backgroundColor = pinkColor
            rootPickerView.backgroundColor = pinkColor
            accidentalPickerView.backgroundColor = pinkColor
            displayModePickerView.backgroundColor = pinkColor
            modeLabel.text = "Mode: Customizable Fretboard"
            fretboardTitleTextField.textColor = UIColor.blue
            fretboardTitleTextField.isUserInteractionEnabled = true
        }
        else {
            clearGhostedNotesButton.isHidden = true
            //customizationLabel.text = "Enable Customizations"
            backgroundView.backgroundColor = lightYellowColor
            rootPickerView.backgroundColor = lightYellowColor
            accidentalPickerView.backgroundColor = lightYellowColor
            displayModePickerView.backgroundColor = lightYellowColor
            modeLabel.text = "Mode: Default Fretboard Switching"
            fretboardTitleTextField.textColor = UIColor.black
            fretboardTitleTextField.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func allowCustomizations(_ sender: UIButton) {
        // print(#function) // Displays function when called.
        selectedBoard.flipAllowsCustomizations()
        if selectedBoard.allowsCustomizations == true {
            //selectedBoard.updateGhostAndSelectedNotesIsKeptValue(isKept: true)
            modeLabel.text = "Custom Mode Enabled"
            sender.isHidden = true
            clearGhostedNotesButton.isHidden = false
        }
        else {
            modeLabel.text = "Default Mode"
            sender.setTitle("Allow Customizations", for: .normal)
        }
    }
    
    @IBAction func clearGhostedNotesAction(_ sender: UIButton) {
        // print(#function) // Displays function when called.
        selectedBoard.clearGhostedNotes()
        updateFretboardView()
    }
    
    
    //###################################
    // UIViewController overridden functions
   
    //############
    // setup after viewLoads from the main.storyboard in memory
    override func viewDidLoad() {
        // print(#function) // Displays function when called.
        super.viewDidLoad()

        // Gaurantee there's always 1 collection if something is screwed up.
        // This call might not be necessary since I don't allow all the collections to be deleted.
        if fbCollectionStore.arrayOfFBCollections.count == 0 {
            fbCollectionStore.appendCollection()
            
        }
        
        // Injecting chordNames into scalesTVC
        scalesTVC.fbCollectionStore = fbCollectionStore
        scalesTVC.arrayOfSampleScalesAndChords = arrayOfSampleScalesAndChords
        scalesTVC.arrayOfChordNames = chordFormulas.arrayOfShapeNames
        scalesTVC.arrayOfBasicChordNames = basicChordFormulas.arrayOfBasicChordNames
        
        selectedCollection = fbCollectionStore.arrayOfFBCollections[fbCollectionStore.savedCollectionIndex]
        collectionTitleTextField.text = selectedCollection.title
        
        //Setting the modelIndex updates the SelectedIndex as well. 
        modelIndex = selectedCollection.modelIndex
        // Select in tableView and load settings.
        let indexPath = IndexPath(row: modelIndex, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        loadSettingsFromSelectedBoard()
        
        hideOrShowEditTableViewButton()
        
        AudioKit.output = AKMixer(sixTonesController.arrayOfOscillators)
        AudioKit.start()
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryAmbient, with: AVAudioSessionCategoryOptions.mixWithOthers)
        } catch {
            print("Error: Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        scalesTVC.delegate = self
        colorSelectorTVC.delegate = self
        
        // This assigns references to the modelIndex and the collectionStore in the CollectionsTVC. 
        collectionsTVC.collectionStore = fbCollectionStore
        collectionsTVC.delegate = self
        
        productStore.fbCollectionStore = fbCollectionStore
    }
    
    func hideOrShowEditTableViewButton() {
        if  selectedCollection.arrayOfFretboardModels.count < 2 {
            editTableViewButton.isHidden = true
        } else {
            editTableViewButton.isHidden = false
        }
    }
    
    // Variable specifying if noteViews need to be built.
    var doBuildNoteViews = true
    //############
    // Autolayout has been applied and you can draw with bounds information.
    override func viewDidLayoutSubviews() {
        // print(#function) // Displays function when called.
        
        if doBuildNoteViews {
            // update lengths and heights of noteView drawing after the viewDidLoad.
            // Since using autolayout calls this function a number of times,
            // I need to make sure I only create these noteViews once.
            fretboardView.buildNoteRects()
            fretboardView.buildNoteViews()
            fretboardView.addSubviews()
            updateFretboardView()
            
            if selectedBoard.getIsLocked() == false && selectedBoard.allowsCustomizations == false {
                addNotesAction()
            }
            
            
            doBuildNoteViews = false
        }
    }

  
    

    
    
    
    //###################################
    // Custom Functions

    

 
    

    
    
    
    //############
    // Get Root, Accidental, and Scale in a array of strings
    fileprivate func getPickerValues()->[String] {
        // print(#function) // Displays function when called.
  
        let rootRow = rootPickerView.selectedRow(inComponent: 0)
        let root = pickerView(rootPickerView, attributedTitleForRow: rootRow, forComponent: 0)!
        
        let accidentalRow = accidentalPickerView.selectedRow(inComponent: 0)
        let accidental = pickerView(accidentalPickerView, attributedTitleForRow: accidentalRow, forComponent: 0)!
 
        
        var scale = ""
        
        if scalesTVC.doShowScales == 0 {
            scale = scalesTVC.selectedScale
            
        }
        
        else if scalesTVC.doShowScales == 1 {
            scale = scalesTVC.selectedChord
        
        }   else {
            scale = scalesTVC.selectedBasicChord
        }
        
        var arrayOfStrings = [String]()
        arrayOfStrings.append(root.string)
        arrayOfStrings.append(accidental.string)
        arrayOfStrings.append(scale)
        return arrayOfStrings
    }
    
    
    //############
    // Load scale info into toneArraysCreator
    func updateToneArraysCreator() {
        // print(#function) // Displays function when called.
       
        let arrayOfPickerStrings = getPickerValues()
        
        if scalesTVC.doShowScales == 0 {
            
                toneArraysCreator.updateWithValues(arrayOfPickerStrings[0],
                                                   accidental: arrayOfPickerStrings[1],
                                                   scaleName: arrayOfPickerStrings[2])
            
               if selectedBoard.allowsCustomizations == false {
                
                autoSetFretboardTitle(arrayOfStrings: arrayOfPickerStrings)
            }
        }
            // Otherwise load chords.
        else if scalesTVC.doShowScales == 1 {
            chordCreator.buildChord(root: arrayOfPickerStrings[0],
                                    accidental: arrayOfPickerStrings[1],
                                    chord: arrayOfPickerStrings[2],
                                    isBasicChord: false)
            
            if selectedBoard.allowsCustomizations == false {
                autoSetFretboardTitle(arrayOfStrings: arrayOfPickerStrings)
            }
            
            // Load the basic chord.
        }   else {
            let basicChord = basicChordFormulas.dictOfBasicChordNamesAndShapes[arrayOfPickerStrings[2]]
            chordCreator.buildChord(root: (basicChord?.fullRoot)!,
                                    accidental: "Natural",
                                    chord: arrayOfPickerStrings[2],
                                    isBasicChord: true)
            
            autoSetFretboardTitle(arrayOfStrings: arrayOfPickerStrings)
            
        }
       
    }
    
    
    //############
    // Loads ToneArrays into the selectedBoard and updates the view.
    func loadToneArraysIntoSelectedBoard() {
        // print(#function) // Displays function when called.
        
        // If showing scales, load from the toneArrays Creator.
        if scalesTVC.doShowScales == 0 {
            // If customizations are allowed.
            if selectedBoard.allowsCustomizations == false {
            // Update all  note models that are not kept. Should initially be zero.
            selectedBoard.loadNewNotesNumbersAndIntervals(toneArraysCreator.getArrayOfToneArrays())
            }
            // otherwise customizations are allowed. Load notes into the extra fretboard.
            else {
                extraFretboardModel.loadNewNotesNumbersAndIntervals(toneArraysCreator.getArrayOfToneArrays())
                selectedBoard.addNoteModels(newArray: extraFretboardModel.getFretboardArray())
            }
        }
        // Otherwise chords are being shown.
        // load from chordCreator - this will load either regular chords or basic chords.
        else  {
             selectedBoard.addNoteModels(newArray: chordCreator.fretboardModel.getFretboardArray())
            
        }
        
    }
    
    //############
    func updateFretboardView() {
        // print(#function) // Displays function when called.
       
        var displayMode = DisplayMode.notes
        if selectedBoard.doShowScales == 0 {
            displayMode = selectedBoard.scaleSettings.displayMode
        }
        else if selectedBoard.doShowScales == 1 {
            displayMode = selectedBoard.chordSettings.displayMode
        }
        else {
            displayMode = selectedBoard.basicChordSettings.displayMode
        }
        
        
        fretboardView.updateSubviews(selectedBoard.getFretboardArray(), displayMode: displayMode)
    }
    

    
    //#############
    // Loads settings from the selected board.
    func loadSettingsFromSelectedBoard() {
        // print(#function) // Displays function when called.
 
        // Note at this point the ModelIndex should have been updated elsewhere in the code. .
        // load fretboardTitle
        fretboardTitleTextField.text = selectedBoard.getFretboardTitle()
        
        // Update allowsCustomizations switch and action.
        customizationSwitch.isOn = selectedBoard.allowsCustomizations
        enableOrDisableCustomizations(customizationSwitch)
        
        // update lockSwitch and action settings.
        lockSwitch.isOn = selectedBoard.getIsLocked()
        lockOrUnlockFretboard(lockSwitch)
        
        
        //rootPickerView.selectRow(selectedBoard.rootNote, inComponent: 0, animated: true)
        //accidentalPickerView.selectRow(selectedBoard.accidental, inComponent: 0, animated: true)
        
        // loads doShowScalesSettings.
        if selectedBoard.doShowScales == 0 {
            doShowScalesControl.selectedSegmentIndex = 0
            scalesTVC.doShowScales = 0
            
            rootPickerView.isHidden = false
            accidentalPickerView.isHidden = false
            
        } else  if selectedBoard.doShowScales == 1 {
            doShowScalesControl.selectedSegmentIndex = 1
            scalesTVC.doShowScales = 1
            
            rootPickerView.isHidden = false
            accidentalPickerView.isHidden = false
        } else {
            doShowScalesControl.selectedSegmentIndex = 2
            scalesTVC.doShowScales = 2
            
            rootPickerView.isHidden = true
            accidentalPickerView.isHidden = true
        }
        
        
        loadPickerViewSelections(doShowScalesIndex: scalesTVC.doShowScales)
        updateScaleSelectionButton()
        

        
        // loadUserColor
        colorButton.backgroundColor = selectedBoard.getUserColor()
    }
    
    // This method must be called after a new board has been selected.
    func loadPickerViewSelections(doShowScalesIndex: Int) {
        
        // This reloads the data for the pickerView,
        // the scalesTVC.doShowScales must be called for this to work.
        displayModePickerView.reloadComponent(0)
        
        var scaleOrChordSelections = RootScaleAndDisplaySelections()
        
        switch doShowScalesIndex {
        case 0:
            scaleOrChordSelections = selectedBoard.scaleSettings
        case 1:
            scaleOrChordSelections = selectedBoard.chordSettings
        default:
            scaleOrChordSelections = selectedBoard.basicChordSettings
        }
    
        
        if let rootRow = arrayOfRootNotes.index(of: scaleOrChordSelections.root) {
            // adding 7 to not be in at the top of the root pickerview.
            // There are several levels of selection notes.
            rootPickerView.selectRow(rootRow + 7, inComponent: 0, animated: true)
        } else {
            // 11 corresponds to E
            rootPickerView.selectRow(11, inComponent: 0, animated: true)
        }
        
        if let accidentalRow = arrayOfAccidentals.index(of: scaleOrChordSelections.accidental) {
            accidentalPickerView.selectRow(accidentalRow, inComponent: 0, animated: true)
        } else {
            accidentalPickerView.selectRow(0, inComponent: 0, animated: true)
        }
        let doShowScales = scalesTVC.doShowScales
        if doShowScales == 0 {
            if let row = arrayOfScaleDisplayModes.index(of: selectedBoard.scaleSettings.displayMode.rawValue) {
                displayModePickerView.selectRow(row, inComponent: 0, animated: true)
            }
            
        } else  if doShowScales == 1 {
            if let row = arrayOfChordDisplayModes.index(of: selectedBoard.chordSettings.displayMode.rawValue) {
                displayModePickerView.selectRow(row, inComponent: 0, animated: true)
            }
        } else {
            if let row = arrayOfChordDisplayModes.index(of: selectedBoard.basicChordSettings.displayMode.rawValue) {
                displayModePickerView.selectRow(row, inComponent: 0, animated: true)
            }
        }
    }
    
    func updateScaleSelectionButton() {
        // get the indexPath from the selected board which was selected prior to this function being called.
        //let indexPath = selectedBoard.doShowScales == 0 ? selectedBoard.scaleIndexPath : selectedBoard.chordIndexPath
       
        var scaleOrChord = ""
        
        if selectedBoard.doShowScales == 0 {
            scaleOrChord = selectedBoard.scaleSettings.scaleOrChord
        }
        else if selectedBoard.doShowScales == 1 {
            scaleOrChord = selectedBoard.chordSettings.scaleOrChord
        }
        else {
            scaleOrChord = selectedBoard.basicChordSettings.scaleOrChord
        }
        
        
        // Select the row in the scalesTVC.tableView.
        
        //
        
        // Set the scalesTVC.selectedScale string to match the indexPath pulled from the selected Board.
        scalesTVC.updateSelectedScaleOrChord(scaleOrChord: scaleOrChord)
        scalesTVC.selectSavedRow()
        // Upate the title.
        scaleSelectionButton.setTitle(scalesTVC.getTitleOfSelection(), for: .normal)
        scaleSelectionButton.setNeedsDisplay()
    }
    

    //###################################
    // UITableView  DataSource functions
    
    //############
    // Returns the number of rows in the tableview.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print(#function) // Displays function when called.
        
        return selectedCollection.arrayOfFretboardModels.count
    }
    
    //############
    // Returns the UITableCellView for each Row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // print(#function) // Displays function when called.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "fretboardCell", for: indexPath)
        cell.textLabel?.text = selectedCollection.arrayOfFretboardModels[indexPath.row].getFretboardTitle()
        cell.showsReorderControl = true
        
        // Set color of selected cell.
        let bgColorView = UIView()
        let color = UIColor(red: 0, green: 0.6, blue: 1.0, alpha: 0.5)
        bgColorView.backgroundColor = color
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    
    //############
    // FCN is informed when a new object is selected by the user. Not when a new board is added with the + button.
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        // print(#function) // Displays function when called.
        
        // change the displayed fretboard to match the selection. Only if selecting a different fretboard.
       //   if modelIndex != indexPath.row {
        let myRow = indexPath.row
        modelIndex = myRow
        loadSettingsFromSelectedBoard()
        updateFretboardView()
        
        //}
    }
    
    // Presents editing alerts.
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        // Presents editing alerts.
        if editingStyle == .delete {
            // get an instance of the model
            let fbModel = selectedCollection.arrayOfFretboardModels[indexPath.row]
            
            let title = "Delete \(fbModel.getFretboardTitle())?"
            let message = "Are you sure you want to delete this fretboard?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            if let popoverController = ac.popoverPresentationController {
                
                 let sourceView = tableView.cellForRow(at: indexPath)!.contentView
                 //let
                popoverController.sourceView = sourceView
                popoverController.sourceRect = sourceView.bounds
                popoverController.permittedArrowDirections = UIPopoverArrowDirection.right
            }
            
           
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete",
                                             style: .destructive,
                                             handler: { (action)-> Void in
                                                
                                                self.selectedCollection.arrayOfFretboardModels.remove(at: indexPath.row)
                                                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                                                
                                                // select either the model index or the last element of the arrayOfFretboards. 
                                                let last = self.selectedCollection.arrayOfFretboardModels.count - 1
                                                self.modelIndex = self.modelIndex <= last ? self.modelIndex : last
                                                let indexPath = IndexPath(row: self.modelIndex, section: 0)
                                                self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
                                                
                                                // Load setting of the newly seleected row. 
                                                self.loadSettingsFromSelectedBoard()
                                                self.updateFretboardView()
                                                
                                                if self.selectedCollection.arrayOfFretboardModels.count < 2 {
                                                    
                                                    self.editTableViewButton.isHidden = true
                                                    if self.tableView.isEditing {
                                                        self.editTableView(self.editTableViewButton)
                                                    }
                                                }
            })
             ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }
  
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        
        // update the FBCollectionStore -
        let model = selectedCollection.arrayOfFretboardModels[sourceIndexPath.row]
        selectedCollection.arrayOfFretboardModels.remove(at: sourceIndexPath.row)
        selectedCollection.arrayOfFretboardModels.insert(model, at: destinationIndexPath.row)
       
        // Update model index.
        // If the selectedFretboard was moved, update the modelIndex
        if sourceIndexPath.row == modelIndex {
            modelIndex = destinationIndexPath.row
        }
        // If the source.row is greater than the model index,
        // && the destination.row is less than or equal to the modelIndex,
        // add 1 to the modelIndex
        else if sourceIndexPath.row > modelIndex && destinationIndexPath.row <= modelIndex  {
            
            modelIndex += 1
        }
        // If the source.row is less than the modelIndex,
        // && the destination.row is greater than or to the model index,
        // decrement the modelIndex.
        else if sourceIndexPath.row < modelIndex && destinationIndexPath.row >= modelIndex {
            modelIndex -= 1
        }
        
        
    }
    
    // Disables Swipe to delete if there are less than 2 collections
     func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .delete
        } else {
            return .none
        }
    }
    
    
    //############
    //##############################################
    // UIPickerView DataSource functions
    
    //############
    // Return the number of componensts
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // print(#function) // Displays function when called.
        return 1
    }
    //############
    // return the count for each pickerview.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // print(#function) // Displays function when called.
        
        switch pickerView {
        case rootPickerView:
            return arrayOfRootNotes.count
        case accidentalPickerView:
            return arrayOfAccidentals.count
        default:
            if scalesTVC.doShowScales == 0 {
                return arrayOfScaleDisplayModes.count
            } else {
                return arrayOfChordDisplayModes.count
            }
        }
    }
    
    //#######################
    // UIPickerViewDelegate functions
    
    //############
    // Sets the height for each component.
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        // print(#function) // Displays function when called.
        return CGFloat(30)
    }
    
    //############
    // returns the widths for each off the pickerViews
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        // print(#function) // Displays function when called.
        
        switch pickerView {
            case rootPickerView:
            return CGFloat(ROOT_WIDTH)
            
            case accidentalPickerView:
            return CGFloat(ACCIDENTAL_WIDTH)
            
            default:
            return CGFloat(DISPLAYMODE_WIDTH)
        }
    }
    
    //############
    // Returns the String of each Row.
    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        // print(#function) // Displays function when called.
        
        let attributedStringKey = [NSAttributedStringKey.foregroundColor: UIColor.blue]
        
        switch pickerView {
        case rootPickerView:
            let data = arrayOfRootNotes[row]
            let attributedString = NSAttributedString(string: data, attributes: attributedStringKey)
            return attributedString
        case accidentalPickerView:
            
            let data = arrayOfAccidentals[row]
            let attributedString = NSAttributedString(string: data, attributes: attributedStringKey)
            return attributedString
            
        default:
            var data = ""
            

            var rowToUse = row
            if scalesTVC.doShowScales == 0 {
                
                    if rowToUse > 4 {
                        rowToUse = 4
                    }
                
                data = arrayOfScaleDisplayModes[rowToUse]
            } else {
                data = arrayOfChordDisplayModes[row]
            }
            let attributedString = NSAttributedString(string: data, attributes: attributedStringKey)
            return attributedString
        }
        
    }
    
    //############
    // Reacts when a selection is made with the displayModePickerView.
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        // print(#function) // Displays function when called.
        
        if pickerView == displayModePickerView {
            if scalesTVC.doShowScales == 0 {
                let value = arrayOfScaleDisplayModes[row]
                selectedBoard.scaleSettings.displayMode = DisplayMode(rawValue: value)!
            }
            else {
                let value = arrayOfChordDisplayModes[row]
                
                if scalesTVC.doShowScales == 1 {
                    selectedBoard.chordSettings.displayMode = DisplayMode(rawValue: value)!
                } else if scalesTVC.doShowScales == 2 {
                    selectedBoard.basicChordSettings.displayMode = DisplayMode(rawValue: value)!
                }
            }
            
            updateFretboardView()
        }
        else {
            switch pickerView {
            case rootPickerView:
                // If showing scales
                if scalesTVC.doShowScales == 0 {
                    selectedBoard.scaleSettings.root = arrayOfRootNotes[row]
                }
                
                // If showing chords,
                else if scalesTVC.doShowScales == 1 {
                    selectedBoard.chordSettings.root = arrayOfRootNotes[row]
                }
                    
                // If showing basic chords, this function is never called.
                
                
            case accidentalPickerView:
                if scalesTVC.doShowScales == 0 {
                    selectedBoard.scaleSettings.accidental = arrayOfAccidentals[row]
                }
                else if scalesTVC.doShowScales == 1 {
                    selectedBoard.chordSettings.accidental = arrayOfAccidentals[row]
                }
            default:
                print("\(#function): Error: pickerView selection was not rootPickerView or accidentalPickerView")
            }
                addNotesAction()
        }
        
        // updated SelectedBoard scale, chord, or basicChord settings.
        
    }
    

    
    //###################################
    // UITextFieldDelegateMethods.
    
    //############
    // Is called when the return key is hit by the keyboard for the fretboardTitle textField.
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // print(#function) // Displays function when called.
    
        // Update the currentBoard.title field. 
        
        // Close keyboard
        fretboardTitleTextField.resignFirstResponder()
        collectionTitleTextField.resignFirstResponder()
    
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == collectionTitleTextField {
            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
        }
    }
    
    // ###############################
    // Touches methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // print(#function) // Displays function when called.
        
        for touch in touches {
            // If the view is a noteView, and is displayed.
            if let noteView = getNoteViewOrNil(touch.view) {
                if noteView.isDisplayed {
                    // add the view to the dictionary in case this is part of a dragged touch.
                    addViewIdToDictionary(noteView)
                    
                    // Get needed properties.
                    let allowsCustomizations = selectedBoard.allowsCustomizations
                    let noteModel = selectedBoard.getFretboardArray()[noteView.viewNumber]
                    
                    // If the board allows customizations and is not locked. Customize.
                    if allowsCustomizations && lockSwitch.isOn == false {
                        
                        // Use the noteView.viewNumber to determine which noteModel to update.
                        // Update the noteModel in the FretboardModel to reflect a touch.
                        // That is, update isGhost and isKept. Color changes are handled in FretboardModel.
                        selectedBoard.updateSingleNoteModel(modelNumber: noteView.viewNumber, flipIsGhost: true, flipIsKept: true)
                        
                        // Load the specific noteModel data into the fretboardView
                        // Be sure the noteView gets set to needsDisplay()
                        fretboardView.updateSingleNoteView(viewNumber: noteView.viewNumber, isGhost: noteModel.getIsGhost(), color: colorButton.backgroundColor!)
                    }
                    // play sound if the note was unghosted or if the fretboard cannot be edited.
                    // If the canEditFretboard == false, I need to ensure there are no ghosted notes while loading the notes.
                    if noteModel.getIsGhost() ==  false || allowsCustomizations == false {
                        let zeroTo36Number = getZeroTo36Number(noteView.viewNumber)
                        sixTonesController.rampUpStart(noteView.stringNumber, zeroTo36Number: zeroTo36Number)
                        // Only flash when you can't customize the fretboard.
                        if allowsCustomizations == false || lockSwitch.isOn == true {
                            noteView.flash()
                        }
                    }
                }
            }
            super.touchesBegan(touches, with: event)
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // print(#function) // Displays function when called.
        
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
        // print(#function) // Displays function when called.
        
        // for all sent touches (probably only one touch.
        for touch in touches {
            // Search for location hits in NoteViews, handle as approriate.
            for noteView in fretboardView.arrayOfNoteViews {
                if noteView.isDisplayed {
                 
                    let noteModel = selectedBoard.getFretboardArray()[noteView.viewNumber]
                    
                    let (noteViewNumber, pointIsInNoteView) = getKeyTestPointHit(noteView, touch: touch)
                    
                    if pointIsInNoteView {
                        // Check the dictionary for the key,
                        if let canTouchView = dictOfTouchedNoteViewNumbers[noteViewNumber] {
                            // respond to canUse value
                            if canTouchView {
                            playOrStopTouchAndUpdateDictionary(noteView, noteModel: noteModel)
                            }
                            // Else there is no entry for the key Dictionary record,
                        } else {
                            playOrStopTouchAndUpdateDictionary(noteView, noteModel: noteModel)
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
        // print(#function) // Displays function when called.
        
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
        // print(#function) // Displays function when called.
        
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
        // print(#function) // Displays function when called.
        
            // get the point relative to the view, and test for a point hit.
            let point = touch.location(in: noteView)
            let number = noteView.viewNumber
            // If the view's bounds contains the point,
            return (number, noteView.bounds.contains(point) ? true : false)
        
    }
    //########################################
    
    func playOrStopTouchAndUpdateDictionary(_ noteView: NoteView, noteModel: NoteModel) {
        // print(#function) // Displays function when called.
        
        let allowsCustomizations = selectedBoard.allowsCustomizations
        // If allows customizations and the fretboard is not locked.
        if allowsCustomizations && lockSwitch.isOn == false {
            
            // Update the noteModel
            let viewNumber = noteView.viewNumber
            selectedBoard.updateSingleNoteModel(modelNumber: viewNumber, flipIsGhost: true, flipIsKept: true)
            // Update the noteView
            fretboardView.updateSingleNoteView(viewNumber: viewNumber, isGhost: noteModel.getIsGhost(), color: colorButton.backgroundColor!)
        }
        
        // Rampup or rampdown note.
        let stringNumber = noteView.stringNumber
        let zeroTo36Number = getZeroTo36Number(noteView.viewNumber)
        if noteModel.getIsGhost() == false || allowsCustomizations == false {
            sixTonesController.rampUpStart(stringNumber, zeroTo36Number: zeroTo36Number)
            // only flash if allowsCustomizations == false.
            if allowsCustomizations == false || lockSwitch.isOn == true {
                noteView.flash()
            }
        } else {
            sixTonesController.rampDownStop(stringNumber)
        }
       
        dictOfTouchedNoteViewNumbers[noteView.viewNumber] = false
    }
    
    func getZeroTo36Number(_ viewNumber: Int)->Int {
        // print(#function) // Displays function when called.
        // Get zeroTo46Number
        
        return Int(selectedBoard.getFretboardArray()[viewNumber].getNumber0to36())!
    }
    
    //###########################
    // scalesTVCDelegate Method
    
   
   
   // let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //var controller = UnlockProViewController()
    
    func scaleChanged(scaleOrChord: String) {
        
        if fbCollectionStore.allowsPro == false {
            
                // check that a valid selection was made,
                if arrayOfSampleScalesAndChords.contains(scaleOrChord) {
                    updateScaleButtonAndAddNotes(scaleOrChord: scaleOrChord)
                }
                // Otherwise a valid selection was not made.
                else {
                    
                    // undo the scale/chord selection in ScalesTVC.
                    if let previousSelection = scaleSelectionButton.titleLabel?.text {
                        scalesTVC.updateSelectedScaleOrChord(scaleOrChord: previousSelection)
                        scalesTVC.selectSavedRow()
                    }
                    
                    // Check if the user can make payments
                    if SKPaymentQueue.canMakePayments() == false {
                        // If not
                        // Display an alert telling user the app store is not available.
                        displayCantMakePaymentsAlert ()
                        
                        // Otherwise payments are allowed.
                    }   else {
                        
                        // Check for an internet connection
                        // If there is an internet connection.
                        if currentReachabilityStatus != .notReachable {
                            // get pricing and load into UnlockProVC.
                            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "UnlockProViewController") as? UnlockProViewController {
                                controller.productStore = productStore
                                productStore.delegate = controller
                                controller.delegate = scalesTVC
                                self.present(controller, animated: true, completion: nil)
                            }
                        } else {
                            displayNoInternetAlert()
                        }
                    }
                }
            }

        else {
            updateScaleButtonAndAddNotes(scaleOrChord: scaleOrChord)
        }
    }
    
    func displayNoInternetAlert() {
        let title = "No Network Connection"
        let message = "We are currently unable to connect to the App Store. Please check your network connection."
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let dismissInternetAlertAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        ac.addAction(dismissInternetAlertAction)
        
        present(ac, animated: true, completion: nil)
        
    }
    
    func displayCantMakePaymentsAlert () {
        let title = "App Store Unavailable"
        let message = "Payments cannot be made at this time. Please check your restriction settings."
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let dismissInternetAlertAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        ac.addAction(dismissInternetAlertAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    func updateScaleButtonAndAddNotes(scaleOrChord: String) {
        // print(#function) // Displays function when called.
        scaleSelectionButton.setTitle(scaleOrChord, for: .normal)
        scaleSelectionButton.setNeedsDisplay()
        
        if scalesTVC.doShowScales == 0 {
            selectedBoard.scaleSettings.scaleOrChord = scaleOrChord
        }
            
        else if scalesTVC.doShowScales == 1 {
            selectedBoard.chordSettings.scaleOrChord = scaleOrChord
        }
            
        else {
            selectedBoard.basicChordSettings.scaleOrChord = scaleOrChord
        }
        addNotesAction()
    }

    
    //###########################
    // colorSelectorTVCDelegate Method
    // use the color for note selections or additions.
    func colorChanged(color: UIColor) {
        // print(#function) // Displays function when called.
        
        colorButton.backgroundColor = color
        selectedBoard.setUserColor(color)
      //  if selectedBoard.allowsCustomizations == false {
            addNotesAction()
       // }
    }
    
    // Delegate function for CollectionsTVCDelegate
    // Select the collection corresponding to the index and update the fretboard view.
    func collectionWasSelected(index: Int, isNewCollection: Bool) {
        
        fbCollectionStore.savedCollectionIndex = index
        selectedCollection = fbCollectionStore.arrayOfFBCollections[index]
        // Setting the model index automatically sets the selectedBoard.
        modelIndex = selectedCollection.modelIndex
        collectionTitleTextField.text = selectedCollection.title 
       
        
        loadSettingsFromSelectedBoard()
        
        tableView.reloadData()
        // If the collection is new add notes,
        if isNewCollection {
            
            addNotesAction()
        }
        else {
            // Otherwise, just load the settings.
            updateFretboardView()
            hideOrShowEditTableViewButton()
        }
        
        // Update tableView
        
        let indexPath = IndexPath(row: modelIndex, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        // Select the correct board and load the fretboard view.
        
    }
}

    




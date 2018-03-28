//
//  ViewController.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 12/11/17.
//  Copyright © 2017 Gire. All rights reserved.
//

import UIKit
import AudioKit

class FBViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPopoverPresentationControllerDelegate, ScalesTVCDelegate, ColorSelectorTVCDelegate, CollectionsTVCDelegate {


    

    // FBCollectionAndIndexDelegate method for receiving collection and index from previous VC. 
 /*   func receive(collectionAndIndex: FBCollectionAndIndex) {
        fbCollectionAndIndex = collectionAndIndex
    } */

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
    
    let arrrayOfDisplayModes = ["Notes", "Fret Numbers","Intervals", "Numbers 0-11", "Numbers 0-36"]
    let arrayOfRootNotes = ["A", "B", "C", "D", "E", "F", "G"]
    let arrayOfAccidentals = ["Natural", "b", "#" ]
    let chordFormulas = ChordFormulas()
    
    //###################################
    // Other Constants
    //############
    
    let lightYellowColor = UIColor(red: 1, green: 1, blue: 155/255, alpha: 1)
    let pinkColor = UIColor(red: 1, green: 0.5, blue: 0.5, alpha: 1)
    let sixTonesController = SixTones()
    
    
    //###################################
    // Array Variables
    //############
    
    var fbCollectionStore: FBCollectionStore!
    
    // Variable to keep track of views updated during a single view track event.
    // Is a dictionary of view IDs and Bools.
    // Bool: yes = canUpdate.
    // If I exited the views bounds, I can can update it,
    // if I didn't leave the bounds, I cannot update.
    var dictOfTouchedNoteViewNumbers = [Int: Bool]()

    // FBCollectionModel needs to be provided by the delegate.
    //var fbCollectionModel: FBCollectionModel!
    //var fbCollectionToLoadIndex = 0
    
 //   var fbCollectionAndIndex = FBCollectionAndIndex()
    
    
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
    
    
    let scalesTVC = ScalesTVC()
    let colorSelectorTVC = ColorSelectorTVC()
    let collectionsTVC = CollectionsTVC()
    
    
    

    //###################################
    // Actions
    //
    //############
    
    
    func hideOrDisplayAllControls(doHide: Bool) {
        fretboardTitleTextField.isHidden = doHide
        lockSwitch.isHidden = doHide
        LockedStatusLabel.isHidden = doHide
        rootPickerView.isHidden = doHide
        accidentalPickerView.isHidden = doHide
        scaleSelectionButton.isHidden = doHide
        colorButtonBorderView.isHidden = doHide
        colorButton.isHidden = doHide
        customizationSwitch.isHidden = doHide
        customizationLabel.isHidden = doHide
        displayModePickerView.isHidden = doHide
    }

    @IBAction func showScalesOrChords(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            scalesTVC.doShowScales = true
            scaleSelectionButton.setTitle(scalesTVC.selectedScale, for: .normal)
            selectedBoard.doShowScales = true
        }
        else {
            scalesTVC.doShowScales = false
            scaleSelectionButton.setTitle(scalesTVC.selectedChord, for: .normal)
            selectedBoard.doShowScales = false
        }
        
        // I need to reload the data based on that value.
        scalesTVC.selectSavedRow()
        if selectedBoard.allowsCustomizations == false {
        addNotesAction()
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
            tableView.selectRow(at: IndexPath(row: modelIndex, section: 0), animated: true, scrollPosition: .top)
            // When done editing.
        } else {
            tableView.isEditing = false
            sender.setTitle("Edit Collection", for: .normal)
            // If there are any fretboards left select the top fretboard.
            
            // FYI: All updates to the model index are done in the moveRow and commit editing tableView functions.
            let indexPath = IndexPath(row: modelIndex, section: 0)
            
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
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
        
       
        
       /* if selectedCollection.arrayOfFretboardModels.count == 0 {
            hideOrDisplayAllControls(doHide: false)
        }*/
        
        
        //     if let indexPath = tableView.indexPathForSelectedRow {
        // Adding 1 to the row to get the row after the selected fretboard.
        let row = selectedCollection.arrayOfFretboardModels.count
        let lastIndexPath = IndexPath(row: row, section: 0)
        selectedCollection.arrayOfFretboardModels.append(FretboardModel())
        tableView.insertRows(at: [lastIndexPath], with: .automatic)
        tableView.selectRow(at: lastIndexPath, animated: true, scrollPosition: .top)
        
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
        
        if scalesTVC.doShowScales {
            scale = arrayOfStrings[2]
        }
        else {
            scale = scalesTVC.selectedChord
        }
        
        let newTitle = "\(root)\(accidental)  \(scale)"
        selectedBoard.setFretboardTitle(newTitle)
        fretboardTitleTextField.text = newTitle
        fretboardTitleTextField.setNeedsDisplay()
        
        let indexPath = tableView.indexPathForSelectedRow!
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
 
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
        scalesTVC.arrayOfChordNames = chordFormulas.arrayOfShapeNames
        
        selectedCollection = fbCollectionStore.arrayOfFBCollections[fbCollectionStore.savedCollectionIndex]
        collectionTitleTextField.text = selectedCollection.title
        
        //Setting the modelIndex updates the SelectedIndex as well. 
        modelIndex = selectedCollection.modelIndex
        // Select in tableView and load settings.
        let indexPath = IndexPath(row: modelIndex, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
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
            if selectedCollection.image == nil {
                updateToneArraysCreator()
                loadToneArraysIntoSelectedBoard()
                
            }
            updateFretboardView()
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
 
        
        var scale = scalesTVC.selectedScale
        if scalesTVC.doShowScales == false {
            scale = scalesTVC.selectedChord
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
        
        if scalesTVC.doShowScales {
            
                toneArraysCreator.updateWithValues(arrayOfPickerStrings[0],
                                                   accidental: arrayOfPickerStrings[1],
                                                   scaleName: arrayOfPickerStrings[2])
               if selectedBoard.allowsCustomizations == false {
                autoSetFretboardTitle(arrayOfStrings: arrayOfPickerStrings)
            }
        }
            // Otherwise load chords.
        else {
            chordCreator.buildChord(root: arrayOfPickerStrings[0], accidental: arrayOfPickerStrings[1], chord: arrayOfPickerStrings[2])
            
            if selectedBoard.allowsCustomizations == false {
                autoSetFretboardTitle(arrayOfStrings: arrayOfPickerStrings)
            }
        }
    }
    
    
    //############
    // Loads ToneArrays into the selectedBoard and updates the view.
    func loadToneArraysIntoSelectedBoard() {
        // print(#function) // Displays function when called.
        
        // I've showing scales, load from the toneArrays Creator.
        if scalesTVC.doShowScales {
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
        // Otherwise, load from chordCreator
        else {
             selectedBoard.addNoteModels(newArray: chordCreator.fretboardModel.getFretboardArray())
            
        }
        
        /* Why the fuck would updateNoteModeDisplaySettings fuck up adding chords. */
    }
    
    //############
    func updateFretboardView() {
        // print(#function) // Displays function when called.
        
        let displayMode = DisplayMode(rawValue: selectedBoard.getDisplayMode())!
        
        fretboardView.updateSubviews(selectedBoard.getFretboardArray(), displayMode: displayMode)
      
        // Otherwise customizations are allowed, add from extraFretboardModel

        
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
        
        // load all pickerView and TVC (scale) selections.
        rootPickerView.selectRow(selectedBoard.rootNote, inComponent: 0, animated: true)
        accidentalPickerView.selectRow(selectedBoard.accidental, inComponent: 0, animated: true)
        
        // loads doShowScalesSettings.
        if selectedBoard.doShowScales {
            doShowScalesControl.selectedSegmentIndex = 0
            scalesTVC.doShowScales = true
        } else {
            doShowScalesControl.selectedSegmentIndex = 1
            scalesTVC.doShowScales = false
        }
        
        updateScaleSelectionButton()
        
        displayModePickerView.selectRow(selectedBoard.getDisplayMode(), inComponent: 0, animated: false)
        
        // loadUserColor
        colorButton.backgroundColor = selectedBoard.getUserColor()
    }
    
    func updateScaleSelectionButton() {
        // get the indexPath from the selected board which was selected prior to this function being called.
        let indexPath = selectedBoard.doShowScales ? selectedBoard.scaleIndexPath : selectedBoard.chordIndexPath
       
        // Select the row in the scalesTVC.tableView.
        scalesTVC.selectSavedRow()
        // Set the scalesTVC.selectedScale string to match the indexPath pulled from the selected Board.
        scalesTVC.updateSelectedScaleOrChord(index: indexPath.row)
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
                                                self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                                                
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
            return arrrayOfDisplayModes.count
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
            let data = arrrayOfDisplayModes[row]
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
            selectedBoard.setDisplayMode(index: row)
        
            updateFretboardView()
        }
        else {
            switch pickerView {
            case rootPickerView:
                selectedBoard.rootNote = row
            case accidentalPickerView:
                selectedBoard.accidental = row
            default:
                print("\(#function): Error: pickerView selection was not rootPickerView or accidentalPickerView")
            }
                addNotesAction()
 
        }
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
    func scaleChanged(text: String, indexPath: IndexPath) {
        
        // print(#function) // Displays function when called.
        scaleSelectionButton.setTitle(text, for: .normal)
        scaleSelectionButton.setNeedsDisplay()
        if selectedBoard.doShowScales {
            selectedBoard.scaleIndexPath = indexPath
        } else {
            selectedBoard.chordIndexPath = indexPath
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
    
    override func viewWillDisappear(_ animated: Bool) {
        //djfhkhjsdTest
        selectedCollection.image = backgroundView.asImage()
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
        tableView.reloadData()
        let indexPath = IndexPath(row: modelIndex, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        // Select the correct board and load the fretboard view.
        
    }
    
 }



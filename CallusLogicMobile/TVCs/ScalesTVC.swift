//
//  RootTableViewController.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 2/14/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import UIKit

protocol ScalesTVCDelegate: class {
    func scaleChanged(text: String, indexPath: IndexPath)
}

class ScalesTVC: UITableViewController {

    
    var selectedScale = "Minor Pentatonic Scale"
    var selectedChord = "Minor Chord (shape 1)"
    
    var arrayOfScaleNames = [String]()
    var editedArrayOfChordNames: [String]!
    
    var chordFormulas: ChordFormulas!
    
    var doShowScales  = true
    
    weak var delegate: ScalesTVCDelegate?
    
    func updateArrayOfChordNames(root: String, accidental: String) {
        // Obtain full root.
        var fullRoot = root
        if accidental != "Natural" {
            fullRoot.append(accidental)
        }
        
        // save current chord name to see if it's still there after editing the arrayOfChordNames.
        let selectedChordCopy = selectedChord
        //let savedRow = tableView.indexPathForSelectedRow?.row
        
        // Find all chords that are invalid for the full root. Somehow
        let arrayOfInvalidChords = chordFormulas.getInvalidChordNamesForRoot(fullRoot: fullRoot)
        var arrayOfChordNamesCopy = chordFormulas.arrayOfShapeNames
        
        // For each chordName in the arrayOfInvalidChords
        for chordName in arrayOfInvalidChords {
            
            // Find the index and remove from the copy.
            if let index = arrayOfChordNamesCopy.index(of: chordName) {
                arrayOfChordNamesCopy.remove(at: index)
            }
        }
        
        editedArrayOfChordNames = arrayOfChordNamesCopy
        tableView.reloadData()
        
        var indexPath = IndexPath()
        // Check if the previously selected position was removed from arrayOfChordNamesCopy.
        if let row =  arrayOfChordNamesCopy.index(of: selectedChordCopy) {
            indexPath = IndexPath(row: row, section: 0)
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
            selectedChord = editedArrayOfChordNames[row]
            
            // Otherwise, find a similar or close postion and select that one.
        }   else {
            //remove all text from the parentheses
            var editedChordName = selectedChordCopy
            for _ in 1...9 {
                editedChordName.removeLast()
            }

            
            // search the arrayOfChordNamesCopy for the substring.
            for index in 0..<arrayOfChordNamesCopy.count {
                // If you find a valid row, select that row
                if arrayOfChordNamesCopy[index].contains(editedChordName) {
                    indexPath = IndexPath(row: index, section: 0)
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                    selectedChord = editedArrayOfChordNames[index]
                    // Otherwise, no match was found set a default and print an error message.
                }   else {
                    indexPath = IndexPath(row: 0, section: 0)
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                    selectedChord = editedArrayOfChordNames[0]
                    print("Error in \(#function): no valid row selection found. Row set to default value.")
                }
            }
        }
    }
    

    
    func updateSelectedScaleOrChord(index: Int) {
        if doShowScales {
            selectedScale = arrayOfScaleNames[index]
        } else {
            selectedChord = editedArrayOfChordNames[index]
        }
    }
    
    func getTitleOfSelection()-> String {
        if doShowScales {
            return selectedScale
        } else {
            return selectedChord
        }
    }
    
    init(){
        super.init(style: .plain)
        buildArrayOfScaleNames()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "scale")
        selectedScale = arrayOfScaleNames[21]
        
        modalPresentationStyle = .popover
        preferredContentSize = CGSize(width: 300, height: 500)
    
        // Copies the array
       // editedArrayOfChordNames = chordFormulas.arrayOfShapeNames
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     /*   buildArrayOfScaleNames()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "scale")
        selectedScale = arrayOfScaleNames[0]
 
 */
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //############
    // Adds the scale names to the Scale PopUp
    func buildArrayOfScaleNames(){
        let scalesDict = ScalesByIntervals()
        for index in 0...(scalesDict.getScaleArray().count - 1){
            arrayOfScaleNames.append(scalesDict.getScaleArray()[index].getScaleName())
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if doShowScales {
            return arrayOfScaleNames.count
        }
        else {
            return editedArrayOfChordNames.count
        }
    }

    // Note the withIdentifier needs to be set to the correct rootNote if for this to work.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        let cell =  tableView.dequeueReusableCell(withIdentifier: "scale", for: indexPath)
       
        let bgColorView = UIView()
        // Color is LightBlue
        let color = UIColor(red: 0, green: 0.6, blue: 1.0, alpha: 0.5)
        bgColorView.backgroundColor = color
        cell.selectedBackgroundView = bgColorView
        

        // Configure the cell...
        if doShowScales {
            cell.textLabel?.text = arrayOfScaleNames[indexPath.row]
        }
        else {
            cell.textLabel?.text = editedArrayOfChordNames[indexPath.row]
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Dissmiss the view after a selection is made.
        
        if doShowScales {
           selectedScale = arrayOfScaleNames[indexPath.row]
        }
        else {
            selectedChord = editedArrayOfChordNames[indexPath.row]
        }
        // selectedScale = doShowScales ? arrayOfScaleNames[indexPath.row] : arrayOfChordNames[indexPath.row]
        let text = doShowScales ? selectedScale : selectedChord
        delegate?.scaleChanged(text: text, indexPath: indexPath)
        dismiss(animated: true, completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        if doShowScales {
            if let row = arrayOfScaleNames.index(of: selectedScale) {
                tableView.selectRow(at: IndexPath(row: row, section: 0) , animated: true, scrollPosition: .top)
            }
        }
        else {
            // This should probably go in viewWillAppear. 
            tableView.reloadData()
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        }
    }
    
    func selectSavedRow() {
        tableView.reloadData()
        if doShowScales {
            if let row = arrayOfScaleNames.index(of: selectedScale) {
                tableView.selectRow(at: IndexPath(row: row, section: 0) , animated: true, scrollPosition: .top)
            }
        }
        else {
            if let row = editedArrayOfChordNames.index(of: selectedChord) {
                tableView.selectRow(at: IndexPath(row: row, section: 0) , animated: true, scrollPosition: .top)
            }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

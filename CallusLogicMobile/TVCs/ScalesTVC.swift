//
//  RootTableViewController.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 2/14/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import UIKit

protocol ScalesTVCDelegate: class {
    func scaleChanged(scaleOrChord: String)
}

class ScalesTVC: UITableViewController, UnlockProViewControllerDelegate {

    

    var fbCollectionStore: FBCollectionStore!
    
    var selectedScale = "Minor Pentatonic Scale"
    var selectedChord = "Minor Chord (v1)"
    var selectedBasicChord = "E Chord"
    
    var arrayOfSampleScalesAndChords = [String]()
    var arrayOfScaleNames = [String]()
    var arrayOfChordNames: [String]!
    var arrayOfBasicChordNames: [String]!
    
    //var chordFormulas: ChordFormulas!
    
    var doShowScales  = 0
    
    weak var delegate: ScalesTVCDelegate?
    
    func selectSavedRow() {
        tableView.reloadData()
        
        var row = 0
        if doShowScales == 0 {
            if let testRow = arrayOfScaleNames.index(of: selectedScale) {
                row = testRow
            }
            
        }   else if doShowScales == 1 {
            if let testRow = arrayOfChordNames.index(of: selectedChord) {
                row = testRow
            }
            
        }   else {
            if let testRow = arrayOfBasicChordNames.index(of: selectedBasicChord) {
                row = testRow
            }
        }
        
        tableView.selectRow(at: IndexPath(row: row, section: 0) , animated: true, scrollPosition: .middle)
    }
    
    func updateSelectedScaleOrChord(scaleOrChord: String) {
        if doShowScales == 0 {
            if arrayOfScaleNames.contains(scaleOrChord) {
                selectedScale = scaleOrChord
            } else {
                selectedScale = arrayOfScaleNames[1]
            }
        }
            
        else if doShowScales == 1 {
            if arrayOfChordNames.contains(scaleOrChord) {
                selectedChord = scaleOrChord
            } else {
                selectedScale = arrayOfChordNames[0]
            }
        }
            
        else {
            if arrayOfBasicChordNames.contains(scaleOrChord) {
                selectedBasicChord = scaleOrChord
            } else {
                selectedBasicChord = arrayOfBasicChordNames[0]
            }
        }
    }
    
    func getTitleOfSelection()-> String {
        if doShowScales == 0 {
            return selectedScale
        
        }   else if doShowScales == 1 {
                return selectedChord
        
        }   else {
            return selectedBasicChord
        }
    }
    
    init(){
        super.init(style: .plain)
        buildArrayOfScaleNames()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "scale")
        selectedScale = arrayOfScaleNames[21]
        
        modalPresentationStyle = .popover
        preferredContentSize = CGSize(width: 300, height: 500)
        
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
        if doShowScales == 0 {
            return arrayOfScaleNames.count
        
        }   else if doShowScales == 1 {
            return arrayOfChordNames.count
            
        }   else {
            return arrayOfBasicChordNames.count
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
        if doShowScales == 0 {
            cell.textLabel?.text = arrayOfScaleNames[indexPath.row]
            
        }   else if doShowScales == 1 {
            cell.textLabel?.text = arrayOfChordNames[indexPath.row]
            
        }   else {
            cell.textLabel?.text = arrayOfBasicChordNames[indexPath.row]
        }
        
        if fbCollectionStore.allowsPro == false {
            
            if arrayOfSampleScalesAndChords.contains((cell.textLabel?.text)!) == false {
                cell.backgroundColor = UIColor.lightGray
            } else {
                cell.backgroundColor = UIColor.white
            }
        } else {
            cell.backgroundColor = UIColor.white
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Dissmiss the view after a selection is made.
        
        if doShowScales == 0 {
           selectedScale = arrayOfScaleNames[indexPath.row]
        
        }   else if doShowScales == 1 {
            selectedChord = arrayOfChordNames[indexPath.row]
            
        }   else {
            selectedBasicChord = arrayOfBasicChordNames[indexPath.row]
            
        }
        
       var scaleOrChord = ""
        if doShowScales == 0 {
            scaleOrChord = selectedScale
        }
        else if doShowScales == 1 {
            scaleOrChord = selectedChord
        }
        else  {
            scaleOrChord = selectedBasicChord
        }
        dismiss(animated: true, completion: nil)
        delegate?.scaleChanged(scaleOrChord: scaleOrChord)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        var row = 0
        if doShowScales == 0 {
            // get row of selected scale
            if let testRow = arrayOfScaleNames.index(of: selectedScale) {
                row = testRow
            }
            
        }   else if doShowScales == 1 {
            // Get row of selected Chord.
                if let testRow = arrayOfChordNames.index(of: selectedChord) {
                    row = testRow
                }
            // Get the row of the selected basic chord.
        }   else {
                if let testRow = arrayOfBasicChordNames.index(of: selectedBasicChord) {
                    row = testRow
                }
           
        }
         tableView.selectRow(at: IndexPath(row: row, section: 0) , animated: true, scrollPosition: .middle)
    }
    
    // UnlockProViewController Delegate.
    func reloadData() {
        tableView.reloadData()
        selectSavedRow()
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

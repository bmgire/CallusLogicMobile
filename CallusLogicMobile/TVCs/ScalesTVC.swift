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
    var arrayOfChordNames: [String]! // = ["Minor Chord (shape 1)", "Minor Chord (shape 2)"]
    
    var doShowScales  = true
    
    weak var delegate: ScalesTVCDelegate?
    
    func updateSelectedScaleOrChord(index: Int) {
        if doShowScales {
            selectedScale = arrayOfScaleNames[index]
        } else {
            selectedChord = arrayOfChordNames[index]
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
            return arrayOfChordNames.count
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
            cell.textLabel?.text = arrayOfChordNames[indexPath.row]
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Dissmiss the view after a selection is made.
        
        if doShowScales {
           selectedScale = arrayOfScaleNames[indexPath.row]
        }
        else {
            selectedChord = arrayOfChordNames[indexPath.row]
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
            if let row = arrayOfChordNames.index(of: selectedChord) {
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

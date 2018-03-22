//
//  CollectionsTVC.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 3/20/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import UIKit

protocol CollectionsTVCDelegate: class {
    
    func collectionWasSelected(index: Int)
}


class CollectionsTVC: UITableViewController {

    let TVHeader = UITableViewHeaderFooterView()

    var collectionStore: FBCollectionStore!
    
    var editButton: UIButton?
    
    weak var delegate: CollectionsTVCDelegate?
    
    init(){
        super.init(style: .plain)
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "collectionCellReuseID")
        
        let xib = UINib(nibName: "headerView", bundle: nil)
        tableView.register(xib, forHeaderFooterViewReuseIdentifier: "headerView")
        
        modalPresentationStyle = .popover
        preferredContentSize = CGSize(width: 300, height: 500)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func addCollection(_ sender: UIButton) {
        
        let lastRow = collectionStore.arrayOfFBCollections.count
        print(lastRow)
        let lastIndexPath = IndexPath(row: lastRow, section: 0)
        collectionStore.appendCollection()
        
        tableView?.insertRows(at: [lastIndexPath], with: .automatic)
        tableView?.selectRow(at: lastIndexPath, animated: true, scrollPosition: .top)
        
        
        editButton = tableView.headerView(forSection: 0)?.subviews[1] as? UIButton
        if (editButton?.isHidden)! && collectionStore.arrayOfFBCollections.count > 1 {
            editButton?.isHidden = false
        }
    }
    

    @IBAction func editCollection(_ sender: UIButton) {
        // toggle edit mode.
        if tableView.isEditing == false {
            tableView.isEditing = true
            sender.setTitle("Done", for: .normal)
        } // Else, end edit mode.
        else {
            tableView.isEditing = false
            sender.setTitle("Edit", for: .normal)
            // If there are any fretboards left select the top fretboard.
            //if collectionStore.arrayOfFBCollections.count != 0 {
            
            // collectionStore.savedIndexPath is updated in moveRow and editing the tableView.
            let indexPath = IndexPath(row: collectionStore.savedCollectionIndex, section: 0)
            print(collectionStore.savedCollectionIndex)
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                // Else there are no fretboardCollections. Set imageView to nil and display no preview label.
           /* } else {
                // Create a tableView and select it. 
                
            } */
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editButton = tableView.headerView(forSection: 0)?.subviews[1] as? UIButton
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return collectionStore.arrayOfFBCollections.count
        //return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCellReuseID", for: indexPath)
        cell.textLabel?.text = collectionStore.arrayOfFBCollections[indexPath.row].title
        // Configure the cell...

        return cell
    }
   
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        let indexPath = IndexPath(row: self.collectionStore.savedCollectionIndex, section: 0)
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if collectionStore.arrayOfFBCollections.count < 2 {
            
            editButton = tableView.headerView(forSection: 0)?.subviews[1] as? UIButton
            editButton?.isHidden = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.collectionWasSelected(index: collectionStore.savedCollectionIndex)
    }
    
    override  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView")
      //  cell?.textLabel?.text = "Test"
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

            // update the FBCollectionStore.
            let collection = collectionStore.arrayOfFBCollections[sourceIndexPath.row]
            collectionStore.removeCollection(collection: collection)
            collectionStore.arrayOfFBCollections.insert(collection, at: destinationIndexPath.row)
        
        if sourceIndexPath.row == collectionStore.savedCollectionIndex {
            collectionStore.savedCollectionIndex = destinationIndexPath.row
        }
            // If the source.row is greater than the collectionIndex,
            // && the destination.row is less than or equal to the collectionIndex,
            // add 1 to the collectionIndex
        else if sourceIndexPath.row > collectionStore.savedCollectionIndex && destinationIndexPath.row <= collectionStore.savedCollectionIndex {
            
            collectionStore.savedCollectionIndex += 1
        }
            // If the source.row is less than the collectionIndex,
            // && the destination.row is greater than or to the collectionIndex,
            // decrement the collectionIndex.
        else if sourceIndexPath.row < collectionStore.savedCollectionIndex && destinationIndexPath.row >= collectionStore.savedCollectionIndex {
            collectionStore.savedCollectionIndex -= 1
        }
    }
    
   
    // Presents editing alerts.
    override func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        // Presents editing alerts.
        if editingStyle == .delete {
            // get an instance of the model
            let collection = collectionStore.arrayOfFBCollections[indexPath.row]
            
            let title = "Delete \"\(collection.title)\"?"
            let message = "Are you sure you want to delete this collection of fretboards?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            if let popoverController = ac.popoverPresentationController {
                
                let sourceView = tableView.cellForRow(at: indexPath)!.contentView
                popoverController.sourceView = sourceView
                popoverController.sourceRect = sourceView.bounds
                popoverController.permittedArrowDirections = UIPopoverArrowDirection.right
            }
            
            
            // Cancel not needed for ipad, never really shown.
            // Saving to document how it's done.
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
           let deleteAction = UIAlertAction(title: "Delete",
                                             style: .destructive,
                                             handler: { (action)-> Void in
                                                
                                                
                                                self.collectionStore.removeCollection(collection: collection)
                                                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                                                
                                                // select either the model index or the last element of the arrayOfFretboards.
                                                let last = self.collectionStore.arrayOfFBCollections.count - 1
                                                
                                                if self.collectionStore.savedCollectionIndex > last {
                                                   self.collectionStore.savedCollectionIndex = last
                                                }
                                                
                                                //self.collectionStore.savedCollectionIndex = self.collectionIndex <= last ? collectionIndex : last
                                                let indexPath = IndexPath(row: self.collectionStore.savedCollectionIndex, section: 0)
                                                self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                                                
                                                
                                                if self.collectionStore.arrayOfFBCollections.count < 2 {
                                                    
                                                    // Set the edit button as a precaution. My outlet kept causing a crash.
                                                    self.editButton = self.tableView.headerView(forSection: 0)?.subviews[1] as? UIButton
                                                    self.editButton?.isHidden = true
                                                    if self.tableView.isEditing {
                                                        self.editCollection(self.editButton!)
                                                    }
                                                }
                                              
            })
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }
    
    // Disables Swipe to delete if there are less than 2 collections
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .delete
        }
        else {
            return .none
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // signal FBCViewController to update the fretboardView with the selected Collection.
        delegate?.collectionWasSelected(index: indexPath.row)
        dismiss(animated: true, completion: nil)
    }
    
    
  /*  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Test"
    } */
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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

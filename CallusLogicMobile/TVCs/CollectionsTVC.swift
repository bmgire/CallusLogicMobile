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
        let lastIndexPath = IndexPath(row: lastRow, section: 0)
        collectionStore.appendCollection()
        
        tableView?.insertRows(at: [lastIndexPath], with: .automatic)
        tableView?.selectRow(at: lastIndexPath, animated: true, scrollPosition: .top)
        
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
            if collectionStore.arrayOfFBCollections.count != 0 {
                tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
                // Else there are no fretboardCollections. Set imageView to nil and display no preview label.
            } else {
                // Create a tableView and select it. 
                
            }
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if collectionStore.arrayOfFBCollections.count < 2 {
            
            editButton = tableView.headerView(forSection: 0)?.subviews[1] as? UIButton
            editButton?.isHidden = true
        }
    }
    
    override  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView")
      //  cell?.textLabel?.text = "Test"
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // this if statement makes sure users don't move rows, when there is only one row.
        // Ideally I'd like to prevent users from being able to click on the edit button when this happens, but 
        if collectionStore.arrayOfFBCollections.count > 1 {
            // update the FBCollectionStore -
            var array = collectionStore.arrayOfFBCollections
            
            let collection = array[sourceIndexPath.row]
            collectionStore.removeCollection(collection: collection)
            array.insert(collection, at: destinationIndexPath.row)
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
                                                
                                                if self.collectionStore.arrayOfFBCollections.count < 2 {
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
        else if collectionStore.arrayOfFBCollections.count < 2 {
            return .none
        } else {
            return .delete
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // signal FBCViewController to update the fretboardView with the selected Collection.
        delegate?.collectionWasSelected(index: indexPath.row)
        print(indexPath.row)
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

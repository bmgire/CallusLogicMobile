//
//  FB_SelectionViewController.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 3/5/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import UIKit

class FBSelectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var fbCollectionStore: FBCollectionStore!
    var delegate: FBCollectionAndIndexDelegate?
    var fbCollectionAndIndex = FBCollectionAndIndex()
    
    
    @IBOutlet var collectionTableView: UITableView!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var editTableViewButton : UIButton!
    
    @IBOutlet var viewSelectedCollection: UIButton!
    
    @IBAction func editTableView(_ sender: UIButton) {
        // toggle edit mode.
        if collectionTableView.isEditing == false {
            collectionTableView.isEditing = true
            sender.setTitle("Done", for: .normal)
        } // Else, end edit mode.
          else {
            collectionTableView.isEditing = false
            sender.setTitle("Edit", for: .normal)
            // If there are any fretboards left select the top fretboard.
            if fbCollectionStore.arrayOfFBCollections.count != 0 {
               // modelIndex = 0
                
                collectionTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
                updateImage(row: 0)
              // Else there are no fretboardCollections. Set imageView to nil and display no preview label.
            } else {
                // hide all editing controls except for the + add freboard button.
                imageView.image = nil
                viewSelectedCollection.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // If the viewLoads and there are no collectionModels, create one.
        if fbCollectionStore.arrayOfFBCollections.count == 0 {
            fbCollectionStore.appendCollection()
            // fbCollectionStore.arrayOfFBCollections[0].arrayOfFretboardModels.append(FretboardModel())
        }
        // Select the first path - right now my code only has the one fretboard anyways.
        // Will likely not need this once I set the NSCoding protocol.
        let indexPath = IndexPath(row: 0, section: 0)
        collectionTableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
        updateImage(row: indexPath.row)
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func addFretboard(_ sender: UIButton) {
       
        let lastRow = fbCollectionStore.arrayOfFBCollections.count
        let lastIndexPath = IndexPath(row: lastRow, section: 0)
        fbCollectionStore.appendCollection()
        viewSelectedCollection.isHidden = false
        
        collectionTableView?.insertRows(at: [lastIndexPath], with: .automatic)
        collectionTableView?.selectRow(at: lastIndexPath, animated: true, scrollPosition: .top)
        updateImage(row: lastIndexPath.row)
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // This programmatically adds an edit item bar button because there is no way to add in the interface builder.

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // ###########
    // TableView dataSource protocol methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fbCollectionStore.arrayOfFBCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = collectionTableView.dequeueReusableCell(withIdentifier: "FBCollectionCell", for: indexPath)
        cell.textLabel?.text = fbCollectionStore.arrayOfFBCollections[indexPath.row].title
        cell.showsReorderControl = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: add code to show image and edit buttons
        updateImage(row: indexPath.row)
    }
    
    func updateImage(row: Int) {
        // TODO: add code to show image and edit buttons
        if let image = fbCollectionStore.arrayOfFBCollections[row].image {
            imageView.image = image
        } else {
            // The image is nil, Display no preview available message.
            imageView.image = #imageLiteral(resourceName: "nil_FB_Preview")
        }
    }
    
    
    
    
    // Presents editing alerts.
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        // Presents editing alerts.
        if editingStyle == .delete {
            // get an instance of the model
            let collection = fbCollectionStore.arrayOfFBCollections[indexPath.row]
            
            let title = "Delete \"\(collection.title)\"?"
            let message = "Are you sure you want to delete this collection of fretboards?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            if let popoverController = ac.popoverPresentationController {
                
                let sourceView = tableView.cellForRow(at: indexPath)!.contentView
                //let
                popoverController.sourceView = sourceView
                popoverController.sourceRect = sourceView.frame
                popoverController.permittedArrowDirections = UIPopoverArrowDirection.left
            }
            
            
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete",
                                             style: .destructive,
                                             handler: { (action)-> Void in
                                                
                                                self.fbCollectionStore.removeCollection(collection: collection)
                                                self.collectionTableView.deleteRows(at: [indexPath], with: .automatic)
                                                
                                                if self.fbCollectionStore.arrayOfFBCollections.count == 0 {
                                                    
                                                    self.editTableView(self.editTableViewButton)
                                                }
            })
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }
    
    // Update the FBCollectionStore to reflect the reorder
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let collection = fbCollectionStore.arrayOfFBCollections[sourceIndexPath.row]
        // Remove and insert the collection.
        fbCollectionStore.removeCollection(collection: collection)
        fbCollectionStore.arrayOfFBCollections.insert(collection, at: destinationIndexPath.row)
    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFBViewController" {
            let vc = segue.destination as! FBViewController
            // update after I setup the tableView did select row
            if let index = collectionTableView?.indexPathForSelectedRow?.row {
                // setup FBCollectionAndIndex
                fbCollectionAndIndex.collection = fbCollectionStore.arrayOfFBCollections[index]
                fbCollectionAndIndex.index = index
              
                // Set delegate and pass index
                delegate = vc
                delegate?.receive(collectionAndIndex: fbCollectionAndIndex)
                
                
            } else {
                print("\(#function): No row is selected, indexPath was nil")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let indexPath = collectionTableView.indexPathForSelectedRow!
        collectionTableView.reloadRows(at: [indexPath], with: .automatic)
        collectionTableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        updateImage(row: indexPath.row)
    }
    
    
}

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
    
    @IBOutlet var image: UIImageView!
    
    @IBAction func viewSelectedFBAction(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // If the viewLoads and there are no collectionModels, create one.
        if fbCollectionStore.arrayOfFBCollections.count == 0 {
            fbCollectionStore.appendCollection()
            fbCollectionStore.arrayOfFBCollections[0].arrayOfFretboardModels.append(FretboardModel())
        }
        // Select the first path - right now my code only has the one fretboard anyways.
        // Will likely not need this once I set the NSCoding protocol.
        let indexPath = IndexPath(row: 0, section: 0)
        collectionTableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func addFretboard(_ sender: UIButton) {
       
        let lastRow = fbCollectionStore.arrayOfFBCollections.count
        let lastIndexPath = IndexPath(row: lastRow, section: 0)
        fbCollectionStore.appendCollection()
        
        collectionTableView?.insertRows(at: [lastIndexPath], with: .automatic)
        collectionTableView?.selectRow(at: lastIndexPath, animated: true, scrollPosition: .top)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: add code to show image and edit buttons
        
        // update collectionIndex
        
    }
    // TableView Delegate Methods.
    // These methods prompt the image and options to edit the fretboardCollectionTitle.
    
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
    }
    
    
}

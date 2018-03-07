//
//  FB_SelectionViewController.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 3/5/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import UIKit

class FBSelectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource, FBCollectionAndIndexDelegate {
    
    // FBCollectionAndIndexDelegate method for receiving collection and index from previous VC.
    func receive(collectionAndIndex: FBCollectionAndIndex) {
        //
        fbCollectionAndIndex = collectionAndIndex
    }
    
    var delegate: FBCollectionAndIndexDelegate?
    
    var arrayOfFBCollectionModels = [FBCollectionModel]()
    
    var fbCollectionAndIndex = FBCollectionAndIndex()

    @IBOutlet var collectionTableView: UITableView!
    
    @IBOutlet var image: UIImageView!
    
    @IBAction func viewSelectedFBAction(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfFBCollectionModels.append(FBCollectionModel())
        arrayOfFBCollectionModels[0].arrayOfFretboardModels.append(FretboardModel())
        let indexPath = IndexPath(row: 0, section: 0)
        collectionTableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
        // Do any additional setup after loading the view.
        
        // Load the fbCollection passed to this VC.
        if let newCollection = fbCollectionAndIndex.collection {
            arrayOfFBCollectionModels[fbCollectionAndIndex.index] = newCollection
        }
        
        
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
        return arrayOfFBCollectionModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = collectionTableView.dequeueReusableCell(withIdentifier: "FBCollectionCell", for: indexPath)
        cell.textLabel?.text = arrayOfFBCollectionModels[indexPath.row].title
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
                fbCollectionAndIndex.collection = arrayOfFBCollectionModels[index]
                fbCollectionAndIndex.index = index
              
                // Set delegate and pass index
                delegate = vc
                delegate?.receive(collectionAndIndex: fbCollectionAndIndex)
                
                
            } else {
                print("\(#function): No row is selected, indexPath was nil")
            }
        }
    }
    
}

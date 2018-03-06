//
//  FB_SelectionViewController.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 3/5/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import UIKit

class FBSelectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    // Users will select these to view a fretboard model.
    var arrayOfFBCollectionModels = [FBCollectionModel]()
    
    @IBOutlet var collectionTableView: UITableView!
    
    @IBOutlet var image: UIImageView!
    
    @IBAction func viewSelectedFBAction(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfFBCollectionModels.append(FBCollectionModel())
        // Do any additional setup after loading the view.
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
    
    // TableView Delegate Methods.
    // These methods prompt the image and options to edit the fretboardCollectionTitle.
    
    
    
}

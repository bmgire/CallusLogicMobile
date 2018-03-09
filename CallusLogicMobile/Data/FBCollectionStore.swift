//
//  FBCollectionStore.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 3/7/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import Foundation


// This class is almost completely copied from BNR Homepwner. 
class FBCollectionStore {
    var arrayOfFBCollections = [FBCollectionModel]()
    
    // the return value is a URL
    let collectionArchiveURL: URL = {
        // searchy for  the URL for the .documentDirectory in the .userDomainMask location
        // Note, in ios: the 2nd argument .userDomainMask is always the same. always use .userDomainMask.
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        // append "items.archive" and return the documentDirectory.
        return documentDirectory.appendingPathComponent("fbCollections.archive")
    }()
    
    init() {
        if let archivedCollections = NSKeyedUnarchiver.unarchiveObject(withFile: collectionArchiveURL.path) as? [FBCollectionModel] {
            arrayOfFBCollections = archivedCollections
        }
    }
    
    func saveChanges()-> Bool {
        print("Saving collections to: \(collectionArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(arrayOfFBCollections, toFile: collectionArchiveURL.path)
    }
    
    // The @discarableResult annotation means the caller of this function is free to ignore the result.
    // The compiler will not care if the user uses the result.
    @discardableResult func appendCollection() -> FBCollectionModel {
        let newModel = FBCollectionModel()
        arrayOfFBCollections.append(newModel)
        return newModel
    }
    
    func removeCollection(collection: FBCollectionModel) {
        if let index = arrayOfFBCollections.index(of: collection) {
            arrayOfFBCollections.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        // Get reference to object being moved so you can reinsert it
        let movedItem = arrayOfFBCollections[fromIndex]
        
        // Remove item from array
        arrayOfFBCollections.remove(at: fromIndex)
        
        // Insert item in array at new location
       arrayOfFBCollections.insert(movedItem, at: toIndex)
    }
}

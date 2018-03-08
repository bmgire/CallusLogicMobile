//
//  FretboardCollectionModel.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 3/5/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import UIKit

class FBCollectionModel: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "collectionTitle")
        aCoder.encode(modelIndex, forKey: "collectionModelIndex")
        aCoder.encode(image, forKey: "collectionImage")
        
        count = arrayOfFretboardModels.count
        aCoder.encode(count, forKey: "collectionCount")
        for index in 0...count - 1 {
            aCoder.encode(arrayOfFretboardModels[index], forKey: "fretboardModel\(index)")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "collectionTitle") as! String
        modelIndex = aDecoder.decodeInteger(forKey: "collectionModelIndex")
        image = aDecoder.decodeObject(forKey: "collectionImage") as! UIImageView
        count = aDecoder.decodeInteger(forKey: "collectionCount")
        
        // Decode the arrayOfNoteModels. 
        for index in 0...count - 1 {
            if let fretboardModel = aDecoder.decodeObject(forKey: "fretboardModel\(index)"){
                arrayOfFretboardModels.append(fretboardModel as! FretboardModel)
            }
        }
    }
    
    override init() {
        // I'll have to provide the imageView in here, or set it to a default value maybe.
    }
    
    var count = 0
    var title = "Untitled Collection"
    var arrayOfFretboardModels = [FretboardModel]()
    var image: UIImageView!
    // Specifies which Model in the arrayOfFretboardModels is currently being shown.
    var modelIndex = 0
    
    
}

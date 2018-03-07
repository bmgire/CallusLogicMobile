//
//  FBCollectionPass.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 3/7/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import Foundation

class FBCollectionAndIndex{
    var collection: FBCollectionModel?
    var index = 0
}


protocol FBCollectionAndIndexDelegate: class {
    func receive(collectionAndIndex: FBCollectionAndIndex)
}

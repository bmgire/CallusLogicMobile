//
//  testView.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 12/13/17.
//  Copyright © 2017 Gire. All rights reserved.
//
/*
 
 Very usefull. Keeping for later. 
 
 
import UIKit

class testView: UIView {

    var path: UIBezierPath?
    var testRect: CGRect?
    
     var noteView = NoteView()
 
    
    
    //##############################
    
    override func awakeFromNib() {
        
        let point = CGPoint(x: 0, y: 0)
        let size = CGSize(width: 50, height: 50)
        
        // the frame has to be set for the noteView, or it screws up.
        // previously I was setting the noteView.bounds property but that wasn't working.
        // RULE: always set the frame for a subview, or it will default to the viewControllers view.
        noteView.frame = CGRect(origin: point, size: size)
        addSubview(noteView)
        
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
  //      let point = CGPoint(x:0, y: 0)
   //     let size = CGSize(width: frame.maxX, height: frame.maxY)
    //    let testRect = CGRect(origin: point, size: size)
        
        let path = UIBezierPath(rect: rect)
        UIColor.blue.set()
        path.fill()
    }
    


}
*/

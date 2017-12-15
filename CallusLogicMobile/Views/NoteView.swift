//
//  NoteView.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 12/13/17.
//  Copyright © 2017 Gire. All rights reserved.
//

import UIKit

class NoteView: UIView {
    


    //##########################################################
    // MARK: - Variables
    //##########################################################
    
    var viewNumberDict: [String: Int] = [:]
    
    fileprivate var displayText = ""
    
    fileprivate var isGhost = true
    
    fileprivate var isDisplayed = false
    
    fileprivate var noteFontSize: CGFloat = 24
    
    fileprivate var myColor: UIColor = UIColor.yellow
    
    // Indicates whether the button has been pressed successfully.
    fileprivate var pressed: Bool = false
    
    // Variable to hold this notes BezierPath.
    fileprivate var path: UIBezierPath?
    
    // The rect for the NoteView.
    fileprivate var noteRect: CGRect?
   
    
   
    //##########################################################
    // MARK: - getters and setters.
    //##########################################################
    
    func updateNoteView(_ noteModel: NoteModel, display: String) {
        isGhost = noteModel.getIsGhost()
        isDisplayed = noteModel.getIsDisplayed()
        
        myColor = noteModel.getMyColor()
        
        displayText = display
        // Redraw whenever this function is called updated.
        setNeedsDisplay()
    }
    

    //##########################################################
    // MARK: - Overridden functions
    //##########################################################
    
    
    override func draw(_ dirtyRect: CGRect) {
        drawNote()
        setNeedsDisplay()
    }
    
   /*
    //##########################################################
    // MARK: - Mouse Events
    //##########################################################
    
    override func mouseDown(with theEvent: UIEvent) {
        //Swift.print("mouseDown")   // Uncomment for debugging purposes.
        
        //Converts the locationInWindow to the views coorinate system.
        let pointInView = convert(theEvent.locationInWindow, from: nil)
        
        // tests if we pressed into this view.
        pressed = path!.contains(pointInView)
        
    }
   
    
    Need to update with UI version.
    override func mouseUp(with theEvent: UIEvent) {
        
        if pressed {
            // Posts a notification and specifies which object sent the notification.
            NotificationCenter.default.post(name: Notification.Name(rawValue: "noteViewMouseUpEvent"), object: self, userInfo: viewNumberDict)
        }
        pressed = false
    }
 
 */
    ///////////////////////////////////////////////////////////////////////////
    // Keyboard Event handling.
    ///////////////////////////////////////////////////////////////////////////
    
    //##########################################################
    // MARK: - First Responder
    //##########################################################
  /*
    override var acceptsFirstResponder: Bool { return true }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
    */
    //##########################################################
    // MARK: - Custom functions
    //##########################################################
    
    
    // Draws the note or number
    fileprivate func drawNote() {
        // Assigns a value to the noteRect.
       noteRect = bounds.insetBy(dx: bounds.width * 0.1, dy: bounds.height * 0.1)
        
      //  noteRect = bounds
    //    noteRect = bounds
        
        // Defines the radius of the corners of a rounded rect.
       let cornerRadius = bounds.size.height * 0.2
        
        // Assign a value to the path.
      // From macOS   path = NSBezierPath(roundedRect: noteRect!, xRadius: cornerRadius , yRadius: cornerRadius)
      path = UIBezierPath(roundedRect: noteRect!, cornerRadius: cornerRadius)
     //   path = UIBezierPath(roundedRect: noteRect, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 11, height: 11))
        
        if isDisplayed {
            
         
            // If appropriate, set alpha to ghosting transparency
            if isGhost {
                myColor = myColor.withAlphaComponent(CGFloat(0.4))
            }
            else {
                myColor = myColor.withAlphaComponent(CGFloat(1))
            }
            
 
            // Set color and fill.
            myColor.setFill()
            path?.fill()
            
 
            // Create an NSParagraphStyle object
            let paraStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            
            // Set orientation.
            paraStyle.alignment = .right
            
            // define a font.
            let font = UIFont.systemFont(ofSize: noteFontSize)
            
            // Attributes for drawing.
            let attrs = [
                NSAttributedStringKey.foregroundColor: UIColor.black,
                NSAttributedStringKey.font: font,
                NSAttributedStringKey.paragraphStyle: paraStyle]
            
            // Define an attributed string set to display the note.
            var attributedNote = NSMutableAttributedString()
            
            // Choose which displayMode mode to use.
            
            attributedNote = NSMutableAttributedString(string: displayText, attributes: attrs)
     
            attributedNote.drawCenterCustomInRect(bounds, withAttributes: attrs)
           
        
            
        }
   
    }

}

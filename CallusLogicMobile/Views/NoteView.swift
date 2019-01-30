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
    
    var viewNumber = 0
    
    var stringNumber = 0
    
    var viewNumberDict: [String: Int] = [:]
    
    var displayText = ""
    
    var isGhost = true
    
    var isDisplayed = false
    
    var noteFontSize: CGFloat = 24
    
    var myColor: UIColor = UIColor.yellow
    
    //var moveTouchIsInView = false 
    
    // Variable to hold this notes BezierPath.
    var path: UIBezierPath?
    
    // The rect for the NoteView.
    var noteRect: CGRect?
   
    
   
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
       // setNeedsDisplay()
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
    func drawNote() {
        // Assigns a value to the noteRect.
       noteRect = bounds.insetBy(dx: bounds.width * 0.1, dy: bounds.height * 0.1)
        
        // Defines the radius of the corners of a rounded rect.
       let cornerRadius = bounds.size.height * 0.2
        
        // Assign a value to the path.
      path = UIBezierPath(roundedRect: noteRect!, cornerRadius: cornerRadius)
        
        if isDisplayed {
            
            // If appropriate, set alpha to ghosting transparency
            if isGhost {
                myColor = myColor.withAlphaComponent(CGFloat(0.3))
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
            
            //Draw Note
            attributedNote = NSMutableAttributedString(string: displayText, attributes: attrs)
            
            // Test if the font needs to be changed.
            if displayText.count > 2 {
                if bounds.size.width * 0.80 < attributedNote.size().width {
                    // Create new font and attributes,
                    let newFont = UIFont.systemFont(ofSize: 18)
                    let newAttrs = [NSAttributedStringKey.foregroundColor: UIColor.black,
                                    NSAttributedStringKey.font: newFont,
                                    NSAttributedStringKey.paragraphStyle: paraStyle]
                    
                    // set the attributedNote to those new attributes.
                    attributedNote = NSMutableAttributedString(string: displayText, attributes: newAttrs)
                }
            }
            
            
            attributedNote.drawCenterCustomInRect(bounds, withAttributes: attrs)
        
        }
   
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.1
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 0
        
        layer.add(flash, forKey: nil)
    
    }

}

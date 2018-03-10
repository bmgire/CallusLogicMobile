//  Copyright © 2016 Gire. All rights reserved.
// This extension draws the note name on the right and centered vertically. 

import UIKit

extension NSAttributedString {

    func drawCenterCustomInRect(_ rect: CGRect, withAttributes: [NSAttributedStringKey : NSObject]?) {
        let stringSize = size()
        let point = CGPoint(x: rect.midX - stringSize.width/2,
                            y: (rect.maxY - stringSize.height)/2)
        
        draw(at: point)
    }
}

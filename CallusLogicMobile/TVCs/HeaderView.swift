//
//  HeaderView.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 3/22/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(rect: rect)
        UIColor.white.setFill()
        path.fill()
    }
    

}

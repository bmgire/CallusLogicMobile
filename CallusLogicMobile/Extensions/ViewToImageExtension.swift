//
//  ViewToImageExtension.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 3/10/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import UIKit

extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}




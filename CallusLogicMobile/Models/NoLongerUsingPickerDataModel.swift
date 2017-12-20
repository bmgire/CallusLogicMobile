//
//  UIPickerDataModel.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 12/11/17.
//  Copyright © 2017 Gire. All rights reserved.
//

import UIKit

class NoLongerUsingPickerDataModel: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var dataArray = [String]()
    
    fileprivate var width = 90

    //#######################
    // UIPickerViewDataSource
    //#######################
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    //#######################
    // UI PickerViewDelegate
    //#######################
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(30)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(width)
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        // Include an if depending on the picker view selected
        
        return dataArray[row]
        
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
       // Do Something
    }

    func setDataArray(_ array: [String]) {
        dataArray = array
    }

    func setWidth( newWidth: Int) {
        width = newWidth
    }

}

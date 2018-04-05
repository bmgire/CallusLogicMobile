//
//  UnlockProViewController.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 4/4/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import UIKit
import StoreKit




class UnlockProViewController: UIViewController, ProductStoreDelegate {
    
    
  
    
    
    
    
    var formattedPrice = "" 
    var allowsPro = false
    
    var productStore: ProductStore!
 
    
    // This product request likely needs to be injected into the
    var productRequest: SKProductsRequest!
    
    var product: SKProduct!
    

    @IBOutlet var priceLabel: UILabel!
    
    @IBAction func CancelUnlockPro(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unlockProAction(_ sender: UIButton) {
       productStore.submitPaymentToAppStore()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        productStore.validateProductIdentifier()
        
    }
    
    
    //######################################################
    //MARK: - ProductStoreDelegate methods
    
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func observePrice(currentFormattedPrice: String) {
        priceLabel.text = currentFormattedPrice
    }
    
    
}

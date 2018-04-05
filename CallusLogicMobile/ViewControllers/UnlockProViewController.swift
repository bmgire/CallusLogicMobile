//
//  UnlockProViewController.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 4/4/18.
//  Copyright © 2018 Gire. All rights reserved.
//

import UIKit
import StoreKit




class UnlockProViewController: UIViewController, SKProductsRequestDelegate  {
    
    var formattedPrice = "" 
    var allowsPro = false
    
    
    // This product request likely needs to be injected into the
    var productRequest: SKProductsRequest!
    
    var product: SKProduct!
    
    @IBOutlet var priceLabel: UILabel!
    
    @IBAction func CancelUnlockPro(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        validateProductIdentifier()
        
        self.modalPresentationStyle = UIModalPresentationStyle.pageSheet
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    // I might end up using this later... though I'm confused by who received thje info.
  /*  func launchProOrLock() {
        if allowsPro == false {
            // check the appStore for a receipt,
            let request = SKReceiptRefreshRequest()
            request.delegate = self
            request.start()
            
            // if there is a valid receipt, update bool.
            // Otherwise, don't update the bool. launch app as is.
        }
    } */
    
    func formatProductPrice() {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.formatterBehavior = .behavior10_4
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        if let price = numberFormatter.string(from: product.price) {
            formattedPrice = price
            priceLabel.text = formattedPrice
 
        }
    }
    
    
    // StoreKit method: validates the product identifier.
    func validateProductIdentifier() {
        let id = Set(["com.bengire.CallusLogicMobile.pro"])
        // Initialize the productRequest with the id.
        productRequest = SKProductsRequest(productIdentifiers: id)
        
        // Set self as the delegate
        productRequest.delegate = self
        
        //
        productRequest.start()
    }
    
    // The products request retrieves information about valid products,
    // along with a list of the invalid product identifiers.
    // !!!!This does not show check if a user has already bought the product
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        // There should only be one product.
        self.product = response.products[0]
        
        for invalidID in response.invalidProductIdentifiers {
            print("Error: \(#function) invalid product identifier received. Bad ID = \(invalidID)")
        }
        
        // Add code to display the Store UI.
        // Display the store only if the user can make payments.
        // Check if the user already purchased the product.
        
        formatProductPrice()
    }
    
    
}

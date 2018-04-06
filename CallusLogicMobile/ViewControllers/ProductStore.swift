//
//  ProductStore.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 4/5/18.
//  Copyright © 2018 Gire. All rights reserved.
//


import UIKit
import StoreKit

protocol ProductStoreDelegate {
    func observePrice(currentFormattedPrice: String)
    func dismissVC()
}


class ProductStore: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
 
    
    let unlockProProductID = "com.bengire.CallusLogicMobile.pro"

    
    //var formattedPrice = ""
    var allowsPro = false
    
    
    // This product request likely needs to be injected into the
    var productRequest: SKProductsRequest!
    var productReceiptRefreshRequest: SKReceiptRefreshRequest!
    
    var product: SKProduct!
    
    var delegate: ProductStoreDelegate?
    
    var fbCollectionStore: FBCollectionStore!

    
    func submitPaymentToAppStore() {
        let payment = SKMutablePayment(product: product)
        payment.quantity = 1
        // add(payment) submits to the appstore.
        SKPaymentQueue.default().add(payment)
        SKPaymentQueue.default().add(self)
        
        
    }
    
    
    // Delegate method for SKPaymentTransactionObserver
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
                let state = transaction.transactionState
                switch state {
                case .purchased, .restored:
                    let payment = transaction.payment
                    if payment.productIdentifier == unlockProProductID
                    {
                        fbCollectionStore.allowsPro = true
                        
                        
                        
                        queue.finishTransaction(transaction)
                        delegate?.dismissVC()
                    }
                    
                    // update allowsPro Bool
                    // display Pro has been unlocked
                // thank the user for their purchase.
                case .purchasing:
                   break
                // display a status update that purchasing is in progress.
                case .failed:
                   queue.finishTransaction(transaction)
                // display failed to purchase alert

                // diplay a message
                case .deferred:
                    print("Deferred")
                    break
                    // Notify the user that the payment is deferred,
                    // Allow them to go back to the app and use the locked version until the payment is processed.
                }
            }
    }
    

    

    func formatProductPrice() {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.formatterBehavior = .behavior10_4
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        if let price = numberFormatter.string(from: product.price) {
            delegate?.observePrice(currentFormattedPrice: price)
        }
    }
    
    
    // StoreKit method: validates the product identifier.
    func validateProductIdentifier() {
        
        let id = Set([unlockProProductID])
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
        
        // There is only one product.
        for product in response.products {
            if product.productIdentifier == unlockProProductID {
                self.product = product
            }
        }
        
        for invalidID in response.invalidProductIdentifiers {
            print("Error: \(#function) invalid product identifier received. Bad ID = \(invalidID)")
        }
        
        formatProductPrice()
    }
    
    func refreshAppReceipt() {
        productReceiptRefreshRequest = SKReceiptRefreshRequest()
        productReceiptRefreshRequest.delegate = self
        productReceiptRefreshRequest.start()
    }
    
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
    
}

//
//  ProductStore.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 4/5/18.
//  Copyright © 2018 Gire. All rights reserved.
//


import UIKit
import StoreKit
import SwiftyStoreKit

protocol ProductStoreDelegate {
    func observePrice(currentFormattedPrice: String)
    //func dismissVC()
    func proIsNowUnlocked()
}


class ProductStore: NSObject  /*, SKPaymentTransactionObserver  SKProductsRequestDelegate,*/  {
    

    
    
    let unlockProProductID = "com.bengire.CallusLogicMobile.pro"
    //var formattedPrice = ""
    var allowsPro = false
    
    
    // This product request likely needs to be injected into the
    var productRequest: SKProductsRequest!
    var productReceiptRefreshRequest: SKReceiptRefreshRequest!
    
    var product: SKProduct!
    //var localizedPrice: String!
    
    var delegate: ProductStoreDelegate?
    var fbCollectionStore: FBCollectionStore!

   
    /*
    // StoreKit method: validates the product identifier.
    func validateProductIdentifier() {
        
        let id = Set([unlockProProductID])
        // Initialize the productRequest with the id.
        productRequest = SKProductsRequest(productIdentifiers: id)
        
        // Set self as the delegate
        productRequest.delegate = self
        
        //
        productRequest.start()
    } */
    
    
    func swiftyRetrieveProductsInfo() {
        SwiftyStoreKit.retrieveProductsInfo([unlockProProductID]) { result in
            if let product = result.retrievedProducts.first {
                self.product = product
                
               // self.localizedPrice = product.localizedPrice!
                if let price = product.localizedPrice {
                    self.delegate?.observePrice(currentFormattedPrice: price)
                }
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            }
            else {
                print("Error: \(String(describing: result.error))")
            }
        }
    }
    
   
    /*
    func submitPaymentToAppStore() {
       
        
        let payment = SKMutablePayment(product: product)
        payment.quantity = 1
        // add(payment) submits to the appstore.
        SKPaymentQueue.default().add(payment)
        SKPaymentQueue.default().add(self)

    } */
    
    
    func swiftyPurchasePoduct() {
        SwiftyStoreKit.purchaseProduct(unlockProProductID, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
                 self.fbCollectionStore.allowsPro = true
                 self.delegate?.proIsNowUnlocked()
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                }
            }
        }
    }
    
    
    
    
    func swiftyRestorePreviousPurchases(){

        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                print("Restore Failed: \(results.restoreFailedPurchases)")
            }
            else if results.restoredPurchases.count > 0 {
                self.fbCollectionStore.allowsPro = true
                self.delegate?.proIsNowUnlocked()
            }
            else {
                print("Nothing to Restore")
            }
        }
    }
    
    
    /*
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
    } */
    

    
/*
    func formatProductPrice() {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.formatterBehavior = .behavior10_4
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        if let price = numberFormatter.string(from: product.price) {
            delegate?.observePrice(currentFormattedPrice: price)
        }
    } */
    

   /*
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
    } */
    
    /*
    func refreshAppReceipt() {
        productReceiptRefreshRequest = SKReceiptRefreshRequest()
        productReceiptRefreshRequest.delegate = self
        productReceiptRefreshRequest.start()
    } */
    
    
    
    
    //##############################################################################################################
    // Adding methods for SwiftyStoreKit
    
    //Register a Transation Observer.
    // call this in appDelegate-- app did finish launching.
    func swiftyRegisterTransactionObserver() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                }
            }
        }
    }
    

    
    func swiftyFetchEncryptedReceipt() {
        SwiftyStoreKit.fetchReceipt(forceRefresh: true) { result in
            switch result {
            case .success(let receiptData):
                let encryptedReceipt = receiptData.base64EncodedString(options: [])
                print("Fetch receipt success:\n\(encryptedReceipt)")
                
                
            case .error(let error):
                print("Fetch receipt failed: \(error)")
            }
        }
    }
    
    func swiftyVerifyReceipt() {
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "your-shared-secret")
        SwiftyStoreKit.verifyReceipt(using: appleValidator, forceRefresh: false) { result in
            switch result {
            case .success(let receipt):
                print("Verify receipt success: \(receipt)")
            case .error(let error):
                print("Verify receipt failed: \(error)")
            }
        }
        
    }
    
    func swiftyVerifyPurchase(){
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "your-shared-secret")
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productId = "com.musevisions.SwiftyStoreKit.Purchase1"
                // Verify the purchase of Consumable or NonConsumable
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: productId,
                    inReceipt: receipt)
                
                switch purchaseResult {
                case .purchased(let receiptItem):
                    print("\(productId) is purchased: \(receiptItem)")
                case .notPurchased:
                    print("The user has never purchased \(productId)")
                }
            case .error(let error):
                print("Receipt verification failed: \(error)")
            }
        }
    }
    
    
}

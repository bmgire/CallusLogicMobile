//
//  AppDelegate.swift
//  CallusLogicMobile
//
//  Created by Ben Gire on 12/11/17.
//  Copyright © 2017 Gire. All rights reserved.
//

import UIKit
import StoreKit




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    let fbCollectionStore = FBCollectionStore()
    let productStore = ProductStore()
    
    var fbViewController: FBViewController!
    var window: UIWindow?
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Load saved array of FBCollectionModels.
        
        fbViewController = window!.rootViewController as? FBViewController
        // Access the ItemsViewController and set its item store.
        fbViewController.fbCollectionStore = fbCollectionStore
        fbViewController.productStore = productStore
        
        productStore.swiftyRegisterTransactionObserver()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        // stop playing notes if the application will resign.
        fbViewController.tonesController.stopPlayingAllNotes()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        // Save all data.
        let success = fbCollectionStore.saveChanges()
        if (success) {
          //  print("Saved all of the Items")
        } else {
            print("Error in \(#function): Could not save any of the Items")
        }
        
        // stop playing notes if the application will resign.
        fbViewController.tonesController.stopPlayingAllNotes()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        // oscilators will be allowed to play notes after this function is run.
        fbViewController.tonesController.startPlayingAllNotes()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        fbViewController.tonesController.startPlayingAllNotes()

        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        // Save data.
        // Save all data.
        let success = fbCollectionStore.saveChanges()
     
        if (success) {
            print("Saved all of the Items")
        } else {
            print("Could not save any of the Items")
        }
    } 
    
    

}


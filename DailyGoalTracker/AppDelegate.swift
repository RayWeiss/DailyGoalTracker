//
//  AppDelegate.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/6/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let fileName = "progressDictionary.txt"
    var delegateGoalList: [Goal] = []
    var delegateProgressHistory: [Int:GoalProgress] = [:]
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        delegateProgressHistory[1324495491183518400] = .bad
        delegateProgressHistory[1324724834433268800] = .good
        delegateProgressHistory[1324954177683019200] = .good
        delegateProgressHistory[1325183520932769600] = .bad
        
        
        writeDictionary()
        readDictionary()

        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func readDictionary() {
        // Get documents directory
        if let documentPath = getDocumentDirStringPath() {
            
            let dictionaryPath = documentPath + "/" + fileName
            
            // Try to read
            let readDict:NSDictionary? = NSDictionary(contentsOfFile: dictionaryPath)
            
            // See if read succeeded
            if let dict = readDict {
                print("Read succeeded: \(dict)")
                //                delegateProgressHistory = dict as! [Int:GoalProgress]
                //                print("Read succeeded: \(delegateProgressHistory)")
            } else {
                // Read failed
                print("Read failed.")
                
                // Create default dictionary
                
                // Read default dicitoanry
            }
        }
    }
    
    func writeDictionary() {
        
        // Get documents directory
        if let documentPath = getDocumentDirStringPath() {
            
            let dictionaryPath = documentPath + "/" + fileName

            // convert [Int:GoalProgress] dictionary to NSMutableDictionary for writing purposes
            let muteDict:NSMutableDictionary = [:]
            for (key, value) in delegateProgressHistory {
                // get string values
                let newKey = String(key)
                let newValue = value.rawValue
                
                // add to dictionary
                muteDict[newKey] = newValue
            }
            
            // attempt to write dicitonary to file
            let success = muteDict.write(toFile: dictionaryPath, atomically: true)
            if success {
                print("Wrote the dictionary to disk")
            } else {
                print("Failed to write the dictionary to disk")
            }

        } else {
            print("Failed to get Documents path")
        }
        
    }
    
    func getDocumentDirStringPath() -> String? {
        // get document directory path
        let documentDirectory = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true)[0]
        
        // Output
//        print("Document Directory: \(String(describing: documentDirectory))")
        
        return documentDirectory
    }


}

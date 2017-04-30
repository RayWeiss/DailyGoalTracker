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

    let savedDictFileName = "progressDictionary.txt"
    let savedGoalListFileName = "goalList.txt"
    
    var delegateGoalList: [Goal] = []
    var delegateProgressHistory: [Int:GoalProgress] = [:]
    
    


    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("Will finish launching")
        
        print(delegateProgressHistory)
        readDictionary()
        loadGoalArray()
        print(delegateProgressHistory)
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print("Did finish launching")
        // pass dictionary to VC
        if let navController = window?.rootViewController as? UINavigationController{
            if let mainMenuVC = navController.viewControllers.first as? MainMenuViewController{
                print("Is Main Menu")
                mainMenuVC.ProgressHistory = delegateProgressHistory
                mainMenuVC.goalList = delegateGoalList
            } else {
                print("Is not Main Menu")
            }
        } else {
            print("Is not nav controller")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("Will Resign Active")
        
        // get dictionary from VC
        if let navController = window?.rootViewController as? UINavigationController{
            if let mainMenuVC = navController.viewControllers.first as? MainMenuViewController{
                print("Is Main Menu")
                delegateProgressHistory = mainMenuVC.ProgressHistory
                delegateGoalList = mainMenuVC.goalList
            } else {
                print("Is not Main Menu")
            }
        } else {
            print("Is not nav controller")
        }

        // save dictionary
        writeDictionary()
        saveGoalArray()
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Did Enter Background")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("Will Terminate")
    }
    
    func readDictionary() {
        // Get documents directory
        if let documentPath = getDocumentDirStringPath() {
            
            let dictionaryPath = documentPath + "/" + savedDictFileName
            
            // Try to read
            let readDict:NSDictionary? = NSDictionary(contentsOfFile: dictionaryPath)
            
            // See if read succeeded
            if let dict = readDict {
                print("Read succeeded: \(dict)")
                
                delegateProgressHistory = nsToMine(convert: dict)
                
            } else {
                // Read failed
                print("Read failed. May be first launch.")
            }
        } else {
            print("Failed to get Documents path")
        }
    }
    
    func writeDictionary() {
        
        // Get documents directory
        if let documentPath = getDocumentDirStringPath() {
            
            let dictionaryPath = documentPath + "/" + savedDictFileName

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
    
    func nsToMine(convert nsdict: NSDictionary) -> [Int:GoalProgress] {
        var myDict: [Int:GoalProgress] = [:]

        for (key, value) in nsdict {
            // convert Key to int
            let intKey = Int(key as! String)
            
            let stringValue = value as! String
            var properValue:GoalProgress
            if stringValue == "bad" {
                properValue = .bad
            }
            else if stringValue == "mediocre" {
                properValue = .mediocre
            }
            else {
                properValue = .good
            }
            
            // add to dictionary
            myDict[intKey!] = properValue
        }
        
        return myDict
    }
    
    func saveGoalArray(){
        let goalArray = delegateGoalList
        print("saving goal arrary:")
        for goal in goalArray {
            print(goal.text, goal.isCompleted)
        }
        let goalData = NSKeyedArchiver.archivedData(withRootObject: goalArray)
        UserDefaults.standard.set(goalData, forKey: "goals")
    }
    
    func loadGoalArray(){
        print("loading goal arrary")
        let goalData = UserDefaults.standard.object(forKey: "goals") as? NSData
        
        if let goalData = goalData {
            let goalArray = NSKeyedUnarchiver.unarchiveObject(with: goalData as Data) as? [Goal]
            
            if let goalArray = goalArray {
                delegateGoalList = goalArray
                for goal in goalArray {
                    print(goal.text, goal.isCompleted)
                }
            } else {
                print("goalArray did not = goalArray, may be first launch")
            }
            
        } else {
            print(" goalData did not = goalData")
        }
    }


}

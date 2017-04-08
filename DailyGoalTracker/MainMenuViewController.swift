//
//  MainMenuViewController.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/8/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    // Array to hold users daily goal list
    var goalList: [(String, Bool)] = []
    
    // Dictionary to hold past progress
    //
    // key is date.hasValue
    // value is enum "GoalProgress" possible values are .bad, .mediocre, and .good
    var ProgressHistory: [Int:GoalProgress] = [:]


    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadSampleData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get a reference to the destination view controller
        let destVC = segue.destination as? HasMainMenuProtocol
        
        // Provide the upcoming view controller with a reference to this view controller
        destVC?.mainMenuVC = self
    }

    func loadSampleData() {
        // Creat Sample Goal List
        goalList.append(("Get up at 7:00 am",false))
        goalList.append(("Eat a healthy breakfast",false))
        goalList.append(("Run 3 miles",false))
        goalList.append(("Do _____",false))
        goalList.append(("Do _____",false))
        goalList.append(("Go to bed at 10:: pm",false))

        // Creat Sample Progress history
        ProgressHistory[1367841365386344000] = GoalProgress.bad
        ProgressHistory[1368070708636094400] = GoalProgress.mediocre
        ProgressHistory[1368300051885844800] = GoalProgress.mediocre
        ProgressHistory[1368529395135595200] = GoalProgress.bad
        ProgressHistory[1368758738385345600] = GoalProgress.good
    }

}

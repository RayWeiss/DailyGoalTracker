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
    var goalList: [Goal] = []
    
    // Dictionary to hold past progress
    //
    // key is date.hashValue
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
        goalList.append(Goal(desc: "Get up at 7:00 am", done: false))
        goalList.append(Goal(desc: "Eat a healthy breakfast", done: false))
        goalList.append(Goal(desc: "Run 3 miles", done: false))
        goalList.append(Goal(desc: "Go to bed at 10:00 pm", done: false))

        // Creat Sample Progress history
        ProgressHistory[1324495491183518400] = GoalProgress.bad
        ProgressHistory[1324724834433268800] = GoalProgress.good
        ProgressHistory[1324954177683019200] = GoalProgress.good
        ProgressHistory[1325183520932769600] = GoalProgress.bad
        ProgressHistory[1325412864182520000] = GoalProgress.good
        ProgressHistory[1325871550682020800] = GoalProgress.mediocre
        ProgressHistory[1326100893931771200] = GoalProgress.mediocre
        ProgressHistory[1326330237181521600] = GoalProgress.bad
        ProgressHistory[1326559580431272000] = GoalProgress.good
        ProgressHistory[1326788923681022400] = GoalProgress.good
        ProgressHistory[1327018266930772800] = GoalProgress.mediocre
        ProgressHistory[1359585008395329600] = GoalProgress.mediocre
        ProgressHistory[1359814351645080000] = GoalProgress.bad
        ProgressHistory[1360043694894830400] = GoalProgress.good
        ProgressHistory[1360273038144580800] = GoalProgress.bad
        ProgressHistory[1360502381394331200] = GoalProgress.good
        ProgressHistory[1360731724644081600] = GoalProgress.good
        ProgressHistory[1360961067893832000] = GoalProgress.mediocre
        ProgressHistory[1361190411143582400] = GoalProgress.mediocre
        ProgressHistory[1361419754393332800] = GoalProgress.good
        ProgressHistory[1361649097643083200] = GoalProgress.good
        ProgressHistory[1361878440892833600] = GoalProgress.mediocre
        ProgressHistory[1362107784142584000] = GoalProgress.good
        ProgressHistory[1362337127392334400] = GoalProgress.mediocre
        ProgressHistory[1362566470642084800] = GoalProgress.mediocre
    }

}

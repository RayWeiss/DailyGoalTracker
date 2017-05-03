//
//  MainMenuViewController.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/8/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
        
    let mediocreCutOff = 0.30
    let goodCutOff = 0.80
    
    var goalList: [Goal] = []
    var ProgressHistory: [Int:GoalProgress] = [:]
    var todayDate: Date = NSDate() as Date

    override func viewDidLoad() {
        super.viewDidLoad()    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as? HasMainMenuProtocol
        destVC?.mainMenuVC = self
    }

    func submitProgress(forDate date: Date, withProgress progress: GoalProgress) {
        let dateHash = date.hashValue
        ProgressHistory[dateHash] = progress
    }
    
    func getProgressToSubmit() -> GoalProgress {
        let total = Double(goalList.count)
        var completed = 0.0
        for goal in goalList {
            if goal.isCompleted {
                completed += 1
            }
        }
        let percentCompleted = completed/total
        
        if percentCompleted < mediocreCutOff {
            return .bad
        }
        else if percentCompleted < goodCutOff {
            return .mediocre
        }
        else {
            return .good
        }
    }
    
    func getDateToSubmit() -> Date{
        let formatter = DateFormatter()
        var myCalendar = Calendar.current
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = myCalendar.timeZone
        formatter.locale = myCalendar.locale
        let dateString = formatter.string(from: todayDate)
        let thisDate = formatter.date(from: dateString)!
        
        return thisDate
    }
    
    func setAllGoalsToNotCompleted() {
        for goal in goalList {
            goal.isCompleted = false
        }
    }
    
    func clearHistory() {
        ProgressHistory = [:]
    }
    
}

//
//  MainMenuViewController.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/8/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var developerDatePicker: UIDatePicker!
    
    let mediocreCutOff = 0.30
    let goodCutOff = 0.80
    
    // Array to hold users daily goal list
    var goalList: [Goal] = []
    
    // Dictionary to hold past progress
    //
    // key is date.hashValue
    // value is enum "GoalProgress" possible values are .bad, .mediocre, and .good
    var ProgressHistory: [Int:GoalProgress] = [:]

    var todayDate: Date = NSDate() as Date

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        developerDatePicker.date = todayDate
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get a reference to the destination view controller
        let destVC = segue.destination as? HasMainMenuProtocol
        
        // Provide the upcoming view controller with a reference to this view controller
        destVC?.mainMenuVC = self
    }

    func submitProgress(forDate date: Date, withProgress progress: GoalProgress) {
        let dateHash = date.hashValue
        ProgressHistory[dateHash] = progress
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let newDate = sender.date
        todayDate = newDate
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
    
}

//
//  ManageProgressViewController.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/6/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

import UIKit

class ManageProgressViewController: UITableViewController, HasMainMenuProtocol {
    var mainMenuVC: MainMenuViewController?
    
    let sectionCount = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // make cell unselectable
        tableView.allowsSelection = false

        let inset = UIEdgeInsetsMake(20, 20, 20, 0)
        self.tableView.contentInset = inset
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (mainMenuVC?.goalList.count)!
        default:
            return 1
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ManageProgressTableViewCell
            // Configure the cell...
            cell.goalLabel.text = (mainMenuVC?.goalList[indexPath.row].text)!
            cell.goalAccomplished.isOn = (mainMenuVC?.goalList[indexPath.row].isCompleted)!
            
            // set switch tag as index row
            cell.goalAccomplished.tag = indexPath.row
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FinalCell", for: indexPath) as! ManageProgressFinalTableViewCell
            
            return cell
        }

    }
    
    @IBAction func toggleGoalSwitch(_ sender: UISwitch) {
        let switchIndex = sender.tag
        mainMenuVC?.goalList[switchIndex].isCompleted  = !(mainMenuVC?.goalList[switchIndex].isCompleted)!
        print("goal switch \(switchIndex) toggled")
    }

    @IBAction func submitProgressButtonPressed(_ sender: UIButton) {
        let formatter = DateFormatter()
        var myCalendar = Calendar.current
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = myCalendar.timeZone
        formatter.locale = myCalendar.locale
        let thisDate = formatter.date(from: "2017 04 28")!
        
        mainMenuVC?.submitProgress(forDate: thisDate, withProgress: .mediocre)
        print ("submitProgressButtonPressed() called")
    }
}

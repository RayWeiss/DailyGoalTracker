//
//  EditGoalsViewController.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/6/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

import UIKit

class EditGoalsViewController: UITableViewController, UITextFieldDelegate, HasMainMenuProtocol {

    var mainMenuVC: MainMenuViewController?
    
    let sectionCount = 3

    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditGoalsTableViewCell
            
            // Configure the cell...
            cell.goalTextField.text = (mainMenuVC?.goalList[indexPath.row].0)!
            cell.goalLabel.text = (mainMenuVC?.goalList[indexPath.row].0)!
            // set tags as index row
            cell.goalTextField.tag = indexPath.row
            cell.goalLabel.tag = indexPath.row
            cell.deleteGoalButton.tag = indexPath.row
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath) as! EditGoalsNewTableViewCell
            
            // set tags as index row
            cell.newGoalTextField.tag = indexPath.row
            cell.addButton.tag = indexPath.row
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FinalCell", for: indexPath) as! EditGoalsFinalTableViewCell
            
            return cell
        }
        
    }
    
    @IBAction func editGoal(_ sender: UITextField) {
        mainMenuVC?.goalList[sender.tag] = (sender.text!,false)
    }
    
    @IBAction func deleteGoal(_ sender: UIButton) {
        let goalIndex = sender.tag
        mainMenuVC?.goalList.remove(at: goalIndex)
        tableView.reloadData()
        print("delete row \(goalIndex)")
    }
    
    @IBAction func addNewGoal(_ sender: UIButton) {
        let path = IndexPath(row: 0, section: 1)
        if let cell = tableView.cellForRow(at: path) as? EditGoalsNewTableViewCell {
            let newGoal = cell.newGoalTextField.text
            mainMenuVC?.goalList.append((newGoal!,false))
            cell.newGoalTextField.text = cell.addGoalText
            tableView.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var path = IndexPath(row: textField.tag, section: 0)
        if let cell = tableView.cellForRow(at: path) as? EditGoalsTableViewCell {
            cell.goalTextField.resignFirstResponder()
            cell.goalLabel.isHidden = false
            cell.goalTextField.isHidden = true
        } else {
            path.section = 1
        }
        if let cell = tableView.cellForRow(at: path) as? EditGoalsNewTableViewCell {
            cell.newGoalTextField.resignFirstResponder()
        }

        return true
    }
}

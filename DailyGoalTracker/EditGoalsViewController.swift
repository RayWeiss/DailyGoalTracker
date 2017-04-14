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
            cell.setTitleBlackLeft(withString: (mainMenuVC?.goalList[indexPath.row].0)!)
            
            // set tags as index row
            cell.goalTextField.tag = indexPath.row
            cell.deleteGoalButton.tag = indexPath.row
            cell.goalLabelButton.tag = indexPath.row
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath) as! EditGoalsNewTableViewCell
            
            // configure the cell
            cell.setTitleBlackLeft(withString: cell.addGoalText)
            cell.newGoalTextField.text = nil
            
            // set tags as index row
            cell.newGoalTextField.tag = indexPath.row
            cell.addButton.tag = indexPath.row
            cell.newGoalLabelButton.tag = indexPath.row
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FinalCell", for: indexPath) as! EditGoalsFinalTableViewCell
            
            return cell
        }
        
    }
    
    @IBAction func newGoalLabelButtonPressed(_ sender: UIButton) {
        let goalIndex = sender.tag
        let path = IndexPath(row: goalIndex, section: 1)
        if let cell = tableView.cellForRow(at: path) as? EditGoalsNewTableViewCell {
            cell.newGoalLabelButton.isHidden = true
            cell.newGoalTextField.isHidden = false
            cell.newGoalTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func goalLabelButtonPressed(_ sender: UIButton) {
        let goalIndex = sender.tag
        let path = IndexPath(row: goalIndex, section: 0)
        if let cell = tableView.cellForRow(at: path) as? EditGoalsTableViewCell {
            cell.goalLabelButton.isHidden = true
            cell.goalTextField.isHidden = false
            cell.goalTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func editGoal(_ sender: UITextField) {
        let goalIndex = sender.tag
        let path = IndexPath(row: goalIndex, section: 0)
        if let cell = tableView.cellForRow(at: path) as? EditGoalsTableViewCell {
            if let textFieldText = sender.text {
                if !textFieldText.isEmpty {
                    cell.setTitleBlackLeft(withString: textFieldText)
                    // Update goal list
                    mainMenuVC?.goalList[goalIndex] = (textFieldText,false)
                }
            }
        }
    }
    
    @IBAction func editNewGoal(_ sender: UITextField) {
        let path = IndexPath(row: 0, section: 1)
        if let cell = tableView.cellForRow(at: path) as? EditGoalsNewTableViewCell {
            if let textFieldText = sender.text {
                if !textFieldText.isEmpty {
                    cell.setTitleBlackLeft(withString: textFieldText)
                }
            }
        }
    }
    
    @IBAction func deleteGoal(_ sender: UIButton) {
        let goalIndex = sender.tag
        mainMenuVC?.goalList.remove(at: goalIndex)
        tableView.reloadData()
    }
    
    @IBAction func addNewGoal(_ sender: UIButton) {
        let path = IndexPath(row: 0, section: 1)
        if let cell = tableView.cellForRow(at: path) as? EditGoalsNewTableViewCell {
            if let newGoal = cell.newGoalTextField.text {
                if !newGoal.isEmpty {
                    mainMenuVC?.goalList.append((newGoal,false))
                    cell.newGoalTextField.text = nil
                    tableView.reloadData()
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var path = IndexPath(row: textField.tag, section: 0)
        if let cell = tableView.cellForRow(at: path) as? EditGoalsTableViewCell {
            cell.goalLabelButton.isHidden = false
            cell.goalTextField.isHidden = true
            cell.goalTextField.resignFirstResponder()
        }
        
        path = IndexPath(row: 0, section: 1)
        if let cell = tableView.cellForRow(at: path) as? EditGoalsNewTableViewCell {
            cell.newGoalTextField.isHidden = true
            cell.newGoalLabelButton.isHidden = false
            cell.newGoalTextField.resignFirstResponder()
        }
        
        return true
    }
}

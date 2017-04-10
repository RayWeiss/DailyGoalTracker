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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make cell unselectable
        tableView.allowsSelection = false
        
        let inset = UIEdgeInsetsMake(20, 20, 20, 0)
        self.tableView.contentInset = inset
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mainMenuVC?.goalList.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditGoalsTableViewCell
        
        // Configure the cell...
        cell.goalTextField.text = (mainMenuVC?.goalList[indexPath.row].0)!
        
        // set tags as index row
        cell.goalTextField.tag = indexPath.row
        cell.deleteGoalButton.tag = indexPath.row
        
        return cell
    }
    
    @IBAction func editGoal(_ sender: UITextField) {
        mainMenuVC?.goalList[sender.tag] = (sender.text!,false)
    }
    
    @IBAction func deleteGoal(_ sender: UIButton) {
        print("delete row \(sender.tag)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let path = IndexPath(row: textField.tag, section: 0)
        let cell = tableView.cellForRow(at: path) as! EditGoalsTableViewCell
        cell.goalTextField.resignFirstResponder()

        return true
    }
}

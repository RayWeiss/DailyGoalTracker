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
    
    @IBOutlet weak var goalsTitleLabel: UILabel!
    
//    let dataArray = [("Get up at 7:00 am", false),("Eat a healthy breakfast", false), ("Run 3 miles", false), ("Do _______", false), ("Do ________", false), ("Go to bed at 10:00 pm", false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // make cell unselectable
        tableView.allowsSelection = false

        let inset = UIEdgeInsetsMake(20, 20, 20, 0)
        self.tableView.contentInset = inset
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return dataArray.count
        return (mainMenuVC?.goalList.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ManageProgressTableViewCell
        
        // Configure the cell...
        cell.goalLabel.text = (mainMenuVC?.goalList[indexPath.row].0)!
        cell.goalAccomplished.isOn = (mainMenuVC?.goalList[indexPath.row].1)!

        // set switch tag as index row
        cell.goalAccomplished.tag = indexPath.row
        
        return cell
    }
    
    @IBAction func toggleGoalSwitch(_ sender: UISwitch) {
        let switchIndex = sender.tag
        mainMenuVC?.goalList[switchIndex].1  = !(mainMenuVC?.goalList[switchIndex].1)!
        print("goal switch \(switchIndex) toggled")
    }
    
    //  keeping these for edit goals scene
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

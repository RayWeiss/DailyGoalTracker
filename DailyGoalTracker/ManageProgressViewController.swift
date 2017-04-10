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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // make cell unselectable
        tableView.allowsSelection = false

        let inset = UIEdgeInsetsMake(20, 20, 20, 0)
        self.tableView.contentInset = inset
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

}

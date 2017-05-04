//
//  DevOptionsViewController.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/30/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

import UIKit

class DevOptionsViewController: UIViewController, HasMainMenuProtocol {
    var mainMenuVC: MainMenuViewController?

    @IBOutlet weak var devOptionsSwitch: UISwitch!
    @IBOutlet weak var devOptionsLabel: UILabel!
    @IBOutlet weak var developerDatePicker: UIDatePicker!
    @IBOutlet weak var clearProgressButton: deleteButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle dev options
        devOptionsSwitch.isOn = mainMenuVC!.devOptionsOn
        if mainMenuVC!.devOptionsOn {
            devOptionsLabel.text = "On"
        } else {
            devOptionsLabel.text = "Off"
        }
        
        // Handle Date
        developerDatePicker.date = mainMenuVC!.todayDate
        
        // Handle control dis/enabling
        if mainMenuVC!.devOptionsOn {
            developerDatePicker.isEnabled = true
            clearProgressButton.isEnabled = true
        } else {
            developerDatePicker.isEnabled = false
            clearProgressButton.isEnabled = false
        }
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let newDate = sender.date
        mainMenuVC!.todayDate = newDate
    }

    @IBAction func clearProgressButtonPressed(_ sender: UIButton) {
        mainMenuVC?.clearHistory()
    }
    
    @IBAction func devOptionsToggled(_ sender: UISwitch) {
        if sender.isOn {
            mainMenuVC?.devOptionsOn = true
            devOptionsLabel.text = "On"
            developerDatePicker.isEnabled = true
            clearProgressButton.isEnabled = true
            print("dev options: on")

        } else {
            mainMenuVC?.devOptionsOn = false
            mainMenuVC?.todayDate = NSDate() as Date
            developerDatePicker.date = mainMenuVC!.todayDate
            devOptionsLabel.text = "Off"
            developerDatePicker.isEnabled = false
            clearProgressButton.isEnabled = false
            print("dev options: off")

        }
    }
    

}

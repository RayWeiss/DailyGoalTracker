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

    @IBOutlet weak var developerDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        developerDatePicker.date = mainMenuVC!.todayDate
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let newDate = sender.date
        mainMenuVC!.todayDate = newDate
    }


}

//
//  EditGoalsTableViewCell.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/9/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

import UIKit

class EditGoalsTableViewCell: UITableViewCell {

    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var deleteGoalButton: UIButton!
    @IBOutlet weak var goalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let aSelector : Selector = #selector(EditGoalsTableViewCell.goalLabelTapped)
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        goalLabel.addGestureRecognizer(tapGesture)
        
        
    }

    func goalLabelTapped(){
        goalLabel.isHidden = true
        goalTextField.isHidden = false
    }
}








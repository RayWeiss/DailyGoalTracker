//
//  EditGoalsNewTableViewCell.swift
//  DailyGoalTracker
//
//  Created by student on 4/11/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

import UIKit

class EditGoalsNewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var newGoalTextField: UITextField!
    @IBOutlet weak var newGoalLabelButton: UIButton!
    
    let addGoalText = "Add new goal..."

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setTitleBlackLeft(withString title: String) {
        let blackFontAttribute = [NSForegroundColorAttributeName: UIColor.black]
        let attributedGoalString = NSAttributedString(string: title, attributes: blackFontAttribute)
        
        newGoalLabelButton.setAttributedTitle(attributedGoalString, for: .normal)
        newGoalLabelButton.contentHorizontalAlignment = .left
    }
}

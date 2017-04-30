//
//  EditGoalsNewTableViewCell.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/11/17.
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
        let gray = UIColor(colorWithHexValue: 0x6d6b77)
        //        let blackFontAttribute = [NSForegroundColorAttributeName: UIColor.black]
        let grayFontAttribute = [NSForegroundColorAttributeName: gray]
        let attributedGoalString = NSAttributedString(string: title, attributes: grayFontAttribute)
        
        newGoalLabelButton.setAttributedTitle(attributedGoalString, for: .normal)
        newGoalLabelButton.contentHorizontalAlignment = .left
    }
}

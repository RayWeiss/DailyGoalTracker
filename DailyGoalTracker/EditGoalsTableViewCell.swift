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
    @IBOutlet weak var goalLabelButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setTitleBlackLeft(withString title: String) {
        let gray = UIColor(colorWithHexValue: 0x6d6b77)
//        let blackFontAttribute = [NSForegroundColorAttributeName: UIColor.black]
        let grayFontAttribute = [NSForegroundColorAttributeName: gray]
        let attributedGoalString = NSAttributedString(string: title, attributes: grayFontAttribute)
        
        goalLabelButton.setAttributedTitle(attributedGoalString, for: .normal)
        goalLabelButton.contentHorizontalAlignment = .left
    }
}








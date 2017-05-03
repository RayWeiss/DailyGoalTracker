//
//  ManageProgressTableViewCell.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/6/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

import UIKit

class ManageProgressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalAccomplished: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

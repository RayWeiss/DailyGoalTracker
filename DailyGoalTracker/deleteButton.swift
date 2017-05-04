//
//  deleteButton.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/30/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

import UIKit

@IBDesignable class deleteButton: UIButton {
    
    let bgColor = UIColor(colorWithHexValue: 0xf08e8e)
    let textColor = UIColor(colorWithHexValue: 0xffffff)
    let disabledTextColor = UIColor(colorWithHexValue: 0xf2f2f2)
    let disabledBgColor = UIColor(colorWithHexValue: 0xd9a6a6)

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setAttributes()
    }
    
    func setAttributes() {
        layer.backgroundColor = bgColor.cgColor
        clipsToBounds = true
        
        layer.cornerRadius = frame.size.height / 2
        
        setTitleColor(textColor, for: UIControlState.normal)
        setTitleColor(disabledTextColor, for: UIControlState.disabled)
        titleLabel!.font = UIFont(name: "Helvetica-Bold", size: CGFloat(17.0))
    }
}

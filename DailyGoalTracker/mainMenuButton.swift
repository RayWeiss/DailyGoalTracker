//
//  mainMenuButton.swift
//  DailyGoalTracker
//
//  Created by Raymond Weiss on 4/30/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

import UIKit

@IBDesignable class mainMenuButton: UIButton {
    
    let gray = UIColor(colorWithHexValue: 0xd4dbe7)
    let yellow = UIColor(colorWithHexValue: 0xfceec6)
    let pink = UIColor(colorWithHexValue: 0xf7c9dd)
    let blue = UIColor(colorWithHexValue: 0x86b4ef)
    let white = UIColor(colorWithHexValue: 0xffffff)

    let bgColor = UIColor(colorWithHexValue: 0x86b4ef)
    let borderColor = UIColor(colorWithHexValue: 0xb3d9ff)
    let textColor = UIColor(colorWithHexValue: 0xffffff)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setAttributes()
    }
    
    func setAttributes() {
        layer.backgroundColor = bgColor.cgColor
        clipsToBounds = true
        
        layer.cornerRadius = frame.size.height / 2
        
        setTitleColor(textColor, for: UIControlState.normal)
        titleLabel!.font = UIFont(name: "Helvetica-Bold", size: CGFloat(17.0))
    }
}

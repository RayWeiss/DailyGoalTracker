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

    let bgColor = UIColor(colorWithHexValue: 0x86b4ef)//UIColor(colorWithHexValue: 0xf3f9ff)
    let borderColor = UIColor(colorWithHexValue: 0xb3d9ff)
    let textColor = UIColor(colorWithHexValue: 0xffffff)//UIColor(colorWithHexValue: 0x6c8093)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setAttributes()
    }
    
    func setAttributes() {
        // Background attributes
        layer.backgroundColor = bgColor.cgColor
        clipsToBounds = true
        
        // Border attributes
        layer.cornerRadius = frame.size.height / 2
//        layer.borderColor = borderColor.cgColor
//        layer.borderWidth = 2
        
        // Text attributes
        setTitleColor(textColor, for: UIControlState.normal)
        titleLabel!.font = UIFont(name: "Helvetica-Bold", size: CGFloat(17.0))
        
    }

    
    
}

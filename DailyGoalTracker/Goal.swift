//
//  Goal.swift
//  DailyGoalTracker
//
//  Created by Mike Zrimsek on 4/26/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

import UIKit

class Goal: NSObject, NSCoding {
    var text : String
    var isCompleted : Bool
    
    init(desc : String, done : Bool) {
        text = desc
        isCompleted = done
    }
    
    required init(coder decoder: NSCoder) {
        text = decoder.decodeObject(forKey: "text") as? String ?? ""
        isCompleted = decoder.decodeBool(forKey: "done")
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(text, forKey: "text")
        coder.encode(isCompleted, forKey: "done")
    }
}

//
//  Goal.swift
//  DailyGoalTracker
//
//  Created by Mike Zrimsek on 4/26/17.
//  Copyright © 2017 RaymondWeiss_MikeZrimsek. All rights reserved.
//

class Goal {
    var text : String
    var isCompleted : Bool
    
    init(desc : String, done : Bool) {
        text = desc
        isCompleted = done
    }
}

//
//  FoodIntake.swift
//  Gmn Clinic
//
//  Created by apple on 23/01/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import Foundation
class FoodIntake
{
    let id: Int64?
    var time: String
    var food: String
    
    init(id: Int64) {
        self.id = id
        time = ""
        food = ""
    }
    
    init(id: Int64, time: String,food: String) {
        self.id = id
        self.time = time
        self.food = food
    }
    
}

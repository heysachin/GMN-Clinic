//
//  Diet.swift
//  Gmn Clinic
//
//  Created by apple on 23/01/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import Foundation
//MARK:  diet
//private let diet = Table("diet")
//private let dietId = Expression<Int64>("id")
//private let dietTime = Expression<String>("time")
//private let dietDate = Expression<String?>("date")
//private let dietFood = Expression<String>("food")

class Diet  {
    let dietId: Int64?
    var dietTime: String
    var dietDate: String
    var dietFood: String

    
    init(id: Int64) {
        self.dietId = id
        dietTime = ""
        dietDate = ""
        dietFood = ""
    }
    
    init(id: Int64, time: String,date: String,food: String) {
        self.dietId = id
        self.dietTime = time
        self.dietDate = date
        self.dietFood = food
    }
}

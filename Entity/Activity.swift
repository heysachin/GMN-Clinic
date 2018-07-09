//
//  Activity.swift
//  Gmn Clinic
//
//  Created by apple on 23/01/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import Foundation
class Activity {
    
    //MARK:  activity
  //  private let activity = Table("activity")
  //  private let AId = Expression<Int64>("id")
   // private let ATime = Expression<String>("time")
  //  private let Activ = Expression<String?>("activity")
    
    
    let Id: Int64?
    var Time: String
    var Activity: String
    
    
    init(id: Int64) {
        self.Id = id
        Time = ""
        Activity = ""
    
    }
    
    init(id: Int64, time: String,activi: String) {
        self.Id = id
        self.Time = time
        self.Activity = activi
    }
}

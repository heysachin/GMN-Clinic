//
//  MemberDetails.swift
//  Gmn Clinic
//
//  Created by apple on 12/02/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import Foundation
class MemberDetails{
    
    
    
    let Id: Int64?
    var Name: String
    var Mobile1: Int64
    var Mobile2:Int64
    var Email1:String
    var Email2:String
    var Address:String
     var Active:Bool
    
    
    
    init(id: Int64) {
        self.Id = id
        self.Name = ""
        self.Mobile1 = 0
        self.Mobile2 = 0
        self.Email1 = ""
        self.Email2 = ""
        self.Address = ""
        self.Active = false
    }
    
    init(id: Int64, MemberName: String, Mobile1: Int64, Mobile2: Int64, Email1: String, Email2: String, Address: String, Active: Bool) {
        self.Id = id
        self.Name = MemberName
        self.Mobile1 = Mobile1
         self.Mobile2 = Mobile2
        self.Email1 = Email1
         self.Email2 = Email2
         self.Address = Address
         self.Active = Active
    }
}

//
//  File.swift
//  Gmn Clinic
//
//  Created by apple on 23/01/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import Foundation
class Foods {
    //MARK: foods
  //  private let foods = Table("foods")
  //  private let fid = Expression<Int64>("id")
  //  private let fdata = Expression<String?>("data")
    
    let id: Int64?
    var fdata: String
    
    init(id: Int64) {
        self.id = id
        fdata = ""
        
    }
    
    init(id: Int64, fdata: String) {
        self.id = id
        self.fdata = fdata
       
    }
    
}

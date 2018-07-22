//
//  BuyItems.swift
//  Gmn Clinic
//
//  Created by Sachin Dev on 12/07/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import Foundation
import UIKit

class DisplayItems: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Reached")
        
        let url="\(GlobalURL)/SaveWater?MemberNo=\(memberNo)&Date_Time=\(self.getCurrentDateTime())&BranchNo=1&Water=1"
        
        let replaced = url.replacingOccurrences(of: " ", with: "%20")
        
        print(replaced)
        
        HttpClientApi.instance().makeAPICall(url: replaced,  method: .GET, success: { (data, response, error) in
            
            if let data = data, let stringResponse = String(data: data, encoding: .utf8) {
                
                // received from a network request, for example
                let c = stringResponse.characters
                let r = c.index(c.startIndex, offsetBy: stringResponse.index(of: ":")!+2)..<c.index(c.endIndex, offsetBy: -2)
                let substring = stringResponse[r]
                let data  = substring.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
                let ta = data.data(using: .utf8)
                print(substring)
            }}

    }
    
}




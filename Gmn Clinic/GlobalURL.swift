//
//  GlobalURL.swift
//  ModernDairy
//
//  Created by apple on 04/01/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import Foundation
import UIKit
public let GlobalURL = "http://gmncservice.ezeeclub.net/Service1.svc"
//public let GlobalURL = "http://192.168.1.10:823/Service1.svc"
public func uicolorFromHex(rgbValue:UInt32)->UIColor{
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    let blue = CGFloat(rgbValue & 0xFF)/256.0
    return UIColor(red:red, green:green, blue:blue, alpha:1.0)
}

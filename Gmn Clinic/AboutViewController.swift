//
//  AboutViewController.swift
//  Gmn Clinic
//
//  Created by Sachin Dev on 23/07/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit

class AboutViewController : UIViewController{
    
    @IBOutlet weak var ContactUs : UIButton!
    @IBOutlet weak var VisitWebpage : UIButton!
    @IBOutlet weak var FacebookButton : UIButton!
    @IBOutlet weak var TwitterButton : UIButton!
    @IBOutlet weak var YoutubeButton : UIButton!
    @IBOutlet weak var PlayStoreButton : UIButton!
    @IBOutlet weak var InstagramButton : UIButton!
    
    
    @IBAction func ClickContactUs(_ sender: Any) {
        
        print("Contact Us Clicked")
        
        let email = "gmnclinic@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
    @IBAction func ClickVisitWebpage(_ sender: Any) {
        
        UIApplication.shared.openURL(NSURL(string: "http://www.geetanjalimedicalnutritionclinic.com")! as URL)
        
    }
    @IBAction func ClickFacebook(_ sender: Any) {
        
        var instagramHooks = "fb://profile/gmnclinic"
        var instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            UIApplication.shared.openURL(instagramUrl! as URL)
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "http://facebook.com/gmnclinic")! as URL)
        }
        
    }
    @IBAction func ClickTwitter(_ sender: Any) {
        
        var instagramHooks = "twitter://user?screen_name=GmnClinic"
        var instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            UIApplication.shared.openURL(instagramUrl! as URL)
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "http://twitter.com/gmnclinic")! as URL)
        }
    }
    @IBAction func ClickYoutube(_ sender: Any) {
        
        let YoutubeUser =  "UCiZWHkgYVrSA0_foEePXuig"
        let appURL = NSURL(string: "youtube://www.youtube.com/user/\(YoutubeUser)")!
        let webURL = NSURL(string: "https://www.youtube.com/user/\(YoutubeUser)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
        
    }
    @IBAction func ClickAppStore(_ sender: Any) {
        
        print("App Store Link Update")
        
    }
    @IBAction func ClickInstagram(_ sender: Any) {
        
        var instagramHooks = "instagram://user?username=gmnclinic"
        var instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            UIApplication.shared.openURL(instagramUrl! as URL)
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "http://instagram.com/gmnclinic")! as URL)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
}

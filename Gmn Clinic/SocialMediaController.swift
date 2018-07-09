//
//  SocialMediaController.swift
//  Gmn Clinic
//
//  Created by apple on 17/02/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit
extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                application.openURL(URL(string: url)!)
                return
            }
        }
    }
}
class SocialMediaController: UIViewController {

    @IBAction func fb(_ sender: Any) {
        UIApplication.tryURL(urls: [
            "fb://profile/groups/gmnclinic/?ref=bookmarks", // App
            "http://www.facebook.com/groups/gmnclinic/?ref=bookmarks"
            ])
    }
    
    @IBAction func insta(_ sender: Any) {
        

        let appURL = NSURL(string: "instagram://user?username=gmnclinic)")!
        let webURL = NSURL(string: "https://instagram.com/gmnclinic")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    @IBAction func twit(_ sender: Any) {
        
        let appURL = NSURL(string: "twitter:///user?screen_name=GmnClinic")!
        let webURL = NSURL(string: "https://twitter.com/GmnClinic")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

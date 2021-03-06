//
//  FoodReminderViewController.swift
//  Gmn Clinic
//
//  Created by Sachin Dev on 23/07/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit


struct FoodReminder: Decodable{
    
    let Day : String
    let Subject : String
    let DailyDietEmailReminder : String
    let SendEmail : String
    let Email1 : String
    let SendSMS : String
    let DietTime : String
    let DietTime1 : String
    let Diet : String
    let DsNo : String
    let MemberNo : String
    let FromDate : String
    let ToDate : String
    let Days : String
    let branchNo : String
    let MemberName : String
    let MobileNo : String
    let DailyDietRemeinder : String
    let Footer : String
    let SMSMessageMember : String
    let SMSPriorityMember : String
    let BranchName : String
    
}


class FoodReminderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var alertController: UIAlertController!
    var spinnerIndicator: UIActivityIndicatorView!
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func showProgress(show:Bool) -> Bool {
        
        if show {
            
            self.present(alertController, animated: false, completion: nil)
            return true
        }else{
            alertController.dismiss(animated: true, completion: nil);
            return true
        }
        
    }
    func showAlert(title: String,msg: String)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    var Reminders = [FoodReminder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Food"
        var memberNo=""
        var data:[LoginEntity]?
        data=CoreDataHandler.featchObject()
        
        for i in data! {
            memberNo=i.empno!
        }
        
        let url="\(GlobalURL)/GetFoodReminder?MemberNo=\(memberNo)&BranchNo=1"
        let replaced = url.replacingOccurrences(of: " ", with: "%20")
        
        print(replaced)
        alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        _ = showProgress(show: true)
        
        HttpClientApi.instance().makeAPICall(url: replaced,  method: .GET, success: { (data, response, error) in
            
            if let data = data, let stringResponse = String(data: data, encoding: .utf8) {
                
                // received from a network request, for example
                let c = stringResponse.characters
                let r = c.index(c.startIndex, offsetBy: stringResponse.index(of: ":")!+2)..<c.index(c.endIndex, offsetBy: -2)
                let substring = stringResponse[r]
                print(substring)
                let data  = substring.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
                let ta = data.data(using: .utf8)
                print(data)
                print(ta)
                do{
                    self.Reminders = try JSONDecoder().decode([FoodReminder].self, from: ta!)
                        for Reminder in self.Reminders{
                            print(Reminder)
                        }

                    self.tableView.reloadData()
                    _ = self.showProgress(show: false)

                }catch{

                }
            }
            
            // API call is Successfull
            
        }, failure: { (data, response, error) in
            print(response ?? "def")
            DispatchQueue.main.async {
                
                self.showAlert(title: "Server Error", msg: "Something went wrong. Please try again")
                
            }
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Reminders.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 125.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath)
        let reminder = Reminders[indexPath.section]
        print(reminder)
        cell.textLabel?.text = reminder.Diet
        var time1=reminder.DietTime1
        let mySubstring = time1.prefix(2)
        if Int(mySubstring)!>12{
            time1="\(Int(mySubstring)!-12)\(time1.suffix(3)) PM"
        }
        else{
            time1="\(time1) AM"
        }
        
        cell.detailTextLabel?.text =  reminder.Day + "\t" + time1
        
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = false

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIPasteboard.general.string = Reminders[indexPath.section].Diet
        self.showAlert(title: "Text Copied to Clipboard", msg: Reminders[indexPath.section].Diet)
        
        
    }
    
}

//
//  ActivityViewController.swift
//  Gmn Clinic
//
//  Created by apple on 14/02/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    

    @IBOutlet weak var act1: SearchTextField!
    
    @IBOutlet weak var act6: SearchTextField!
    
    @IBOutlet weak var act2: SearchTextField!
    
    @IBOutlet weak var act3: SearchTextField!
    
    @IBOutlet weak var act4: SearchTextField!
    
    @IBOutlet weak var act5: SearchTextField!
    
    @IBOutlet weak var dur5: SearchTextField!
    
    @IBOutlet weak var dur6: SearchTextField!
    
    @IBOutlet weak var dur1: SearchTextField!
    
    
    @IBOutlet weak var dur2: SearchTextField!
    
    @IBOutlet weak var dur4: SearchTextField!
    
    @IBOutlet weak var dur3: SearchTextField!
    
    
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
    
    
    
    
    
    
    var memberNo : String = ""
    public var date : String = ""
    var data : String = ""
    var flag1: Bool = false;
    var flag2: Bool = false;
    var flag3: Bool = false;
    var flag4: Bool = false;
    var flag5: Bool = false;
    var flag6: Bool = false;

    var actData: [String] = [String]()
    var durData : [String] = [String]()
    var stat = [FoodStatus]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Excercise"
        var data:[LoginEntity]?
        data=CoreDataHandler.featchObject()
        self.hideKeyboardWhenTappedAround()
        for i in data! {
            memberNo=i.empno!
        }
        alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        
        let button = UIButton.init(type: .custom)
//        button.setImage(UIImage.init(named: "jumping-to-the-water.png"), for: UIControlState.normal)
        button.setTitle("History", for: UIControlState.normal)
        button.addTarget(self, action:#selector(ActivityViewController
            .callBackMethod), for:.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30) //CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        act1.layer.borderWidth = 0.4
        act1.layer.cornerRadius = 0
        act1.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        
        act2.layer.borderWidth = 0.4
        act2.layer.cornerRadius = 0
        act2.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        
        act3.layer.borderWidth = 0.4
        act3.layer.cornerRadius = 0
        act3.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        
        act4.layer.borderWidth = 0.4
        act4.layer.cornerRadius = 0
        act4.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        
        act5.layer.borderWidth = 0.4
        act5.layer.cornerRadius = 0
        act5.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        
        act6.layer.borderWidth = 0.4
        act6.layer.cornerRadius = 0
        act6.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        
        
        dur1.layer.borderWidth = 0.4
        dur1.layer.cornerRadius = 0
        dur1.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        dur2.layer.borderWidth = 0.4
        dur2.layer.cornerRadius = 0
        dur2.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        dur3.layer.borderWidth = 0.4
        dur3.layer.cornerRadius = 0
        dur3.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        dur4.layer.borderWidth = 0.4
        dur4.layer.cornerRadius = 0
        dur4.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        dur5.layer.borderWidth = 0.4
        dur5.layer.cornerRadius = 0
        dur5.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        dur6.layer.borderWidth = 0.4
        dur6.layer.cornerRadius = 0
        dur6.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor

        
        
        
        
        
        
        actData.append("Slow walk");
        actData.append("Brisk walk");
        actData.append("Swimming");
        actData.append("Treadmill");
        actData.append("Cycling");
        actData.append("Elliptor");
        actData.append("Zumba");
        actData.append("Sleep");
        actData.append("Aerobics");

        
    
        durData.append("15")
        durData.append("30");
        durData.append("45");
        durData.append("60");
        durData.append("90");

        
        dur1.filterStrings(durData)
        dur2.filterStrings(durData)
        dur3.filterStrings(durData)
        dur4.filterStrings(durData)
        dur5.filterStrings(durData)
        dur6.filterStrings(durData)
        
        act1.filterStrings(actData)
        act2.filterStrings(actData)
        act3.filterStrings(actData)
        act4.filterStrings(actData)
        act5.filterStrings(actData)
        act6.filterStrings(actData)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSubmitClicked(_ sender: Any) {
        
        print(date)
        
        if act1.text != "" && dur1.text != ""
        {
        if act1.text != "" && dur1.text != ""
        {
            flag1=true
            
        }
        
        if act2.text != "" && dur2.text != ""
        {
            flag2=true
            
        }
        
        if act3.text != "" && dur3.text != ""
        {
            flag3=true
        }
        
        if act4.text != "" && dur4.text != ""
        {
            flag4=true
        }
        if act5.text != "" && dur5.text != ""
        {
            
            flag5=true
            
        }
        if act6.text != "" && dur6.text != ""
        {
            flag6=true
        }
            
             save();
            
        }else{
            
            view.makeToast(message: "Please Enter Atleast 1 Duration")
        }
    }
    
    let minut=" Minutes"
    public func save()
    {
        if flag1
        {
            data = "\(String(describing: act1.text!)) - \(String(describing: dur1.text!)+minut),\(date)"
        }
        if flag2
        {
            data = "\(data)$\(String(describing: act2.text!)) - \(String(describing: dur2.text!)+minut),\(date)"
        }
        if flag3
        {
            data = "\(data)$\(String(describing: act3.text!)) - \(String(describing: dur3.text!)+minut),\(date)"
        }
        if flag4
        {
            data = "\(data)$\(String(describing: act4.text!)) - \(String(describing: dur4.text!)+minut),\(date)"
        }
        if flag5
        {
            data = "\(data)$\(String(describing: act5.text!)) - \(String(describing: dur5.text!)+minut),\(date)"
        }
        if flag6
        {
            data = "\(data)$\(String(describing: act6.text!)) - \(String(describing: dur6.text!)),\(date)"
        }

       if showProgress(show: true)
        {
            getData()
        }
        }
     @objc func callBackMethod() {
        
       performSegue(withIdentifier: "toMyActivity", sender: self)
        //toMyActivity
        
    }
    func getData()  {
        
        
        
        let url="\(GlobalURL)/SaveActivity2_6?MemberNo=\(self.memberNo)&Date_Time=\(self.date)&BranchNo=1&Activity=\(self.data)"
        
        let replaced = url.replacingOccurrences(of: " ", with: "%20")
        
        print(replaced)
            
        
        HttpClientApi.instance().makeAPICall(url: replaced,  method: .GET, success: { (data, response, error) in
            
            
            if let data = data, let stringResponse = String(data: data, encoding: .utf8) {
                
                // received from a network request, for example
                 let c = String(stringResponse)
                    let r = c.index(c.startIndex, offsetBy: stringResponse.index(of: ":")!+2)..<c.index(c.endIndex, offsetBy: -2)
                    let substring = stringResponse[r]
                    let data  = substring.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
                    let ta = data.data(using: .utf8)
                print(substring)
                do{
                    self.stat = try JSONDecoder().decode([FoodStatus].self, from: ta!)
                    for log in self.stat{
                        if log.Status == "Success"
                        {
                            



                            DispatchQueue.main.async{
                        
                                
                                
                                
                                if self.act1.text != "" {
                                    _ =   DBHandler.instance.addActivity(time: self.TodayDate(), activity: "\(String(describing: self.act1.text!)) - \(String(describing: self.dur1.text!)+self.minut) ")
                               }

                                if self.act2.text != "" {
                                    _ =   DBHandler.instance.addActivity(time: self.TodayDate(), activity: "\(self.act2.text!) - \(self.dur2.text!+self.minut) ")
                                }
                                
                                if self.act3.text != "" {
                                    _ =   DBHandler.instance.addActivity(time: self.TodayDate(), activity: "\(self.act3.text!) - \(self.dur3.text!+self.minut) ")
                                }
                                
                                if self.act4.text != "" {
                                    _ =   DBHandler.instance.addActivity(time: self.TodayDate(), activity: "\(self.act4.text!) - \(self.dur4.text!+self.minut) ")
                                }
                                if self.act5.text != "" {
                                    _ =   DBHandler.instance.addActivity(time: self.TodayDate(), activity: "\(self.act5.text!) - \(self.dur5.text!+self.minut) ")
                                }
                                
                                if self.act6.text != "" {
                                    _ =   DBHandler.instance.addActivity(time: self.TodayDate(), activity: "\(self.act6.text!) - \(self.dur6.text!+self.minut) ")
                                }
                                        self.act1.text = ""
                                self.act2.text = ""
                                self.act3.text = ""
                                self.act4.text = ""
                                self.act5.text = ""
                                self.act6.text = ""
                                self.dur1.text = ""
                                self.dur2.text = ""
                                self.dur3.text = ""
                                self.dur4.text = ""
                                self.dur5.text = ""
                                self.dur6.text = ""
                           _ = self.showProgress(show: false)
                                self.performSegue(withIdentifier: "toMyActivity", sender: self)
                           self.view.makeToast(message: "Sucess")
                            
                            }
                        }else{
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                }catch{
                    DispatchQueue.main.async{
                    if self.showProgress(show: false)
                    {
                    print("exception \(error)")
                    }
                    self.showAlert(title: "Alret", msg: "Failed...Please try again")
                    }
                }
                
                
                
                
                
                
                
            }
            
            // API call is Successfull
            
        }, failure: { (data, response, error) in
            print(response ?? "def")
            DispatchQueue.main.async {
                if  self.showProgress(show: false){
                    self.showAlert(title: "Server Error", msg: "Something went wrong. Please try again")
                }
            }
        })
        
        
        
        
        
        
        
        
    }
    public func TodayDate() -> String
        
    {
        
        
        let yesterday = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let todaysDate = dateFormatter.string(from: yesterday!)
        
        return todaysDate
        
    }
    
    }
    
   



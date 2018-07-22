//
//  WaterViewController.swift
//  Gmn Clinic
//
//  Created by apple on 15/02/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit

class WaterViewController: UIViewController {
    @IBOutlet weak var myView: UIView!
    var wave = SPWaterProgressIndicatorView.init(frame: .zero)
    var isAnimating: Bool = false {
        didSet{
            if isAnimating {
                self.wave.startAnimation()
            } else {
                self.wave.stopAnimation()
            }
        }
        
        
    }
    
    
    
    
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
    
  var stat = [FoodStatus]()
    var memberNo : String = ""
    @IBOutlet weak var lableTarget: UILabel!
    
    
    
    @IBAction func onPlusClick(_ sender: Any) {
       _ = showProgress(show: true)
       getData()
    }
    @IBAction func onMinusClick(_ sender: Any) {
        _ = showProgress(show: true)
        Sub_Water()
    }
    @IBOutlet weak var countLable: UILabel!
    
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var data:[LoginEntity]?
        data=CoreDataHandler.featchObject()
        
        for i in data! {
            memberNo=i.empno!
        }
        
        alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.wave = SPWaterProgressIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        self.wave.center = self.view.center;
        self.view.addSubview(self.wave)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(WaterViewController.updateAnimation))
        self.wave.addGestureRecognizer(tap)
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(WaterViewController.updatePercent))
        self.wave.addGestureRecognizer(pan)
        
        
        
        buttonMinus.layer.shadowColor = UIColor.blue.cgColor
        buttonMinus.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        buttonMinus.layer.masksToBounds = false
        buttonMinus.layer.shadowRadius = 1.0
        buttonMinus.layer.shadowOpacity = 0.5
        buttonMinus.layer.cornerRadius = buttonMinus.frame.width / 2
        
        buttonPlus.layer.shadowColor = UIColor.blue.cgColor
        buttonPlus.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        buttonPlus.layer.masksToBounds = false
        buttonPlus.layer.shadowRadius = 1.0
        buttonPlus.layer.shadowOpacity = 0.5
        buttonPlus.layer.cornerRadius = buttonPlus.frame.width / 2
    updateWater()
    }
    
    public func TodayDate() -> String
        
    {
        
        
        let yesterday = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let todaysDate = dateFormatter.string(from: yesterday!)
        
        return todaysDate
        
    }
    
    public func updateWater()
    {
        let c = DBHandler.instance.getWaterCount(date: TodayDate())
        if c>=14{
            lableTarget.text = "Target Achived"
        }else{
            lableTarget.text = "Have your next glass of water after 120 minutes"
        }
        
        let pers = Double(c)/14.0*100;
        updateWawe(percent: Int64(pers))
        if c != 0
        {
            countLable.text = "\(14-c) Glasses Left"

        }else{
            
            countLable.text = "14 Glasses Left"
        }
        
    }
    
    func getData()  {
        
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
                do{
                    self.stat = try JSONDecoder().decode([FoodStatus].self, from: ta!)
                    for log in self.stat{
                        if log.Status == "Success"
                        {
                            DispatchQueue.main.async{
                             
                                _ = self.showProgress(show: false)
                                
                                self.view.makeToast(message: "Added Water")
                                let d = DBHandler.instance.getAllWaterCount()
                                _ =  DBHandler.instance.addWaterIntake(wid: d+2, wtime: self.getCurrentTime(), wdate: self.TodayDate(), wwater: 1)
                                self.updateWater()
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
    
    func Sub_Water()  {
        
        let url="\(GlobalURL)/SaveWater?MemberNo=\(memberNo)&Date_Time=\(self.getCurrentDateTime())&BranchNo=1&Water=-1"
        
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
                do{
                    self.stat = try JSONDecoder().decode([FoodStatus].self, from: ta!)
                    for log in self.stat{
                        if log.Status == "Success"
                        {
                            DispatchQueue.main.async{
                                
                                _ = self.showProgress(show: false)
                                
                                self.view.makeToast(message: "Deleted Water")
                                let d = DBHandler.instance.getAllWaterCount()
                                _ =  DBHandler.instance.delWaterIntake(wid: d+2, wtime: self.getCurrentTime(), wdate: self.TodayDate(), wwater: -1)
                                self.updateWater()
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
                        self.showAlert(title: "Alert", msg: "Failed...Please try again")
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
    
    public func getCurrentTime() -> String
        
    {
        
        
        let yesterday = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let todaysDate = dateFormatter.string(from: yesterday!)
        
        return todaysDate
        
    }
    public func getCurrentDateTime() -> String
        
    {
        
        
        let yesterday = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let todaysDate = dateFormatter.string(from: yesterday!)
        
        return todaysDate
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updatePercent(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed || gesture.state == .ended {
            let location = gesture.location(in: self.wave)
            let percent = 100 - Int(100.0 * location.y / self.wave.bounds.height);
            self.wave.completionInPercent = percent
        }
    }
    
    func  updateWawe(percent  : Int64)
    {
        self.wave.completionInPercent = Int(percent)
    }
    @objc func updateAnimation() {
        self.isAnimating = !self.isAnimating
    }
}

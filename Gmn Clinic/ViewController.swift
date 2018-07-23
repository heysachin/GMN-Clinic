//
//  ViewController.swift
//  Gmn Clinic
//
//  Created by apple on 19/01/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//



/*[{\"Day\":\"No\",\"Subject\":\"No\",\"DailyDietEmailReminder\":\"No\",\"SendEmail\":\"No\",\"Email1\":\"No\",\"SendSMS\":\"No\",\"DietTime\":\"No\",\"DietTime1\":\"No\",\"Diet\":\"No\",\"DsNo\":\"No\",\"MemberNo\":\"No\",\"FromDate\":\"No\",\"ToDate\":\"No\",\"Days\":\"No\",\"branchNo\":\"No\",\"MemberName\":\"No\",\"MobileNo\":\"No\",\"DailyDietRemeinder\":\"No\",\"Footer\":\"No\",\"SMSMessageMember\":\"No\",\"SMSPriorityMember\":\"No\",\"BranchName\":\"No\"}]*/
import UIKit
struct  DietStruct : Decodable  {
    let DsNo : String?
    let DietTime : String
    let Diet : String
    
}

class ViewController: UIViewController {
    var alertController: UIAlertController!
    var spinnerIndicator: UIActivityIndicatorView!
    var data:[LoginEntity]?
    var isLogged:Bool? = false
    var dietStruct = [DietStruct]()
   
    var memberNo : String = ""
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
    
    
    let branchNo="1";
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    
    
    
    
    
    
    @IBOutlet weak var mobile1: UITextField!
    @IBOutlet weak var mobile2: UITextField!
    @IBOutlet weak var email1: UITextField!
    @IBOutlet weak var email2: UITextField!
    @IBOutlet weak var address: UITextField!
    
    
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var stack2: UIStackView!
    @IBOutlet weak var stack3: UIStackView!
    
    @IBOutlet weak var ProfileView: UIView!
    @IBOutlet weak var ShoppingView: UIView!
    @IBOutlet weak var ShoppingCardView: UIView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            ShoppingView.isHidden = false
            ProfileView.isHidden = true
            stack1.isHidden = true
            stack2.isHidden = true
            stack3.isHidden = true
        case 1:
            ShoppingView.isHidden = true
            ProfileView.isHidden = true
            stack1.isHidden = false
            stack2.isHidden = false
            stack3.isHidden = false
        case 2:
            ShoppingView.isHidden = true
            ProfileView.isHidden = false
            stack1.isHidden = true
            stack2.isHidden = true
            stack3.isHidden = true
        default:
            break;
        }
    }
    
    
    
    
    @IBOutlet weak var main_menu_view: UIView!
    
    @IBOutlet weak var textMyName: UILabel!
    
    @IBAction func onClickFoodReminder(_ sender: Any) {
        performSegue(withIdentifier: "toReminder", sender: self)
    }
    @IBAction func onClickActivity(_ sender: Any) {
        
        performSegue(withIdentifier: "toActivity", sender: self)
    }
    @IBAction func onClickFoodIntake(_ sender: Any) {
        performSegue(withIdentifier: "toFoodMenu", sender: self)
        
    }
    @IBAction func onSocialMediaClick(_ sender: Any) {
      
        
         performSegue(withIdentifier: "toSocial", sender: self)
    }
    @IBAction func onSyncClick(_ sender: Any) {
        
       _ = showProgress(show: true)
        getData()
        
        
    }
    @IBAction func onAboveClick(_ sender: Any) {
        
        print("On Above Clicked")
        
    }
    @IBAction func onYoutubeClick(_ sender: Any) {
        
      
        let appURL = NSURL(string: "youtube://www.youtube.com/channel/UCiZWHkgYVrSA0_foEePXuig")!
        let webURL = NSURL(string: "https://www.youtube.com/channel/UCiZWHkgYVrSA0_foEePXuig")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    @IBAction func onClickVideoChat(_ sender: Any) {
        
       
        let urlWhats = "whatsapp://send?phone=+919860632728&abid=12354&text=Hi.....lets make video chat"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.openURL(whatsappURL)
                } else {
                    print("Install Whatsapp")
                }
            }
        }
        
    }
    
    @IBAction func onClickWaterIntake(_ sender: Any) {
        
        performSegue(withIdentifier: "toWater", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("cart Value")
        data=CoreDataHandler.featchObject()
        
        
        
        
        //MARK: Navigation Bar Design
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.default
        nav?.barTintColor = uicolorFromHex(rgbValue: 0x4ABFD4)
        nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        for i in data! {
            print(i)
            self.title = "Gmn Clinic"
            isLogged = i.isloggedin
            textMyName.text = i.empname
            memberNo=i.empno!
        }
        var data2:[MemberEntity]?
        data2=CoreDataHandler.featchMemberObject()
        for i in data2! {
            if i.mobile1 == "" {
                mobile1.text = "Mobile 1 - Not Specified"
            }else{
                mobile1.text = i.mobile1
            }
            if i.mobile2 == "" {
                mobile2.text = "Mobile 2 - Not Specified"
            }else{
                mobile2.text = i.mobile2
            }

            if i.email1 == "" {
                email1.text = "Email 1 - Not Specified"
            }else{
                email1.text = i.email1
            }
            if i.email2 == "" {
                email2.text = "Email 2 - Not Specified"
            }else{
                email2.text = i.email2
            }
            if i.address == "" {
                address.text = "Address - Not Specified"
            }else{
                address.text = i.address
            }
            
        }
        
       // DBHandler.instance.addDiet(did: 1, dtime: "12:22", dfood: "Eating the 100 gm Poha", ddate: "17/02/2018")
        
        
        let floaty = Floaty()
        floaty.addItem("My Profile", icon: UIImage(named: "settings")!, handler: { item in
           
             self.performSegue(withIdentifier: "toProfile", sender: self)
        })
        floaty.addItem("About", icon: UIImage(named: "earth-globe (1)")!, handler: { item in
            
            
        })
        floaty.addItem("Help", icon: UIImage(named: "question")!, handler: { item in
            
            
        })
        floaty.addItem("Share", icon: UIImage(named: "network")!, handler: { item in
            self.share(sender: self.view)
            
        })
        floaty.addItem("Change Password", icon: UIImage(named: "key (1)")!, handler: { item in
            
            self.performSegue(withIdentifier: "toChange", sender: self)
        })
        
        
        self.view.addSubview(floaty)
        
        //MARK: ProgressDialog
        alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
        
        
        //MARK: To Employee Panel if
        if isLogged == true {
           
        }else{
           performSegue(withIdentifier: "toRegister", sender: self)
        }
        
        
        
    }
    
    func share(sender:UIView){
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let textToShare = "Check out Gmn Clinic App"
        
        if let myWebsite = URL(string: "http://itunes.apple.com/app/") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            //
            
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }    }
    
    public func TodayDate() -> String
        
    {
        
        
        let yesterday = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let todaysDate = dateFormatter.string(from: yesterday!)
        
        return todaysDate
        
    }
    func getData()  {
        
        
        let url="\(GlobalURL)/GetFoodReminder?MemberNo=\(memberNo)&branchno=1"
        
        print(url)
        
        HttpClientApi.instance().makeAPICall(url: url,  method: .GET, success: { (data, response, error) in
            
            
            if let data = data, let stringResponse = String(data: data, encoding: .utf8) {
                let c = stringResponse.characters
                let r = c.index(c.startIndex, offsetBy: stringResponse.index(of: ":")!+2)..<c.index(c.endIndex, offsetBy: -2)
                let substring = stringResponse[r]
                let data  = substring.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
                let ta = data.data(using: .utf8)
                print(substring)
              
                do{
                    self.dietStruct = try JSONDecoder().decode([DietStruct].self, from: ta!)
                    var i: Int64 = 1
                    for log in self.dietStruct{
                        if log.DietTime != "No"
                        {
                            _ = DBHandler.instance.addDiet(did: Int64(log.DsNo!)!, dtime: log.DietTime, dfood: log.Diet, ddate: self.TodayDate())
                        
                        i=i+1
                        }else{
                            DispatchQueue.main.async{
                                if self.showProgress(show: false)
                                {
                                    
                                    //   self.showAlert(title: "Success", msg: "Sync Successfully Completed")
                                    
                                }
                                self.view.makeToast(message: "no Data Found", duration: 3.0, position: HRToastPositionCenter as AnyObject)
                            }
                            
                        }
                    }
                    /*    self.category = DBHandler.instance.getCategoery();
                     
                     for cats in self.category
                     {
                     print("Categorys  \(cats.name)")
                     }
                     */
                    
                    
                    DispatchQueue.main.async{
                        if self.showProgress(show: false)
                        {
                            
                            //   self.showAlert(title: "Success", msg: "Sync Successfully Completed")
                            
                        }
                        self.view.makeToast(message: "Sync Successful", duration: 3.0, position: HRToastPositionCenter as AnyObject)
                    }
                }catch{
                    DispatchQueue.main.async{
                    _ = self.showProgress(show: false)
                    print("exception \(error)")
                    self.showAlert(title: "Failed", msg: "Something went wrong")
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
    
}



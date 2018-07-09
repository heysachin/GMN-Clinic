//
//  LoginViewController.swift
//  Gmn Clinic
//
//  Created by apple on 05/02/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit
/*
[{\"MemberNo\":\"12\",\"MemberName\":\"Aarushi.P.Vera \",\"MobileNo1\":\"9819877995\",\"MobileNo2\":\"\",\"Email1\":\"\",\"Email2\":\"\",\"Address\":\"New Mumbai\",\"Active\":\"No\"}]*/

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


struct Login : Decodable {
    let MemberNo : String
    let MobileNo1 : String
    let MemberName : String
    let MobileNo2 : String
    let Email1 : String
    let Email2 : String
    let Address : String
    let Active  :String
    
}
class LoginViewController: UIViewController {
    var alertController: UIAlertController!
    var spinnerIndicator: UIActivityIndicatorView!
    var login = [Login]()
    var forget = [MemberRegister]()
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
    @IBOutlet weak var memberId: UITextField!
    
    @IBAction func forgetClicked(_ sender: Any) {
        let userid=memberId.text
        if memberId.text != "" {
            
            //     _ =   CoreDataHandler.SaveObject(userName: "Amol Nage", password: "12312", empname: "amol", empno: "565", dieti: "4565", isLogged: true)
            
            
            
            if showProgress(show: true){
                
            }
            
            
            let ur : String?="\(GlobalURL)/ForgotPassword?UserId=\(userid!)&BranchNo=1"
            
            let replaced = ur?.replacingOccurrences(of: " ", with: "%20")
            
            print("Final URL:  \(String(describing: replaced!))")
            HttpClientApi.instance().makeAPICall(url: replaced!,  method: .GET, success: { (data, response, error) in
                
                
                if let data = data, let stringResponse = String(data: data, encoding: .utf8) {
                    
                    // received from a network request, for example
                    let c = stringResponse.characters
                    let r = c.index(c.startIndex, offsetBy: stringResponse.index(of: ":")!+2)..<c.index(c.endIndex, offsetBy: -2)
                    let substring = stringResponse[r]
                    let data  = substring.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
                    let ta = data.data(using: .utf8)
                    print("Parsed json :  \(data)")
                    do{
                        self.forget = try JSONDecoder().decode([MemberRegister].self, from: ta!)
                        for log in self.forget{
                            // _=String(log.MemberName)
                            
                            if log.Status != "Fail"
                            {
                                DispatchQueue.main.async {
                                    
                                    if  self.showProgress(show: false) {
                                        
                                        self.showAlert(title: "Successfull", msg: "Password is sent on registered mobile number")
                                        
                                    }
                                    
                                }
                            }else{
                                //Alret Wron UserId or Password
                                DispatchQueue.main.async {
                                    if  self.showProgress(show: false){
                                        self.showAlert(title: "Alert", msg: "Failed To Request")
                                    }
                                }
                            }
                            
                            
                        }
                        
                    }catch{
                        print("exception \(error)")
                        self.showAlert(title: "Failed", msg: "Somethig Went Wrng")
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
            
            
            
            
            
            
        }else{
            
            view.makeToast(message: "Please Enter Member No")
        }
    }
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var forgetPassword: UIButton!
    @IBAction func buttonLogin(_ sender: Any) {
        
       let userId=memberId.text
        let pass=password.text
        
        if memberId.text != "" && password.text != "" {
   
            
            if showProgress(show: true){
                
            }
            
        
            
            let ur : String?="\(GlobalURL)/LogIn?UserId=\(userId!)&Password=\(String(describing: pass!))&BranchNo=1"
            
            let replaced = ur?.replacingOccurrences(of: " ", with: "%20")
            
            print("Final URL:  \(String(describing: replaced!))")
            HttpClientApi.instance().makeAPICall(url: replaced!,  method: .GET, success: { (data, response, error) in
                
                
                if let data = data, let stringResponse = String(data: data, encoding: .utf8) {
                    
                    // received from a network request, for example
                    let c = stringResponse.characters
                    let r = c.index(c.startIndex, offsetBy: stringResponse.index(of: ":")!+2)..<c.index(c.endIndex, offsetBy: -2)
                    let substring = stringResponse[r]
                    let data  = substring.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
                    let ta = data.data(using: .utf8)
                    print("Parsed json :  \(data)")
                    do{
                        self.login = try JSONDecoder().decode([Login].self, from: ta!)
                        for log in self.login{
                            // _=String(log.MemberName)
                            
                            if log.MemberName != "No"
                            {
                                DispatchQueue.main.async {
                                    
                                    if  self.showProgress(show: false) {
                                        _ =   CoreDataHandler.SaveObject(userName: log.MemberName, password: pass!, empname: log.MemberName, empno: log.MemberNo, dieti: log.MemberNo, isLogged: true)
                                        _ = CoreDataHandler.SaveMemberObject(number: log.MemberNo, name: log.MemberName, mob1: log.MobileNo1, mob2: log.MobileNo2, email1: log.Email1, email2: log.Email2, address: log.Address, active: log.Active)
                                        if  self.showProgress(show: false){
                                        self.performSegue(withIdentifier: "toHome", sender: self)
                                        }
                                    }
                                    
                                }
                            }else{
                                //Alret Wron UserId or Password
                                DispatchQueue.main.async {
                                    if  self.showProgress(show: false){
                                        self.showAlert(title: "Alert", msg: "Incorrect Credintial")
                                    }
                                }
                            }
                            
                            
                        }
                        
                    }catch{
                        print("exception \(error)")
                        self.showAlert(title: "Failed", msg: "Something went wrong")
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
            
            
            
            
        }else{
            
            view.makeToast(message: "Please Enter Login Details")
        }
        
    }
    @IBOutlet weak var buttonForget: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        // Do any additional setup after loading the view.
    }


}

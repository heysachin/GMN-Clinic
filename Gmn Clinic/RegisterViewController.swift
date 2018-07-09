//
//  RegisterViewController.swift
//  Gmn Clinic
//
//  Created by apple on 06/02/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit
struct MemberRegister : Decodable {
    let MemberName : String
    let Status : String
}
extension String {
    public func index(of char: Character) -> Int? {
        if let idx = characters.index(of: char) {
            return characters.distance(from: startIndex, to: idx)
        }
        return nil
    }
}
func randomString(length: Int) -> String {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    
    var randomString = ""
    
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    
    return randomString
}
class RegisterViewController: UIViewController {
    var alertController: UIAlertController!
    var spinnerIndicator: UIActivityIndicatorView!
      var login = [MemberRegister]()
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
   
    
    @IBAction func buttonRegister(_ sender: Any) {
        
        let memberNo=editMemberno.text
        if editMemberno.text != ""
        {
            
            
            
            if showProgress(show: true){
                
            }
            
          
            let ur : String?="\(GlobalURL)/Registration?MemberNo=\(memberNo!)&Password=\(randomString(length: 6))&BranchNo=1"
            
            let replaced = ur?.replacingOccurrences(of: " ", with: "%20")
            
            print("Final URL:  \(replaced!)")
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
                        self.login = try JSONDecoder().decode([MemberRegister].self, from: ta!)
                        for log in self.login{
                           // _=String(log.MemberName)
                            
                            if log.Status != "Exist"
                            {
                                DispatchQueue.main.async {
                                    
                                    if  self.showProgress(show: false) {
                                         self.showAlert(title: "Successfull", msg: "Password is sent on registered mobile number")
                                        self.performSegue(withIdentifier: "toLogin", sender: self)
                                    }
                                    
                                }
                            }else{
                                //Alret Wron UserId or Password
                                DispatchQueue.main.async {
                                    if  self.showProgress(show: false){
                                        self.showAlert(title: "Alert", msg: "Member Allready Registered")
                                    }
                                }
                            }
                            
                            
                        }
                        
                    }catch{
                        print("exception \(error)")
                        self.showAlert(title: "Failed", msg: "Failed to Register")
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
            
            
            view.makeToast(message: "Enter Member Number")
        }
    }
    @IBOutlet weak var editMemberno: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        // Do any additional setup after loading the view.
        
        self.hideKeyboardWhenTappedAround()
        alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

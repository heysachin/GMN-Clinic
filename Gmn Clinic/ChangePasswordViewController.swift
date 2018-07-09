//
//  ChangePasswordViewController.swift
//  Gmn Clinic
//
//  Created by apple on 16/02/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    var OldPass : String = ""
    var NewPass : String = ""
     var stat = [FoodStatus]()
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
    
    @IBAction func onSubmit(_ sender: Any) {
        if oldPass.text != "" && newPass.text != "" && confirmPass.text != "" {
            
            if newPass.text == confirmPass.text
            {
                
                OldPass = oldPass.text!
                NewPass = newPass.text!
                getData()
                
                
            }else{
                
                view.makeToast(message: "Password did not match")
            }
            
            
        }else{
            
            view.makeToast(message: "Enter All Feilds")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var confirmPass: UITextField!
    
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var oldPass: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func getData()  {
        
        
        
        let url="\(GlobalURL)/ChangePassword?MemberNo=\(self.memberNo)&OldPassword=\(OldPass)&BranchNo=1&NewPassword=\(self.NewPass)"
        
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
                                self.performSegue(withIdentifier: "toHomeFromChange", sender: self)
                                self.view.makeToast(message: "Password Change Success")
                                
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

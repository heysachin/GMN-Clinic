//
//  DietTableViewController.swift
//  Gmn Clinic
//
//  Created by apple on 17/02/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit

class DietTableViewController: UITableViewController {

    var alertController: UIAlertController!
    var spinnerIndicator: UIActivityIndicatorView!
    var diet : [Diet] = []
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         diet = DBHandler.instance.getDiet()

       
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
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return diet.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fav_cell", for: indexPath) as! DietTableViewCell
        let entry = diet[indexPath.row]
        cell.time.text =  entry.dietTime
        cell.diet.text = entry.dietFood
     
        return cell
    }

}

//
//  MyFoodTableViewController.swift
//  Gmn Clinic
//
//  Created by apple on 09/03/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit

class MyFoodTableViewController: UITableViewController {

    var alertController: UIAlertController!
    var spinnerIndicator: UIActivityIndicatorView!
    var diet : [FoodIntake] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)

        diet = DBHandler.instance.getFoodIntake(date : TodayDate())
        self.tableView.reloadData()
        
    }
    public func TodayDate() -> String
    {
        
        
        let yesterday = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let todaysDate = dateFormatter.string(from: yesterday!)
        
        return todaysDate
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "myfoodcell", for: indexPath) as! MyFoodTableViewCell
        let entry = diet[indexPath.row]
        cell.time.text =  entry.time
        cell.food.text = entry.food
        
        return cell
    }


}

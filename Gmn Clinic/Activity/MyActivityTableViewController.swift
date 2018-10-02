//
//  MyActivityTableViewController.swift
//  Gmn Clinic
//
//  Created by apple on 09/03/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit
import DatePickerDialog

class MyActivityTableViewController: UITableViewController {
    var diet : [Activity] = []
    
    @IBAction func submitFoodHistory(_ sender: Any) {
        var from=""
        var to=""
        var option=""
        if textField.text != ""{
            from=String(textField.text!)
        }else{
            showAlert(title: "No Date Selected", msg: "Please Select From Date")
        }
        
        if toTextField.text != ""{
            to=String(toTextField.text!)
        }else{
            showAlert(title: "No Date Selected", msg: "Please Select To Date")
        }
        
        if optionSelected.text != ""{
            option=String(optionSelected.text!)
        }else{
            showAlert(title: "No Option Selected", msg: "Please Select Time")
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if (from != "" && to != "" && option != ""){
            var dates = generateDates(between: dateFormatter.date(from: from), and: dateFormatter.date(from: to), byAdding: Calendar.Component.day)
            for date in dates{
                print(dateFormatter.string(from: date))
                diet+=DBHandler.instance.getActivity(date : dateFormatter.string(from: date))
                print(diet)
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    func generateDates(between startDate: Date?, and endDate: Date?, byAdding: Calendar.Component) -> [Date] {
        
        var dates = [Date]()
        guard var date = startDate, let endDate = endDate else {
            return []
        }
        while date < endDate {
            date = Calendar.current.date(byAdding: byAdding, value: 1, to: date)!
            dates.append(date)
        }
        return dates
    }
    
    @IBOutlet weak var optionSelected: UITextField!
    @IBAction func downloadSheet(_ sender: Any)
    {
        
        
        
        let alert = UIAlertController(title: "Select Option",message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "All", style: .default , handler:{ (UIAlertAction)in
            self.optionSelected.text="All"
        }))
        
        alert.addAction(UIAlertAction(title: "Morning", style: .default , handler:{ (UIAlertAction)in
            self.optionSelected.text="Morning"
        }))
        
        alert.addAction(UIAlertAction(title: "Noon", style: .default , handler:{ (UIAlertAction)in
            self.optionSelected.text="Noon"
        }))
        alert.addAction(UIAlertAction(title: "Evening", style: .default , handler:{ (UIAlertAction)in
            self.optionSelected.text="Evening"
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    @IBAction func fromDate(_ sender: Any) {
        fromDateDialog()
    }
    
    @IBAction func toDate(_ sender: Any) {
        toDateDialog()
    }
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var viewOnTop: UIView!
    
    
    
    var alertController: UIAlertController!
    var spinnerIndicator: UIActivityIndicatorView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
        
        diet = DBHandler.instance.getActivity(date : TodayDate())
        self.tableView.reloadData()
        
    }
    
    public func toDateDialog() {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                self.toTextField.text = formatter.string(from: dt)
            }
        }
    }
    
    public func fromDateDialog() {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                self.textField.text = formatter.string(from: dt)
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "myactivitycell", for: indexPath) as! MyActivityTableViewCell
        let entry = diet[indexPath.row]
        cell.time.text =  entry.Time
        cell.activity.text = entry.Activity
        
        //cell.activity.layer.borderColor = UIColor.cyan.cgColor
        //cell.activity.layer.borderWidth = 3.0;
        
        return cell
    }

}

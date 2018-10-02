//
//  FoodInMenuViewController.swift
//  Gmn Clinic
//
//  Created by apple on 13/02/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit

class FoodInMenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    var diet: [FoodIntake] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return diet.count+1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row==0{
            return 15
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myfoodcell", for: indexPath) as! MyFoodTableViewCell
        if indexPath.row==0{
            cell.food.text = "Food Name"
            cell.calorie.text="Cal"
            cell.carbs.text="Carbs"
            cell.fat.text="Fat"
            cell.protein.text="Prot"
            cell.calorie.layer.borderColor=UIColor.init(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1).cgColor
            cell.carbs.layer.borderColor=UIColor.init(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1).cgColor
            cell.fat.layer.borderColor=UIColor.init(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1).cgColor
            cell.protein.layer.borderColor=UIColor.init(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1).cgColor
            cell.food.layer.borderColor=UIColor.init(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1).cgColor
        }else{
            let entry = diet[indexPath.row-1]
            cell.food.text = entry.food
            cell.calorie.text="0"
            cell.carbs.text="0"
            cell.fat.text="0"
            cell.protein.text="0"
            cell.calorie.layer.borderColor=UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
            cell.carbs.layer.borderColor=UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
            cell.food.layer.borderColor=UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
            cell.fat.layer.borderColor=UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
            cell.protein.layer.borderColor=UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        }
        cell.food.layer.borderWidth=1
        cell.food.layer.borderWidth=1
        cell.calorie.layer.borderWidth=1
        cell.carbs.layer.borderWidth=0.8
        cell.fat.layer.borderWidth=1
        cell.protein.layer.borderWidth=1
        
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dateLable: UILabel!
    var yesDate:Int64 = 0
    @IBOutlet weak var dateView: UIView!
    
    @IBAction func prevClick(_ sender: Any) {
        
        
        yesDate = yesDate - 1
        
        if yesDate == 0
        {
            _ = yesterdaysDate()
            dateLable.text = "Today"
            
        }else if yesDate == -1
        {
            _ = yesterdaysDate()
            dateLable.text = "Yesterday"
            
        }else{
            let dt = yesterdaysDate()
            dateLable.text = dt
        }
    }
    @IBAction func nextClick(_ sender: Any) {
      if yesDate<0
      {
        yesDate = yesDate + 1
        if yesDate == 0
        {
            _ = yesterdaysDate()
            dateLable.text = "Today"
            
        }else if yesDate == -1
        {
            _ = yesterdaysDate()
            dateLable.text = "Yesterday"
            
        }else{
            let dt = yesterdaysDate()
            dateLable.text = dt
        }
        
        }
    }
    
    @IBOutlet weak var breakfast: UIButton!
    @IBOutlet weak var lunch: UIButton!
    @IBOutlet weak var dinner: UIButton!
    @IBOutlet weak var morningSnack: UIButton!
    @IBOutlet weak var afternoonSnack: UIButton!
    @IBOutlet weak var eveningSnack: UIButton!
    
    var pref : String = ""
    var date : String = ""
    
    @IBAction func onBreakfastClick(_ sender: Any) {
        pref = "Breakfast"
        date = yesterdaysDateFor()
            
        performSegue(withIdentifier: "toAddFood", sender: self)
    }
    @IBAction func onLunchClick(_ sender: Any) {
        pref = ""
        date = yesterdaysDateFor()
        performSegue(withIdentifier: "toAddFood", sender: self)
    }
    @IBAction func onDinnerClick(_ sender: Any) {
        performSegue(withIdentifier: "toAddFood", sender: self)
    }
    
    @IBAction func onMorningSnackClick(_ sender: Any) {
        pref = ""
        date = yesterdaysDateFor()
        performSegue(withIdentifier: "toAddFood", sender: self)
    }
    @IBAction func onAfternoonSnackClick(_ sender: Any) {
        pref = ""
        date = yesterdaysDateFor()
        performSegue(withIdentifier: "toAddFood", sender: self)
    }
    @IBAction func onEveningSnackClick(_ sender: Any) {
        pref = ""
        date = yesterdaysDateFor()
        performSegue(withIdentifier: "toAddFood", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        diet = DBHandler.instance.getFoodIntake(date : TodayDate())
        self.tableView.reloadData()
        self.title="Intake"
        topViewHeight.constant=CGFloat(min(5,diet.count))*50

        
        dateView.layer.cornerRadius = 8
        dateView.layer.borderWidth = 1
        breakfast.layer.shadowColor = UIColor.black.cgColor
        breakfast.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        breakfast.layer.masksToBounds = false
        breakfast.layer.shadowRadius = 1.0
        breakfast.layer.shadowOpacity = 0.5
        breakfast.layer.cornerRadius = breakfast.frame.width / 2
        
       
        lunch.layer.shadowColor = UIColor.black.cgColor
        lunch.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        lunch.layer.masksToBounds = false
        lunch.layer.shadowRadius = 1.0
        lunch.layer.shadowOpacity = 0.5
        lunch.layer.cornerRadius = lunch.frame.width / 2
        
       
        dinner.layer.shadowColor = UIColor.black.cgColor
        dinner.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        dinner.layer.masksToBounds = false
        dinner.layer.shadowRadius = 1.0
        dinner.layer.shadowOpacity = 0.5
        dinner.layer.cornerRadius = dinner.frame.width / 2
        
        morningSnack.layer.shadowColor = UIColor.black.cgColor
        morningSnack.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        morningSnack.layer.masksToBounds = false
        morningSnack.layer.shadowRadius = 1.0
        morningSnack.layer.shadowOpacity = 0.5
        morningSnack.layer.cornerRadius = morningSnack.frame.width / 2
        
    
        eveningSnack.layer.shadowColor = UIColor.black.cgColor
        eveningSnack.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        eveningSnack.layer.masksToBounds = false
        eveningSnack.layer.shadowRadius = 1.0
        eveningSnack.layer.shadowOpacity = 0.5
        eveningSnack.layer.cornerRadius = eveningSnack.frame.width / 2
        
        afternoonSnack.layer.shadowColor = UIColor.black.cgColor
        afternoonSnack.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        afternoonSnack.layer.masksToBounds = false
        afternoonSnack.layer.shadowRadius = 1.0
        afternoonSnack.layer.shadowOpacity = 0.5
        afternoonSnack.layer.cornerRadius = afternoonSnack.frame.width / 2
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is FoodIntakeViewController
        {
            let vc = segue.destination as? FoodIntakeViewController
            
            vc?.pref = self.pref
            vc?.date = self.date
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
    public func yesterdaysDate() -> String

    {
    
        
        
        let yesterday = Calendar.current.date(byAdding: .day, value: Int(yesDate), to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        var todaysDate = dateFormatter.string(from: yesterday!)
        diet = DBHandler.instance.getFoodIntake(date : todaysDate)
        self.tableView.reloadData()
    
        dateFormatter.dateFormat = "dd MMM"
        todaysDate = dateFormatter.string(from: yesterday!)
    
        return todaysDate
        
    }
    public func yesterdaysDateFor() -> String
        
    {
        
        
        let yesterday = Calendar.current.date(byAdding: .day, value: Int(yesDate), to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let todaysDate = dateFormatter.string(from: yesterday!)
        return todaysDate
        
    }

}

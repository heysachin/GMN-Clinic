//
//  FoodInMenuViewController.swift
//  Gmn Clinic
//
//  Created by apple on 13/02/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit

class FoodInMenuViewController: UIViewController {
    
    @IBOutlet weak var dateLable: UILabel!
    var yesDate:Int64 = 0
    @IBOutlet weak var dateView: UIView!
    
    @IBAction func prevClick(_ sender: Any) {
        
        
        yesDate = yesDate - 1
        
        if yesDate == 0
        {
            dateLable.text = "Today"
            
        }else if yesDate == -1
        {
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
            dateLable.text = "Today"
            
        }else if yesDate == -1
        {
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
   
    public func yesterdaysDate() -> String

    {
    
        
        let yesterday = Calendar.current.date(byAdding: .day, value: Int(yesDate), to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        let todaysDate = dateFormatter.string(from: yesterday!)
    
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

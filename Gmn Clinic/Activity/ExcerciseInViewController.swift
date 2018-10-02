//
//  ExcerciseInViewController.swift
//  Gmn Clinic
//
//  Created by Sachin Dev on 08/08/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//


import UIKit

class ExcerciseInMenuViewController: UIViewController {
    
    @IBOutlet weak var dateLable: UILabel!
    var yesDate:Int64 = 0
    @IBOutlet weak var dateView: UIView!
    var date : String = ""
    
    @IBAction func morning(_ sender: Any) {
        date = yesterdaysDateFor()
        performSegue(withIdentifier: "excerActivity", sender: self)
    }
    
    
    @IBAction func noon(_ sender: Any) {
        date = yesterdaysDateFor()
        performSegue(withIdentifier: "excerActivity", sender: self)
    }
    @IBAction func evening(_ sender: Any) {
        date = yesterdaysDateFor()
        performSegue(withIdentifier: "excerActivity", sender: self)
    }
    
    
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="Excercise"
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ActivityViewController
        {
            let vc = segue.destination as? ActivityViewController
            vc?.date = date
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


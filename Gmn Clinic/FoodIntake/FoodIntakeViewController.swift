//
//  FoodIntakeViewController.swift
//  Gmn Clinic
//
//  Created by apple on 13/02/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit
struct FoodStatus : Decodable {
    
    let Status : String
    let MemberName :String
}
class FoodIntakeViewController: UIViewController {

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
    
    var data : String = ""
    var flag1: Bool = false;
    var flag2: Bool = false;
    var flag3: Bool = false;
    var flag4: Bool = false;
    var flag5: Bool = false;
    var flag6: Bool = false;
    
    
    @IBOutlet weak var food1: SearchTextField!
    
    @IBOutlet weak var food2: SearchTextField!
    
    @IBOutlet weak var food3: SearchTextField!
    
    @IBOutlet weak var food4: SearchTextField!
    
    @IBOutlet weak var food5: SearchTextField!
    
    @IBOutlet weak var food6: SearchTextField!
    
    @IBOutlet weak var serving1: SearchTextField!
    
    @IBOutlet weak var serving2: SearchTextField!
    
    @IBOutlet weak var serving3: SearchTextField!
    
    @IBOutlet weak var serving4: SearchTextField!
    
    @IBOutlet weak var serving5: SearchTextField!
    @IBOutlet weak var serving6: SearchTextField!
    var foodData: [String] = [String]()
    var servingData : [String] = [String]()
    var stat = [FoodStatus]()
    public var date : String = ""
    public var pref : String = ""
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
        
        
      

        let button = UIButton.init(type: .custom)
        button.setTitle("History", for: UIControlState.normal)
        button.addTarget(self, action:#selector(FoodIntakeViewController
            .callBackMethod), for:.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30) //CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        food1.layer.borderWidth = 0.4
        food1.layer.cornerRadius = 0
        food1.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor

        food2.layer.borderWidth = 0.4
        food2.layer.cornerRadius = 0
        food2.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor

         food3.layer.borderWidth = 0.4
        food3.layer.cornerRadius = 0
        food3.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor

 food4.layer.borderWidth = 0.4
        food4.layer.cornerRadius = 0
        food4.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor

        food5.layer.borderWidth = 0.4
        food5.layer.cornerRadius = 0
        food5.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor

 food6.layer.borderWidth = 0.4
        food6.layer.cornerRadius = 0
        food6.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        

        serving1.layer.borderWidth = 0.4
        serving1.layer.cornerRadius = 0
        serving1.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
 serving2.layer.borderWidth = 0.4
        serving2.layer.cornerRadius = 0
        serving2.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
 serving3.layer.borderWidth = 0.4
        serving3.layer.cornerRadius = 0
        serving3.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
 serving4.layer.borderWidth = 0.4
        serving4.layer.cornerRadius = 0
        serving4.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
 serving5.layer.borderWidth = 0.4
        serving5.layer.cornerRadius = 0
        serving5.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
 serving6.layer.borderWidth = 0.4
        serving6.layer.cornerRadius = 0
        serving6.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor

        foodData.append("Green tea")
        foodData.append("Kava")
        foodData.append("Lemon Water")
        foodData.append("Black coffee")
        foodData.append("Coffee")
        foodData.append("Slim Milk")
        foodData.append("Slim Curd")
        foodData.append("Soya Milk")
        foodData.append("Almond Milk")
        foodData.append("Milk Shakes")
        foodData.append("Curd")
        foodData.append("Lassi")
        foodData.append("Butter Milk")
        foodData.append("Besan Veg Chilla")
        foodData.append("Egg Whites")
        foodData.append("Egg whites Omelette")
        foodData.append("Wheat Flakes")
        foodData.append("Muesli")
        foodData.append("Oats")
        foodData.append("Isabgol")
        foodData.append("Mix Seeds")
        foodData.append("Chia Seeds")
        foodData.append("Herb Powder")
        foodData.append("Meethi Seeds")
        foodData.append("Flax seeds")
        foodData.append("Juices")
        foodData.append("Yogurt")
        foodData.append("Daliya")
        foodData.append("Vermicilli Veg Upma")
        foodData.append("Veg Poha")
        foodData.append("Dry Thepla")
        foodData.append("Dry Thalipeeth")
        foodData.append("Idli")
        foodData.append("Dosa")
        foodData.append("Veg Utapa")
        foodData.append("Sambhar")
        foodData.append("Fruits")
        foodData.append("Khakra")
        foodData.append("Veg Paratha")
        foodData.append("Paneer Paratha")
        foodData.append("Bhakri")
        foodData.append("Veg Omelette")
        foodData.append("veg Pan cakes")
        foodData.append("Waffles")
        foodData.append("Almonds")
        foodData.append("Walnuts")
        foodData.append("Pista")
        foodData.append("Fruit")
        foodData.append("Salad")
        foodData.append("Soup")
        foodData.append("Roti")
        foodData.append("Rice")
        foodData.append("Dal")
        foodData.append("Pulses")
        foodData.append("Sprouts")
        foodData.append("Vegetable")
        foodData.append("Barley")
        foodData.append("Chicken")
        foodData.append("Tofu")
        foodData.append("Wheat Pasta")
        foodData.append("Brown Rice")
        foodData.append("Mix Dal Dosa")
        foodData.append("Quinno Dal veg Khichadi")
        foodData.append("Daliya Dal Khichadi")
        foodData.append("Veg Raita")
        foodData.append("Low Fat Paneer")
        foodData.append("Egg Whites")
        foodData.append("Fish")
        foodData.append("Quinnoa")
        foodData.append("Wheat Bran")
        foodData.append("Stir fry vegetables")
        foodData.append("Kadhi")
        foodData.append("Thepla")
        foodData.append("Chutney")
        foodData.append("Chana")
        foodData.append("Roasted Moong")
        foodData.append("Hung Curd Dip")
        foodData.append("Corn Salad")
        foodData.append("Lentil Chaat")
        foodData.append("Kurmura")
        foodData.append("Roasted Chiwda")
        foodData.append("Lowar Bajra Puff")
        foodData.append("Veg Bhel")
        foodData.append("Jowar Dhani")
        foodData.append("Granola Bar")
        foodData.append("Paneer Sandwich")
        foodData.append("Veg Sandwich")
        foodData.append("Khandvi")
        foodData.append("Patra")
        foodData.append("Plain Dry Khakra")
        foodData.append("Sprouts")
        foodData.append("Soya Bean")
        foodData.append("Roasted Oats")
        foodData.append("Makhana")
        foodData.append("Jowar pop corn")
        foodData.append("Cole Slaw")
        foodData.append("Paneer Veg Cutlet")
        foodData.append("Besan Tomato Veg Omelette")
        foodData.append("Mushrooms")
        foodData.append("Boiled Chana")
        foodData.append("Horse Grain chaat")
        
        
      
        
        
        
        servingData.append("1/4 TSP")
         servingData.append("1/2 TSP")
         servingData.append("1 TSP")
         servingData.append("1/2 TBSP")
         servingData.append("1 TBSP")


         servingData.append("1/4 Cup");
         servingData.append("1/2 Cup");
         servingData.append("4 Bowl");
         servingData.append("1 Cup");
         servingData.append("2 Cup");
         servingData.append("3 Cup");
         servingData.append("4 Cup");
         servingData.append("1 Piece");
         servingData.append("2 Piece");
         servingData.append("3 Piece");
         servingData.append("4 Piece");
         servingData.append("5 Piece");
         servingData.append("6 Piece");
         servingData.append("7 Piece");
         servingData.append("8 Piece");
         servingData.append("9 Piece");
         servingData.append("10 Piece");
         servingData.append("1 Plate");
         servingData.append("2 Plate");
         servingData.append("3 Plate");
         servingData.append("4 Plate");
         servingData.append("1 Glass");
         servingData.append("2 Glass");
         servingData.append("3 Glass");
         servingData.append("4 Glass");
         servingData.append("100 ML");
         servingData.append("250 ML");
         servingData.append("500 ML");
         servingData.append("1 L");
        
        
        
        
        
        
       
        food1.filterStrings(foodData)
       
        serving1.filterStrings(servingData)
        
        food2.filterStrings(foodData)
        
        serving2.filterStrings(servingData)
        
        
        food3.filterStrings(foodData)
        
        serving3.filterStrings(servingData)
        
       
        food4.filterStrings(foodData)
        
        serving4.filterStrings(servingData)
        
       
        food5.filterStrings(foodData)
        
        serving5.filterStrings(servingData)
        
        
        food6.filterStrings(foodData)
       
        serving6.filterStrings(servingData)
        
        
        
    }

    @IBAction func onSubmit(_ sender: Any) {
        if food1.text != "" && serving1.text != ""
        {
        if food1.text != "" && serving1.text != ""
        {
            flag1=true
            
        }
        
        if food2.text != "" && serving2.text != ""
        {
            flag2=true
            
        }
        
        if food3.text != "" && serving3.text != ""
        {
            flag3=true
        }
        
        if food4.text != "" && serving4.text != ""
        {
            flag4=true
        }
        if food5.text != "" && serving5.text != ""
        {
            
            flag5=true
            
        }
        if food6.text != "" && serving6.text != ""
        {
            flag6=true
        }
            
             save();
            
        }else{
            
            view.makeToast(message: "Please Enter Atleast 1 Diet")
        }
    }
    
    @objc func callBackMethod() {
        
       performSegue(withIdentifier: "toMyFood", sender: self)
        //toMyActivity
        
    }
    public func save()
    {
        if flag1
        {
            data = "\(String(describing: food1.text!)) - \(String(describing: serving1.text!)),\(date)"
        }
        if flag2
        {
            data = "\(data)$\(String(describing: food2.text!)) - \(String(describing: serving2.text!)),\(date)"
        }
        if flag3
        {
            data = "\(data)$\(String(describing: food3.text!)) - \(String(describing: serving3.text!)),\(date)"
        }
        if flag4
        {
            data = "\(data)$\(String(describing: food4.text!)) - \(String(describing: serving4.text!)),\(date)"
        }
        if flag5
        {
            data = "\(data)$\(String(describing: food5.text!)) - \(String(describing: serving5.text!)),\(date)"
        }
        if flag6
        {
            data = "\(data)$\(String(describing: food6.text!)) - \(String(describing: serving6.text!)),\(date)"
        }

       if showProgress(show: true)
        {
        getData()
        }
        }
    
    @IBOutlet weak var onSubmitClick: UIButton!
    
    public func TodayDate() -> String
        
    {
        
        
        let yesterday = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let todaysDate = dateFormatter.string(from: yesterday!)
        
        return todaysDate
        
    }
    
      func getData()  {
        
        
        
        let url="\(GlobalURL)/SaveHistoryUpdate2_6?MemberNo=\(self.memberNo)&Date_Time=\(self.date)&BranchNo=1&FoodName=\(self.data)"
        
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
                             
                         
                                
                                if self.food1.text != "" {
                             _ =   DBHandler.instance.addFoodIntake(fid: 1, ftime: self.TodayDate(), ffood: "\(self.food1.text!) - \(self.serving1.text!)")
                               }

                                if self.food2.text != "" {
                              _ =      DBHandler.instance.addFoodIntake(fid: 2, ftime: self.TodayDate(), ffood: "\(self.food2.text!) - \(self.serving2.text!)")
                                }
                                
                                if self.food3.text != "" {
                                _ =    DBHandler.instance.addFoodIntake(fid: 3, ftime: self.TodayDate(), ffood: "\(self.food3.text!) - \(self.serving3.text!)")
                                }
                                
                                if self.food4.text != "" {
                                  _ =  DBHandler.instance.addFoodIntake(fid: 4, ftime: self.TodayDate(), ffood: "\(self.food4.text!) - \(self.serving4.text!)")
                                }
                                if self.food5.text != "" {
                               _ =     DBHandler.instance.addFoodIntake(fid: 5, ftime: self.TodayDate(), ffood: "\(self.food5.text!) - \(self.serving5.text!)")
                                }
                                
                                if self.food6.text != "" {
                                 _ =   DBHandler.instance.addFoodIntake(fid: 6, ftime: self.TodayDate(), ffood: "\(self.food6.text!) - \(self.serving6.text!)")
                                }
                                   self.food1.text = ""
                                self.food2.text = ""
                                self.food3.text = ""
                                self.food4.text = ""
                                self.food5.text = ""
                                self.food6.text = ""
                                self.serving1.text = ""
                                self.serving2.text = ""
                                self.serving3.text = ""
                                self.serving4.text = ""
                                self.serving5.text = ""
                                self.serving6.text = ""
                                
                                  _ = self.showProgress(show: false)
                                self.performSegue(withIdentifier: "toMyFood", sender: self)
                           self.view.makeToast(message: "Sucess")
                            
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
}


    



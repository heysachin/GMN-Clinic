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
class FoodIntakeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    var yesDate:Int64 = 0
    var diet: [FoodIntake] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if diet.count==0{
            return 0
        }
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
            cell.food.text = "Food"
            cell.amount.text="Time"
            cell.unit.text="Sr. No."
            cell.unit.layer.borderColor=UIColor.init(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1).cgColor
            cell.amount.layer.borderColor=UIColor.init(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1).cgColor
            cell.food.layer.borderColor=UIColor.init(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1).cgColor
        }else{
            let entry = diet[indexPath.row-1]
            cell.food.text = entry.food
            if entry.time==TodayDate(){
                cell.amount.text="Today 09:00"
            }else if entry.time==yesterdaysDate(){
                cell.amount.text="Yesterday 09:00"
            }else {
                cell.amount.text="\(entry.time) 09:00"
            }
            cell.unit.text=String(indexPath.row)
            cell.unit.layer.borderColor=UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
            cell.amount.layer.borderColor=UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
            cell.food.layer.borderColor=UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        }
        cell.food.layer.borderWidth=1
        cell.amount.layer.borderWidth=1
        cell.unit.layer.borderWidth=1
        
        cell.layer.cornerRadius = 5
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.borderWidth=0.4
        
        return cell
    }

    @IBOutlet weak var tableView: UITableView!
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
    
    public func yesterdaysDate() -> String
        
    {
        
        
        let yesterday = Calendar.current.date(byAdding: .day, value: Int(yesDate), to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
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
    
    @IBOutlet weak var unit1: SearchTextField!
    
    @IBOutlet weak var unit2: SearchTextField!
    
    @IBOutlet weak var unit3: SearchTextField!
    
    @IBOutlet weak var unit4: SearchTextField!
    
    @IBOutlet weak var unit5: SearchTextField!
    
    @IBOutlet weak var unit6: SearchTextField!
    
    @IBOutlet weak var TopTable: UIView!
    
    var foodData: [String] = [String]()
    var servingData : [String] = [String]()
    var unitsData : [String] = [String]()
    var cupFood=["Green tea","Kava","Lemon Water","Black coffee","Coffee","Slim Milk","Slim Curd","Soya Milk","Almond Milk","Milk Shakes","Curd","Lassi","Butter Milk","Besan Veg Chilla","Egg Whites","Egg whites Omelette","Wheat Flakes","Muesli","Oats","Isabgol","Mix Seeds","Chia Seeds","Herb Powder","Meethi Seeds","Flax seeds","Juices","Yogurt","Daliya","Vermicilli Veg Upma","Veg Poha","Salad","Soup","Roti","Rice","Dal","Pulses","Sprouts","Vegetable","Barley","Chicken","Tofu","Wheat Pasta","Brown Rice","Mix Dal Dosa","Quinno Dal veg Khichadi","Daliya Dal Khichadi","Veg Raita","Sprouts","Soya Bean","Roasted Oats","Makhana","Jowar pop corn","Cole Slaw","Paneer Veg Cutlet","Besan Tomato Veg Omelette","Mushrooms","Boiled Chana","Horse Grain chaat"]
    var pcFood=["Dry Thepla","Dry Thalipeeth","Idli","Dosa","Veg Utapa","Sambhar","Fruits","Khakra","Veg Paratha","Paneer Paratha","Bhakri","Veg Omelette","veg Pan cakes","Waffles","Almonds","Walnuts","Pista","Fruit","Low Fat Paneer","Egg Whites","Fish","Quinnoa","Wheat Bran","Stir fry vegetables","Kadhi","Thepla","Chutney","Chana","Roasted Moong","Hung Curd Dip","Corn Salad","Lentil Chaat","Kurmura","Roasted Chiwda","Lowar Bajra Puff","Veg Bhel","Jowar Dhani","Granola Bar","Paneer Sandwich","Veg Sandwich","Khandvi","Patra","Plain Dry Khakra"]
    var stat = [FoodStatus]()
    public var date : String = ""
    public var pref : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        diet = DBHandler.instance.getFoodIntake(date : date)
        self.tableView.reloadData()
        
        
        topViewHeight.constant=CGFloat(min(5,diet.count+1))*15
        
        
        
        self.title="Intake"
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
        
        
        unit1.layer.borderWidth = 0.4
        unit1.layer.cornerRadius = 0
        unit1.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        unit2.layer.borderWidth = 0.4
        unit2.layer.cornerRadius = 0
        unit2.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        unit3.layer.borderWidth = 0.4
        unit3.layer.cornerRadius = 0
        unit3.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        unit4.layer.borderWidth = 0.4
        unit4.layer.cornerRadius = 0
        unit4.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        unit5.layer.borderWidth = 0.4
        unit5.layer.cornerRadius = 0
        unit5.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        unit6.layer.borderWidth = 0.4
        unit6.layer.cornerRadius = 0
        unit6.layer.borderColor = UIColor.init(red:74/255.0, green:191/255.0, blue:212/255.0, alpha: 1).cgColor
        
        
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

        unitsData.append("TSP")
        unitsData.append("TBSP")
        unitsData.append("Cup")
        unitsData.append("Piece")
        unitsData.append("Plate")
        unitsData.append("Glass")
        unitsData.append("ML")
        unitsData.append("L")
        
        servingData.append("1/4")
        servingData.append("1/2")
        servingData.append("1");
        servingData.append("2");
        servingData.append("3");
        servingData.append("4");
        servingData.append("5");
        servingData.append("6");
        servingData.append("7");
        servingData.append("8");
        servingData.append("9");
        servingData.append("10");
        servingData.append("100");
        servingData.append("250");
        servingData.append("500");

        
        
       
        food1.filterStrings(foodData)
        serving1.filterStrings(servingData)
        unit1.filterStrings(unitsData)
        
        food2.filterStrings(foodData)
        serving2.filterStrings(servingData)
        unit2.filterStrings(unitsData)
        
        food3.filterStrings(foodData)
        serving3.filterStrings(servingData)
        unit3.filterStrings(unitsData)
       
        food4.filterStrings(foodData)
        serving4.filterStrings(servingData)
        unit4.filterStrings(unitsData)
       
        food5.filterStrings(foodData)
        serving5.filterStrings(servingData)
        unit5.filterStrings(unitsData)

        
        food6.filterStrings(foodData)
        serving6.filterStrings(servingData)
        unit6.filterStrings(unitsData)
        
        
        
    }
    
    @IBAction func food6Edit(_ sender: Any) {
        if cupFood.contains(food6.text!){
            unit6.text="Cup"
        }
        if pcFood.contains(food6.text!){
            unit6.text="pc"
        }
    }
    @IBAction func food5Edit(_ sender: Any) {
        if cupFood.contains(food5.text!){
            unit5.text="Cup"
        }
        if pcFood.contains(food5.text!){
            unit5.text="pc"
        }
    }
    @IBAction func food4Edit(_ sender: Any) {
        if cupFood.contains(food4.text!){
            unit4.text="Cup"
        }
        if pcFood.contains(food4.text!){
            unit4.text="pc"
        }
    }
    @IBAction func food3Edit(_ sender: Any) {
        if cupFood.contains(food3.text!){
            unit3.text="Cup"
        }
        if pcFood.contains(food3.text!){
            unit3.text="pc"
        }
    }
    @IBAction func food2Edit(_ sender: Any) {
        if cupFood.contains(food2.text!){
            unit2.text="Cup"
        }
        if pcFood.contains(food2.text!){
            unit2.text="pc"
        }
    }
    @IBAction func textFieldEditingDidChange(_ sender: Any){
        
        if cupFood.contains(food1.text!){
            unit1.text="Cup"
        }
        if pcFood.contains(food1.text!){
            unit1.text="pc"
        }
        
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
            tableView.reloadData()
            save();
            
        }else{
            
            view.makeToast(message: "Please Enter Atleast 1 Diet")
        }
    }
    
    @objc func callBackMethod() {
        tableView.reloadData()
       performSegue(withIdentifier: "toMyFood", sender: self)
        //toMyActivity
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is MyFoodTableViewController
        {
            let vc = segue.destination as? MyFoodTableViewController
            vc?.date = self.date
        }
    }
    
    
    public func save()
    {
        if flag1
        {
            data = "\(String(describing: food1.text!)) - \(String(describing: serving1.text!+self.unit1.text!)),\(date)"
        }
        if flag2
        {
            data = "\(data)$\(String(describing: food2.text!)) - \(String(describing: serving2.text!+self.unit2.text!)),\(date)"
        }
        if flag3
        {
            data = "\(data)$\(String(describing: food3.text!)) - \(String(describing: serving3.text!+self.unit3.text!)),\(date)"
        }
        if flag4
        {
            data = "\(data)$\(String(describing: food4.text!)) - \(String(describing: serving4.text!+self.unit4.text!)),\(date)"
        }
        if flag5
        {
            data = "\(data)$\(String(describing: food5.text!)) - \(String(describing: serving5.text!+self.unit5.text!)),\(date)"
        }
        if flag6
        {
            data = "\(data)$\(String(describing: food6.text!)) - \(String(describing: serving6.text!+self.unit6.text!)),\(date)"
        }

       if showProgress(show: true)
        {
            getData()
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
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBOutlet weak var onSubmitClick: UIButton!
    
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
                             _ =   DBHandler.instance.addFoodIntake(fid: 1, ftime: self.date, ffood: "\(self.food1.text!) - \(self.serving1.text!+" "+self.unit1.text!)")
                               }

                                if self.food2.text != "" {
                              _ =      DBHandler.instance.addFoodIntake(fid: 2, ftime: self.date, ffood: "\(self.food2.text!) - \(self.serving2.text!+" "+self.unit2.text!)")
                                }
                                
                                if self.food3.text != "" {
                                _ =    DBHandler.instance.addFoodIntake(fid: 3, ftime: self.date, ffood: "\(self.food3.text!) - \(self.serving3.text!+" "+self.unit3.text!)")
                                }
                                
                                if self.food4.text != "" {
                                  _ =  DBHandler.instance.addFoodIntake(fid: 4, ftime: self.date, ffood: "\(self.food4.text!) - \(self.serving4.text!+" "+self.unit4.text!)")
                                }
                                if self.food5.text != "" {
                               _ =     DBHandler.instance.addFoodIntake(fid: 5, ftime: self.date, ffood: "\(self.food5.text!) - \(self.serving5.text!+" "+self.unit5.text!)")
                                }
                                
                                if self.food6.text != "" {
                                 _ =   DBHandler.instance.addFoodIntake(fid: 6, ftime: self.date, ffood: "\(self.food6.text!) - \(self.serving6.text!+" "+self.unit6.text!)")
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
                                self.unit1.text = ""
                                self.unit2.text = ""
                                self.unit3.text = ""
                                self.unit4.text = ""
                                self.unit5.text = ""
                                self.unit6.text = ""
                                
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


    



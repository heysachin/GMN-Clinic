//
//  DBHandler.swift
//  Gmn Clinic
//
//  Created by apple on 22/01/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import SQLite
class DBHandler{
    static let instance = DBHandler()
    private let db: Connection?
    
    
    //MARK: foodintake
    private let waterin = Table("water")
    private let water_id = Expression<Int64>("id")
    private let water_time = Expression<String?>("time")
    private let water_date = Expression<String?>("date")
    private let water = Expression<Int64>("water")
    
    
    func createWaterTable() {
        do {
            try db!.run(waterin.create(ifNotExists: true) { table in
                table.column(water_id)
                table.column(water_time)
                table.column(water_date)
                table.column(water)
                
            })
            print("Created Customer table")
        } catch {
            print("Unable to create table")
        }
    }
    
    
    //MARK: foodintake
    private let foodintake = Table("foodintakea")
    private let id = Expression<Int64>("id")
    private let time = Expression<String?>("time")
    private let food = Expression<String>("food")
    

    func createFoodIntakeTable() {
        do {
            try db!.run(foodintake.create(ifNotExists: true) { table in
                table.column(id)
                table.column(time)
                table.column(food)
                
            })
            print("Created Customer table")
        } catch {
            print("Unable to create table")
        }
    }
    
    //MARK:  diet
    private let diet = Table("diet")
    private let dietId = Expression<Int64>("id")
    private let dietTime = Expression<String>("time")
    private let dietDate = Expression<String?>("date")
    private let dietFood = Expression<String>("food")
    
    
    func createDietTable() {
        do {
            try db!.run(diet.create(ifNotExists: true) { table in
                table.column(dietId,primaryKey: true)
                table.column(dietTime)
                table.column(dietDate)
                table.column(dietFood)
                
                
            })
            
            print("Created Customer table")
            
        } catch {
            
            print("Unable to create table")
            
        }
    }
    
        //db.execSQL("CREATE TABLE Foods (id INTEGER PRIMARY KEY,data TEXT,cat text,energy text,prot text ,carb text,fat text,unit text)");
    
    
    //MARK: foods
    private let foods = Table("foodsdata")
    private let fid = Expression<Int64>("id")
    private let fdata = Expression<String?>("data")

    
    func createFoodsTable() {
        do {
            
            try db!.run(foods.create(ifNotExists: true) { table in
                table.column(fid,primaryKey: true)
                table.column(fdata)
                
                        })
            print("Created Customer table")
        } catch {
            print("Unable to create table")
        }
    }
    
    
    //MARK:  activity
    private let activity = Table("activity")
    private let AId = Expression<Int64>("id")
    private let ATime = Expression<String>("time")
    private let Activ = Expression<String?>("activity")
    
    
    
    func createActivityTable() {
        do {
            try db!.run(activity.create(ifNotExists: true) { table in
                table.column(AId,primaryKey: true)
                table.column(ATime)
                table.column(Activ)
                
                
                
            })
            print("Created Customer table")
        } catch {
            print("Unable to create table")
        }
    }
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/gmnc.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
       createFoodIntakeTable()
      createDietTable()
    createFoodsTable()
    createActivityTable()
    createWaterTable()
        
  //   createContTable()
    }
    
    
    func addWaterIntake(wid: Int64,wtime: String,wdate: String, wwater: Int64) -> Int64? {
        do {
            
            let myid = try db!.run(waterin.insert(water_id <- wid, water_time <- wtime, water_date <- wdate,water <- wwater))
            print("water addedd")
            print(myid)
            return myid
        } catch {
            print("Insert failed")
            print(error)
            return -1
            
        }
    }

    func getWaterCount(date: String) -> Int64
    {
        var count  = 0
        
        do {
        let ct = try db!.scalar("SELECT count(water) FROM water where date='\(date)' ")
            print("total water count: \(String(describing: ct!))")
            let fin = "\(String(describing: ct!))"
            count = Int(fin)!
          
        
    } catch {
        print("get failed")
        print(error)
    
    return 0
    }
        return Int64(count)
    }

    func getAllWaterCount() -> Int64
    {
        var count  = 0
        
        do {
            for row in try db!.prepare("SELECT * FROM water") {
                print("total water count: \(row.count)")
                count = row.count
                
            }
        } catch {
            print("get Failed ")
            print(error)
            
            return 0
        }
        return Int64(count)
    }
    //MARK: FoodIntake Querys
    func getFoodIntake(date : String) -> [FoodIntake] {
        var foodinta = [FoodIntake]()
        
        do {
            for row in (try db!.prepare("SELECT time,food FROM foodintakea where time='\(date)'")) {
                foodinta.append(FoodIntake.init(id: 0, time: row[0] as! String, food: row[1] as! String))
               
            }

            print("Select")
        } catch {
            print("Select failed")
        }
        
        return  foodinta
    }
    
    
    func deleteFoodIntake(fid: Int64) -> Bool {
        do {
            let cust = foodintake.filter(id == fid)
            try db!.run(cust.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
    
    func addFoodIntake(fid: Int64,ftime: String, ffood: String) -> Int64? {
        do {
            
            let myid = try db!.run(foodintake.insert(id <- fid, time <- ftime, food <- ffood))
            print("addedd customer")
            return myid
            
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: Diet Querys
    func getDiet() -> [Diet] {
        var foodinta = [Diet]()
        
        do {
            for cust in try db!.prepare(self.diet) {
                foodinta.append(Diet(
                    id: cust[self.dietId],
                    time: cust[self.dietTime],
                    date: cust[self.dietFood],
                    food: cust[self.dietDate]!))
            }
            print("Select")
        } catch {
            print("Select failed")
        }
        
        return  foodinta
    }
    
    
    func deleteDiet(did: Int64) -> Bool {
        do {
            let cust = diet.filter(dietId == did)
            try db!.run(cust.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
    
    func addDiet(did: Int64,dtime: String, dfood: String, ddate: String) -> Int64? {
        do {
            
            let myid = try db!.run(foodintake.insert(dietId <- did, dietTime <- dtime, dietDate <- dfood, dietFood <- dfood))
            print("addedd customer")
            return myid
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    
    
  
   
    //MARK: Foods Querys
    func getFoods() -> [Foods] {
        var foodinta = [Foods]()
        
        do {
            for cust in try db!.prepare(self.foods) {
                foodinta.append(Foods(
                    id: cust[self.fid],
                    fdata: cust[self.fdata]!))
            }
            print("Select")
        } catch {
            print("Select failed")
        }
        
        return  foodinta
    }
    
    
    func deleteDiet(fid: Int64) -> Bool {
        do {
            let cust = diet.filter(self.fid == fid)
            try db!.run(cust.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
    
    func addDiet(i: Int64,d: String) -> Int64? {
        do {
            
            let myid = try db!.run(foods.insert(fid <- i, fdata <- d))
            print("addedd customer")
            return myid
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    //MARK: Foods Querys
    func getActivity(date:String) -> [Activity] {
        var foodinta = [Activity]()
        
        do {
            for row in (try db!.prepare("SELECT time,activity FROM activity where time='\(date)'")) {
                foodinta.append(Activity.init(id: 0, time: row[0] as! String, activi: row[1] as! String))
                print("\(String(describing: row[0]!) )  act   \(row[1]!)")
            }
            
            print("Select")
        } catch {
            print("Select failed")
        }
        
        
        return  foodinta
    }
    
    
    func deleteActivity(fid: Int64) -> Bool {
        do {
            let cust = activity.filter(self.AId == fid)
            try db!.run(cust.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
    
    func addActivity(time: String,activity: String) -> Int64? {
        do {
            
            let myid = try db!.run(self.activity.insert(ATime <- time, Activ <- activity))
            print("addedd customer")
            return myid
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
}


/*
class DBHandler {
    
    static let instance = DBHandler()
    private let db: Connection?
    
    //MARK: Constact
    private let contacts = Table("contacts")
    private let id = Expression<Int64>("id")
    private let name = Expression<String?>("name")
    private let phone = Expression<String>("phone")
    private let address = Expression<String>("address")
    
    
    //MARK:  cart
    private let cart = Table("cart")
    private let pid = Expression<Int64>("id")
    private let pname = Expression<String>("name")
    private let pdesc = Expression<String?>("desc")
    private let pqty = Expression<String>("qty")
    private let pprice = Expression<String>("mrp")
    private let ptax = Expression<String>("tax")
    private let pcat = Expression<String>("cat")
    
    
    //MARK: CustomerTable
    private let customer = Table("Customer")
    private let csid = Expression<Int64>("id")
    private let csname = Expression<String?>("name")
    private let csaddress = Expression<String>("address")
    
    
    //MARK: Product
    private let product = Table("product")
    private let pr_id = Expression<Int64>("id")
    private let pr_name = Expression<String>("name")
    private let pr_desc = Expression<String?>("desc")
    private let pr_qty = Expression<String>("qty")
    private let pr_price = Expression<String>("mrp")
    private let pr_tax = Expression<String>("tax")
    private let pr_cat = Expression<String>("cat")
    
    
    //MARK: cat
    private let categoery = Table("categoery")
    private let cat_id = Expression<Int64>("id")
    private let cat_name = Expression<String>("name")
    
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/modernDairy.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        createCartTable()
        createCatTable()
        createCustTable()
        createProductTable()
        createContTable()
    }
    //Mark: createCustTable
    func createCustTable() {
        do {
            try db!.run(customer.create(ifNotExists: true) { table in
                table.column(csid)
                table.column(csname)
                table.column(csaddress)
                
            })
            print("Created Customer table")
        } catch {
            print("Unable to create table")
        }
    }
    
    //Mark: createCatTable
    func createCatTable() {
        do {
            try db!.run(categoery.create(ifNotExists: true) { table in
                table.column(cat_id)
                table.column(cat_name,unique: true)
                
            })
            print("Created Categoery table")
        } catch {
            print("Unable to create table")
        }
    }
    //Mark: createProductTable
    func createProductTable() {
        do {
            try db!.run(product.create(ifNotExists: true) { table in
                table.column(pr_id)
                table.column(pr_name)
                table.column(pr_desc)
                table.column(pr_qty)
                table.column(pr_tax)
                table.column(pr_price)
                table.column(pr_cat)
            })
            
            print("Created product table")
        } catch {
            print("Unable to create table")
        }
    }
    //Mark: createCartTable
    func createCartTable() {
        do {
            try db!.run(cart.create(ifNotExists: true) { table in
                table.column(pid)
                table.column(pname)
                table.column(pdesc)
                table.column(pqty)
                table.column(ptax)
                table.column(pprice)
                table.column(pcat)
            })
            print("Created Cart table")
        } catch {
            print("Unable to create table")
        }
    }
    
    
    //Mark: createContTable
    func createContTable() {
        do {
            try db!.run(contacts.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(phone, unique: true)
                table.column(address)
            })
            print("Created Contact table")
        } catch {
            print("Unable to create table")
        }
    }
    
    
    //MARK: Customer Querys
    func getCustomer() -> [Customer] {
        var customers = [Customer]()
        
        do {
            for cust in try db!.prepare(self.customer) {
                customers.append(Customer(
                    id: cust[id],
                    name: cust[name]!,
                    address: cust[address]))
            }
            print("Select")
        } catch {
            print("Select failed")
        }
        
        return  customers
    }
    
    
    
    func deleteCustomer(cid: Int64) -> Bool {
        do {
            let cust = customer.filter(id == cid)
            try db!.run(cust.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
    
    func addCustomer(cid: Int64,cname: String, caddress: String) -> Int64? {
        do {
            
            let id = try db!.run(customer.insert(csid <- cid,csname <- cname, address <- caddress))
            print("addedd customer")
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    
    
    
    
    
    
    
    
    //MARK: Product  Querys
    func getProduct() -> [Product] {
        var products = [Product]()
        
        do {
            for prod in try db!.prepare(self.product) {
                
                //init(id: Int64, name: String, tax: String, qty: String, mrp: String, desc: String, cat: String) {
                
                products.append(Product(id: prod[pr_id],
                                        name: prod[pr_name],
                                        tax: Int64(prod[pr_tax])!,
                                        qty: Int64(prod[pr_qty])!,
                                        mrp: Double(prod[pr_price])!,
                                        desc: prod[pr_desc]!,
                                        cat: prod[pr_cat]
                    
                ))
            }
            print("Select")
        } catch {
            print("Select failed")
        }
        
        return  products
    }
    
    
    
    func deleteProduct(cid: Int64) -> Bool {
        do {
            let prod = product.filter(id == cid)
            try db!.run(prod.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
    
    func addProduct(cid: Int64,cname: String, tax: String,cmrp: String, cdesc: String, ccat:String) -> Int64? {
        do {
            
            let id = try db!.run(product.insert(pr_id <- cid,pr_name <- cname, pr_price <- cmrp, pr_desc <- cdesc, pr_cat <- ccat))
            print("addedd Product")
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    
    
    
    //MARK: Cart
    func getCart() -> [Cart] {
        var carts = [Cart]()
        
        do {
            for c in try db!.prepare(self.cart) {
                
                //init(id: Int64, name: String, tax: String, qty: String, mrp: String, desc: String, cat: String) {
                
                carts.append(Cart(id: c[pid],
                                  name: c[pname],
                                  tax: c[ptax],
                                  qty: c[pqty],
                                  mrp: c[pprice],
                                  desc: c[pdesc]!,
                                  cat: c[pcat]
                    
                ))
            }
            print("Select")
        } catch {
            print("Select failed")
        }
        
        return  carts
    }
    
    func getCartById(cid: Int64) -> Int64 {
        var count : Int64 = 0
        
        do {
            
            
            for c in try db!.prepare("SELECT id FROM cart where id=\(cid)") {
                count=1
                print("id: \(c[0] ?? "def")")
                
                
            }
            
        } catch {
            print(error)
            print("Select failed")
        }
        
        return  count
    }
    
    func getQtyCartById(cid: Int64) -> String {
        var count : String = ""
        
        do {
            
            
            for c in try db!.prepare("SELECT qty FROM cart where id=\(cid)") {
                count=c[0]! as! String
                print("id: \(c[0] ?? "def")")
                
                //init(id: Int64, name: String, tax: String, qty: String, mrp: String, desc: String, cat: String) {
                /*
                 carts.append(Cart(id: c[pid],
                 name: c[pname],
                 tax: c[ptax],
                 qty: c[pqty],
                 mrp: c[pprice],
                 desc: c[pdesc]!,
                 cat: c[pcat]
                 
                 ))*/
            }
            print("Select")
        } catch {
            print(error)
            print("Select failed")
        }
        
        return  count
    }
    
    func deleteCart(cid: Int64) -> Bool {
        do {
            let prod = cart.filter(id == cid)
            try db!.run(prod.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
    
    
    func addCart(cid: Int64,cname: String, tax: String,cmrp: String, cdesc: String, ccat:String, cqt:String,ctax:String) -> Int64? {
        do {
            
            let id = try db!.run(cart.insert(pid <- cid,pname <- cname, pprice <- cmrp, pdesc <- cdesc, pcat <- ccat, pqty <- cqt,ptax <- ctax))
            print("addedd Cart")
            return id
        } catch {
            print(error)
            print("Insert failed")
            return -1
        }
    }
    
    /*
     //MARK:  cart
     private let cart = Table("cart")
     private let pid = Expression<Int64>("id")
     private let pname = Expression<String>("name")
     private let pdesc = Expression<String?>("desc")
     private let pqty = Expression<String>("qty")
     private let pprice = Expression<String>("mrp")
     private let ptax = Expression<String>("tax")
     private let pcat = Expression<String>("cat")
     
     */
    func updateCart(cid:Int64, qty: String) -> Bool {
        let contact = cart.filter(id == cid)
        do {
            let update = contact.update([
                pqty <- qty
                ])
            if try db!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }
    
    
    
    
    
    
    
    
    
    //Contacts Querys
    func addContact(cname: String, cphone: String, caddress: String) -> Int64? {
        do {
            let insert = contacts.insert(name <- cname, phone <- cphone, address <- caddress)
            let id = try db!.run(insert)
            print("Inserted Conatct")
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    func getContacts() -> [Contact] {
        var contacts = [Contact]()
        
        do {
            for contact in try db!.prepare(self.contacts) {
                contacts.append(Contact(
                    id: contact[id],
                    name: contact[name]!,
                    phone: contact[phone],
                    address: contact[address]))
            }
        } catch {
            print("Select failed")
        }
        
        return contacts
    }
    
    
    func deleteContact(cid: Int64) -> Bool {
        do {
            let contact = contacts.filter(id == cid)
            try db!.run(contact.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
    
    func updateContact(cid:Int64, newContact: Contact) -> Bool {
        let contact = contacts.filter(id == cid)
        do {
            let update = contact.update([
                name <- newContact.name,
                phone <- newContact.phone,
                address <- newContact.address
                ])
            if try db!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }
    
    
    
    
    
    
    //MARK: Categoery Querys
    func addCategory(id: Int64, cname: String) -> Int64? {
        do {
            let insert = categoery.insert(cat_id <- id, cat_name <- cname)
            let id = try db!.run(insert)
            print("Inserted Conatct")
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    func getCategoery() -> [Category] {
        var cats = [Category]()
        
        do {
            for cat in try db!.prepare(self.categoery) {
                cats.append(Category(
                    id: cat[cat_id],
                    name: cat[cat_name]))
            }
        } catch {
            print("Select failed")
        }
        
        return cats
    }
    
    
    func deleteCategoery(cid: Int64) -> Bool {
        do {
            let contact = categoery.filter(id == cid)
            try db!.run(contact.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
    
    func updateCategory(cid:Int64, newContact: Contact) -> Bool {
        let contact = contacts.filter(id == cid)
        do {
            let update = contact.update([
                name <- newContact.name,
                phone <- newContact.phone,
                address <- newContact.address
                ])
            if try db!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }
 }
   */
    
    
    
    
    




//
//  CoreDataHandler.swift
//  Gmn Clinic
//
//  Created by apple on 05/02/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext
    {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.persistentContainer.viewContext
    }
    
    
    class func SaveObject(userName:String, password:String,  empname:String, empno:String, dieti:String, isLogged:Bool) -> Bool
    {
        let context=CoreDataHandler.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "LoginEntity", in: context)
        let managedObject = NSManagedObject(entity: entity! , insertInto: context)
        managedObject.setValue(userName, forKey: "userid")
        managedObject.setValue(password, forKey: "password")
        managedObject.setValue(empname, forKey: "empname")
        managedObject.setValue(empno, forKey: "empno")
        managedObject.setValue(isLogged, forKey: "isloggedin")
        managedObject.setValue(dieti, forKey: "dietition")
        
        
        do{
            
            try context.save()
            return true
            
        }catch
        {
            print(error)
            
            return false
        }
        
    }
    class func SaveMemberObject(number:String, name:String,  mob1:String, mob2:String, email1:String, email2:String, address:String, active:String) -> Bool
    {
        let context=CoreDataHandler.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "MemberEntity", in: context)
        let managedObject = NSManagedObject(entity: entity! , insertInto: context)
        managedObject.setValue(number, forKey: "member_number")
        managedObject.setValue(name, forKey: "member_name")
        managedObject.setValue(mob1, forKey: "mobile1")
        managedObject.setValue(mob2, forKey: "mobile2")
        managedObject.setValue(email1, forKey: "email1")
        managedObject.setValue(email2, forKey: "email2")
        managedObject.setValue(address, forKey: "address")
        managedObject.setValue(active, forKey: "active")
       
        
        
        do{
            
            try context.save()
            return true
            
        }catch
        {
            print(error)
            
            return false
        }
        
    }
    
    class func CartMemberObject(ProductId:String, ProductName:String,  Description:String, Price:String, Branchno:String, OutOfStock:String) -> Bool
    {
        let context=CoreDataHandler.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "CartEntity", in: context)
        let managedObject = NSManagedObject(entity: entity! , insertInto: context)
        managedObject.setValue(ProductId, forKey: "productId")
        managedObject.setValue(ProductName, forKey: "productName")
        managedObject.setValue(Description, forKey: "desc")
        managedObject.setValue(Price, forKey: "price")
        managedObject.setValue(Branchno, forKey: "branchno")
        managedObject.setValue(OutOfStock, forKey: "outOfStock")
        
        do{
            
            try context.save()
            return true
            
        }catch
        {
            print(error)
            
            return false
        }
        
    }
    
    class func CartMemberDelete(ProductId:String, ProductName:String,  Description:String, Price:String, Branchno:String, OutOfStock:String) -> Bool
    {
        let context=CoreDataHandler.getContext()
//        let entity = NSEntityDescription.entity(forEntityName: "CartEntity", in: context)

        
        
        let moc = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartEntity")
        fetchRequest.predicate = NSPredicate.init(format: "productId==\(ProductId)")
        
        let result = try? moc.fetch(fetchRequest)
        let resultData = result as! [CartEntity]
        
        for object in resultData {
            moc.delete(object)
        }
        
        do {
            try moc.save()
            print("saved!")
            return true
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
                return false
        } catch {
            print(error)
            return false
            
        }
        
    }
    
    
    class func fetchCartObject() -> [CartEntity]?
    {
        let context=getContext()
        var myEntity:[CartEntity]?=nil
        
        do
        {
            myEntity = try context.fetch(CartEntity.fetchRequest())
            
            return myEntity
            
        }catch{
            print(error)
            return myEntity
        }
        
        
        
        
    }
    
    
    class func featchObject() -> [LoginEntity]?
    {
        let context=getContext()
        var myEntity:[LoginEntity]?=nil
        
        do
        {
            myEntity = try context.fetch(LoginEntity.fetchRequest())
            
            return myEntity
            
        }catch{
            print(error)
            return myEntity
        }
        
        
        
        
    }
    
    
    class func featchMemberObject() -> [MemberEntity]?
    {
        let context=getContext()
        var myEntity:[MemberEntity]?=nil
        
        do
        {
            myEntity = try context.fetch(MemberEntity.fetchRequest())
            
            return myEntity
            
        }catch{
            print(error)
            return myEntity
        }
        
        
        
        
    }
    
}


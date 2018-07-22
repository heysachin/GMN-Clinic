//
//  cartViewController.swift
//  Gmn Clinic
//
//  Created by Sachin Dev on 23/07/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let cartItems=CoreDataHandler.fetchCartObject()
    
    @IBOutlet var cartTableView :UITableView!
    
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
    func showAlert(title: String,msg: String,cartItem: CartEntity)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default:
                let a = CoreDataHandler.CartMemberDelete(ProductId: cartItem.productId!, ProductName: cartItem.productName!, Description: cartItem.desc!, Price: cartItem.price!, Branchno: cartItem.branchno!, OutOfStock: cartItem.outOfStock!)
                print(a)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(cartItems?.count)
        print(cartItems!)
        let cartItems2=CoreDataHandler.fetchCartObject()
        cartTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)
        let product = cartItems![indexPath.row]
        print(product)
        cell.textLabel?.text = product.productName
        cell.detailTextLabel?.text = "Rs. " + product.price!
        cell.imageView?.image = UIImage(named: "apple (4)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlert(title: "Delete from Cart?", msg: cartItems![indexPath.row].productName!,cartItem: cartItems![indexPath.row])
    }
    
}

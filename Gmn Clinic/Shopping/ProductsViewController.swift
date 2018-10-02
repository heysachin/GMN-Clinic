//
//  Product List.swift
//  Gmn Clinic
//
//  Created by Sachin Dev on 22/07/18.
//  Copyright © 2018 Tsysinfo. All rights reserved.
//

import UIKit

struct Product : Decodable {
    
    let ProductId : String
    let ProductName :String
    let Description : String
    let Price :String
    let Branchno : String
    let OutOfStock :String
}

var cartItems = [Product]()


class ProductsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView :UITableView!
   
    
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
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Products"
        let url="\(GlobalURL)/GetProductList?BranchNo=1"
        let replaced = url.replacingOccurrences(of: " ", with: "%20")
        
        print(replaced)
        alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        _ = showProgress(show: true)
        
        HttpClientApi.instance().makeAPICall(url: replaced,  method: .GET, success: { (data, response, error) in
            
            if let data = data, let stringResponse = String(data: data, encoding: .utf8) {
                
                // received from a network request, for example
                let c = stringResponse.characters
                let r = c.index(c.startIndex, offsetBy: stringResponse.index(of: ":")!+2)..<c.index(c.endIndex, offsetBy: -2)
                let substring = stringResponse[r]
                let data  = substring.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
                let ta = data.data(using: .utf8)
                do{
                    self.products = try JSONDecoder().decode([Product].self, from: ta!)
                    for product in self.products{
                        print(product)
                    }
                    
                    self.tableView.reloadData()
                    _ = self.showProgress(show: false)
                    
                }catch{
                    
                }
            }
            
            // API call is Successfull
            
        }, failure: { (data, response, error) in
            print(response ?? "def")
            DispatchQueue.main.async {
                
                    self.showAlert(title: "Server Error", msg: "Something went wrong. Please try again")
                
            }
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        let product = products[indexPath.row]
        print(product)
        cell.textLabel?.text = product.ProductName
        cell.detailTextLabel?.text = "Rs. " + product.Price
        cell.imageView?.image = UIImage(named: "apple (4)")
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 0
        cell.clipsToBounds = true

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let productSelected=products[indexPath.row];
        showAlert(title: "Added to Cart", msg: productSelected.ProductName)
        cartItems.append(productSelected)
        _ = CoreDataHandler.CartMemberObject(ProductId: productSelected.ProductId, ProductName: productSelected.ProductName, Description: productSelected.Description, Price: productSelected.Price, Branchno: productSelected.Branchno, OutOfStock: productSelected.OutOfStock)
        print(cartItems)
    }
    
}

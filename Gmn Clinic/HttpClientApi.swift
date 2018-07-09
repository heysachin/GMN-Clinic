//
//  HttpClientApi.swift
//  ModernDairy
//
//  Created by apple on 28/12/17.
//  Copyright © 2017 Tsysinfo. All rights reserved.
//

import Foundation

//HTTP Methods
enum HttpMethod : String {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}


class HttpClientApi: NSObject{
    
    //TODO: remove app transport security arbitary constant from info.plist file once we get API's
    var request : URLRequest!
    var session : URLSession?
    
    static func instance() ->  HttpClientApi{
        
        return HttpClientApi()
    }
    
    
    
    func makeAPICall(url: String, method: HttpMethod, success:@escaping ( Data? ,HTTPURLResponse?  , NSError? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {
        
        request = URLRequest(url: URL(string: String(url))!)
     
        

        let str=""
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = str.data(using: .utf8)//?.base64EncodedData()
         
            
            //paramString.data(using: String.Encoding.utf8)
        
        request.httpMethod = method.rawValue
        
        
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        
        session = URLSession(configuration: configuration)
        //session?.configuration.timeoutIntervalForResource = 5
        //session?.configuration.timeoutIntervalForRequest = 5
        
        session?.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
          
            if let data = data {
                
                
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    success(data , response , error as NSError?)
                } else {
                    failure(data , response as? HTTPURLResponse, error as NSError?)
                }
            }else {
                
                failure(data , response as? HTTPURLResponse, error as NSError?)
                
            }
            }.resume()
        
    }
    
    func makeAPICallCat(url: String, method: HttpMethod, success:@escaping ( Data? ,HTTPURLResponse?  , NSError? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {
        
        request = URLRequest(url: URL(string: url)!)
        
        
        let str=""
        request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request?.httpBody = str.data(using: .utf8)//?.base64EncodedData()
        
        
        //paramString.data(using: String.Encoding.utf8)
        
        request?.httpMethod = method.rawValue
        
        
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        
        session = URLSession(configuration: configuration)
        //session?.configuration.timeoutIntervalForResource = 5
        //session?.configuration.timeoutIntervalForRequest = 5
        
        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
            
            if let data = data {
                
                
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    success(data , response , error as NSError?)
                } else {
                    failure(data , response as? HTTPURLResponse, error as NSError?)
                }
            }else {
                
                failure(data , response as? HTTPURLResponse, error as NSError?)
                
            }
            }.resume()
        
    }

}

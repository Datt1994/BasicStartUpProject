//
//  ApiCall.swift
//  ApiCallWithDecodable
//
//  Created by datt on 12/06/18.
//  Copyright © 2018 datt. All rights reserved.
//  https://github.com/Datt1994/ApiCallWithCodable

import UIKit

class ApiCall: NSObject {
    
    let constValueField = "application/json"
    let constHeaderField = "Content-Type"
    
    func post<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true , isErrorToast : Bool = true , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestMethod(apiUrl: apiUrl, params: requestPARAMS as [String : AnyObject], method: "POST", model: model , isLoader : isLoader , isErrorToast : isErrorToast , completion: completion)
        
    }
    
    func put<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestMethod(apiUrl:apiUrl, params: requestPARAMS as [String : AnyObject], method: "PUT",model: model , isLoader : isLoader , isErrorToast : isErrorToast ,  completion: completion)
        
    }
    func get<T : Decodable>(apiUrl : String, model: T.Type , isLoader : Bool = true , isErrorToast : Bool = true , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestGetMethod(apiUrl: apiUrl, method: "GET", model: model , isLoader : isLoader , isErrorToast : isErrorToast , completion: completion)
        
    }
    func Delete(apiUrl : String,tag : Int, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestDeleteMethod(apiUrl: apiUrl, method: "DELETE", tag : tag , completion: completion)
    }
    
    func requestMethod<T : Decodable>(apiUrl : String, params: [String: AnyObject], method: NSString, model: T.Type ,isLoader : Bool = true, isErrorToast : Bool = true , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = method as String
        request.setValue(constValueField, forHTTPHeaderField: constHeaderField)
        
         // set Authorization
        
//        if let loginData = UserDefaults.standard.retrieve(object: LoginData.self, fromKey: UserDefaultKey.loginData) ,let strToken = loginData.token {
//            request.setValue(strToken, forHTTPHeaderField: "Authorization")
//            //        request.setValue("U2FsdGVkX1+dY1/FUqEFY+iZ77CLWd+wTnfsFELwWhs=", forHTTPHeaderField: "Authorization")
//        }

        let jsonTodo: NSData
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: params, options: []) as NSData
            request.httpBody = jsonTodo as Data
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            Utility().hideLoader()
            
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(String(describing: error))")
                //                Utility().hideLoader()
                return
            }
            
            //            Utility().hideLoader()
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                let dictResponse = try decoder.decode(GenralResponseModel.self, from: data )

                let strStatus = dictResponse.status!

                if strStatus == "success" {
                    let dictResponsee = try decoder.decode(model, from: data )
                    mainThread {
                        completion(true,dictResponsee as AnyObject)
                    }
                }
                else{
                    mainThread {
                        completion(false, dictResponse.message as AnyObject)
                        if isErrorToast {
                            UIApplication.topViewController()?.view.makeToast(dictResponse.message)
                  
                        }
                    }
                }
                
                
            } catch let error as NSError {
                print(error.localizedDescription)
                
                //                do {
                //                    let dictResponse = try decoder.decode(GenralResponseModel.self, from: data )
                //
                //                    let strStatus = dictResponse.status!
                //                    mainThread {
                //                        if strStatus == "success"{
                //                            completion(true,data as AnyObject)
                //                        }
                //                        else{
                //                            completion(false, dictResponse.message as AnyObject)
                //                            UIApplication.topViewController()?.view.makeToast(dictResponse.message)
                //                        }
                //                    }
                //                } catch let error as NSError {
                mainThread {
                completion(false, error as AnyObject)
                }
               
                //                }
            }
        })
        task.resume()
    }
    
    func requestGetMethod<T : Decodable>(apiUrl : String, method: String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        
        request.httpMethod = method
        
     // set Authorization
//        if let loginData = UserDefaults.standard.retrieve(object: LoginData.self, fromKey: UserDefaultKey.loginData) ,let strToken = loginData.token , method != "GET" {
//            request.setValue(strToken, forHTTPHeaderField: "Authorization")
//        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            Utility().hideLoader()
            
            
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                let dictResponse = try decoder.decode(GenralResponseModel.self, from: data )

                let strStatus = dictResponse.status!

                if strStatus == "success" {
                    let dictResponsee = try decoder.decode(model, from: data )
                    mainThread {
                        completion(true,dictResponsee as AnyObject)
                    }
                }
                else{
                    mainThread {
                        completion(false, dictResponse.message as AnyObject)
                        if isErrorToast {
                            UIApplication.topViewController()?.view.makeToast(dictResponse.message)
                           
                        }
                    }
                }
                
                
            } catch let error as NSError {
                print(error.localizedDescription)
                
                //                do {
                //
                //                } catch let error as NSError {
                completion(false, error as AnyObject)
                //                }
            }
        })
        task.resume()
    }
    
    
    func requestDeleteMethod(apiUrl : String, method: String,tag: Int, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = method
        request.addValue(constValueField, forHTTPHeaderField: constHeaderField)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            //            Utility().hideLoader()
            
            // Check for error
            if error != nil{
                return
            }
            
            // Print out response string
            _ = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            // print("responseString = \(responseString)")
            
            do {
                if tag == 0 {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    {
                        completion(true, convertedJsonIntoDict)
                    }
                    else{
                        completion(false, nil)
                    }}
                else
                {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray
                    {
                        completion(true, convertedJsonIntoDict)
                    }
                    else{
                        completion(false, nil)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
}
//Change Genral Response as per your needs.
class GenralResponseModel : Decodable {
    
    var message : String?
    var status : String?
    
}


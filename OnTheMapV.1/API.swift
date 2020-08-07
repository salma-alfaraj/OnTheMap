//
//  API.swift
//  OnTheMapV.1
//
//  Created by salma on 05/12/1441 AH.
//  Copyright © 1441 salma. All rights reserved.
//

import Foundation
import UIKit
class API: UIViewController{
    
    static var user = UserInfo()
    static var key = " "
   
    
//    MARK: POST Method.
    static func loginStudent (_ email : String!, _ password : String!, completion: @escaping (Bool, String, Error?)->()) {
           
           var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Accept")
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.httpBody = "{\"udacity\": {\"username\": \"\(email!)\", \"password\": \"\(password!)\"}}".data(using: .utf8)
           
           
           
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if error != nil {
                   completion (false, "", error)
                   return
               }
           
               guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                   let statusCodeError = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
                   completion (false, "", statusCodeError)
                   return
               }
               
               if statusCode >= 200  && statusCode < 300 {
                   
//                 Skipping the first 5 characters
                   let range = (5..<data!.count)
                   let newData = data?.subdata(in: range) /* subset response data! */
            
                  
                   let JsonObject = try! JSONSerialization.jsonObject(with: newData!, options: [])
                   
//                Convert the object to a dictionary and call it loginDictionary
                   let loginDictionary = JsonObject as? [String : Any]
                   
//                  Get the unique key of the user
                   let account = loginDictionary? ["account"] as? [String : Any]
                   let uniqueKey = account? ["key"] as? String ?? " "
                   completion (true, uniqueKey, nil)
               } else {
                  
                   completion (false, "", nil)
               }
        }
        
        task.resume()
    }
    
     static func postLocation(link : String, latitude:Double , longitude:Double , locationName : String, completion: @escaping (Error?)->()) {

            var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = "{\"uniqueKey\": \"\(key)\", \"firstName\": \"John\", \"lastName\": \"Dou\",\"mapString\": \"\(locationName)\", \"mediaURL\": \"\(link)\",\"latitude\": \(latitude),\"longitude\": \(longitude)}".data(using: .utf8)
            
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
              
               if error != nil {
               completion(error)
                   return
               }
           
              guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                statusCode >= 200 && statusCode < 300 else {
                             completion(error)
                             return
                }
                DispatchQueue.main.async {
                  completion(nil)
                print(String(data: data!, encoding: .utf8)!)
                           }
               
            }
            task.resume()
        
          }
    
 
//   MARK: GET Method
    
    static func getAllLocations (completion: @escaping ( LocationsData? , Error? )-> Void) {
      var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt")!)
      let session = URLSession.shared
      let task = session.dataTask(with: request) { data, response, error in
        
                 // ckeck if request sent succesfully
                  if error != nil {
                     print("somthing went wrong in getAllLocations func")
                     completion(nil, error)
                      return
                  }
                 //check if response OK
                 guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                   statusCode >= 200 && statusCode < 300 else {
                    completion(nil, error)
                                return
                            }
                
                 // JSON Decoder
                   var locationsData : LocationsData?
                        do {
                         let decoder = JSONDecoder()
                          locationsData = try decoder.decode(LocationsData.self, from: data!)
                          completion( locationsData ,nil)
                         }catch {
                             completion (nil, error)
                             print("failed to convert in getAllLocations")
                         }
                     }
                    task.resume()
    }
    
    static func getUserInfo(completion: @escaping (_ error: Error? )->Void) {
          
       guard let userID = user.key , let url = URL(string: "https://onthemap-api.udacity.com/v1/users/\(key))") else{
               completion(NSError(domain: "getUser", code: 1, userInfo:nil))
               return
           }
            let request = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error
                in if error != nil {
                       print("somthing went wrong")
                       completion(error)
                        return
                    }
                   guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                     statusCode >= 200 && statusCode < 300 else {
                       completion(nil)
                        return
                   }
                  let newData = data?.subdata(in: 5..<data!.count)
               
                   if let results = try? JSONSerialization.jsonObject(with: newData!, options:[] ),
                   let  dictionary = results as? [String:Any]{
                   
                      let firstName  = dictionary["first.name"] as? String
                      let lastName   = dictionary["last.name"] as? String
                       API.user.firstName = firstName
                       API.user.lastName  = lastName
                     }
                 }
                 task.resume()
       }


    
    
//    MARK: DELETE Method.
    
     static   func logout (completion:@escaping(Error?)->()){
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                completion(error)
                return
            }
             completion(error)
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
        
    }
    
    
    
    
    
    
    
    
    
    
    
}

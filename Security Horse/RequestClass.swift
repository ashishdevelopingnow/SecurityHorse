//
//  RequestClass.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 04/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class RequestClass: NSObject {
    typealias Completion = ((_ response : AnyObject?, _ error:NSError?, _ success:Bool) -> ())
    
    struct apis {
        static let baseURL = "http://35.166.163.212/apis/"
        static let signUp = "signup"
        static let signIn = "signin"
        static let getAllJobs = "getAllJobs"
        
        static let getJobDetails = "getJobById"
        
        static let applyJob = "applyJob"
        static let viewedJob = "viewJob"
        
        static let forgotPassword = "forgotPassword"
        
        static let changeProfilePic = "changeProfilepic"
        
        static let editProfile = "fillWithFacebook"
        
        static let saveMobileNo = "saveMobilenumber"
        static let validatePin = "validatePin"
        static let resendPin = "resendPin"
        
        
        static let changeSecurityProfilePic = "changeSecurityLicense"
//        http://35.166.163.212/apis/getAllJobs
    }

    static func hitServerWith(_ showAlert : Bool , urlString : String, parameters:[String : AnyObject]?, completion:@escaping Completion) {
//        let URL = "http://54.153.105.229/apis/signin"
        //        let dict = ["email":"Nursing@developingnow.com","password":"123456"]
        
//        let almore = Alamofire.request
//        let almore = Alamofire.request(urlString, method: .POST, parameters: parameters, encoding: .JSON, headers: nil)
       let almore = Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
        
//        let almore = Alamofire.request(.POST,ur urlString, parameters: parameters, encoding: .JSON )
        almore.responseJSON(options: JSONSerialization.ReadingOptions.allowFragments) { (rr) -> Void in
            print(rr)
//            print(rr.result.value)
            if rr.result.isSuccess {
                if let dict = rr.result.value as? [String : AnyObject] {
                 
                    if let value = dict["status"] as? String,let message = dict["message"] as? String{
                        if (value == "failure" || value == "fail") && showAlert == true  {
                             UtilsSwift.showAlertWithMessage(message, dict["title"] as? String)
//                            Utils.showAlert(withMessage: message ,andTitle:  dict["title"] as? String)
                            completion(rr.result.value as AnyObject?, nil, false)
                            return
                        }else{
                            
                        }
                    }else{
                        
                    }
                    
                }
                
                completion(rr.result.value as AnyObject?, nil, true)
            }else{
                completion(rr.result.value as AnyObject?, nil, false)
            }
            
            
            
        }
        
//    almore.response { (response) in
//        print(response);
//        do {
//            let responseValue:NSDictionary =  try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
//            print(responseValue)
//        }catch{
//            
//        }
        
//        print(responseValue);
        
//        }
        
//        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON ).responseJSON { (rr) -> Void in
//        
//        }
//        
//        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON ).responseJSON { (response) in
//            
//            if(response.result.isSuccess){
//                do{
//                    let responseValue:NSDictionary =  try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
//                    
////                    let mapper = Mapper<IncidentData>().map(responseValue)
////                    print(mapper)
////                    
//                    print(responseValue)
////                    completion(responseObject: mapper, error: nil, success: true)
//                }
//                catch{
//                    //completion(responseObject: nil, error:Error.errorWithCode(.JSONSerializationFailed, failureReason: "can't parse json"), success: false)
//                }
//            }
//        }
    }
}


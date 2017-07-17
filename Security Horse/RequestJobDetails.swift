//
//  RequestJobDetails.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 16/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import Foundation
import UIKit

extension RequestClass{
    static func getJobDetails(_ jobId : String , result :  Completion?){
        
//        2. http://35.166.163.212/apis/getJobById
//        Param: job_id
        
        
        //        1. http://35.166.163.212/apis/forgotPassword
        let dict =
            [
                "job_id" : "\(jobId)"
        ]
        let url = apis.baseURL + apis.getJobDetails
        
        hitServerWith(true,urlString:url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
            result?(response, error, success)
            guard success == true else {
                return
            }
            if let dict = response as? [String : AnyObject] {
                
                if let message = dict["message"] as? String{
//                    Utils.showAlert(withMessage: message)
                }else
                    if let message = dict["msg"] as? String{
//                        Utils.showAlert(withMessage: message)
                }
            }
        }
        
        
    }
    
    static func applyForJob(jobid jobId : String ,userID : String?,email : String?, fullName : String?,phoneNumber : String?, viewController : UIViewController, result :  Completion?){
        
        let dict = [
            "job_id" : jobId as AnyObject,
            "user_id" : userID as AnyObject,
            
            "email" : email as AnyObject,
            "fullname" : fullName as AnyObject,
            "phonenumber" : phoneNumber as AnyObject,
            
        ]
        
        print("asdasd   %@",dict)
//        var dict : [String : AnyObject]?
//        if let user_Id = userID {
//            dict = [
//                "job_id" : jobId as AnyObject,
//                "user_id" : user_Id as AnyObject
//            ]
//        }
////        else if let email_Id = email , let pass = password {
////            dict = [
////                "job_id" : jobId as AnyObject,
////                
////                "email" : email_Id as AnyObject,
////                "password" : pass as AnyObject
////                
////            ]
////        }
//        else if let email_Id = email {
//            dict = [
//                "job_id" : jobId as AnyObject,
//                "email" : email_Id as AnyObject
//                
//            ]
//        }
        
        
        
        
        let url = apis.baseURL + apis.applyJob
        
        hitServerWith(false,urlString:url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            if let dict = response as? [String : AnyObject] , let isRegistered = dict["is_register"]?.int16Value , isRegistered == 1 , let value = dict["status"] as? String , (value == "failure" || value == "fail") , let alertTitle = dict["title"] as? String,let message = dict["message"] as? String{
                
                
                
                
                let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertControllerStyle.alert)
                //                alert.addTextField { (textFeild) -> Void in
                //                    print("abc")
                //                    textFeild.placeholder = "Enter your email"
                //                }
                
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.cancel, handler:{ (ACTION :UIAlertAction!)in
                    //            println("User click Ok button")
                    
                    result?(response, error, false)
                }))
                
                
                alert.addAction(UIAlertAction(title: "Sign In", style: UIAlertActionStyle.default, handler:{ (ACTION :UIAlertAction!)in
                    //            println("User click Ok button")
                    result?("1" as AnyObject?, error, false)
                    
                }))
                
                
                viewController.present(alert, animated: true, completion: nil)
                
                return
            }
            if let dict = response as? [String : AnyObject] , let value = dict["status"] as? String,let message = dict["message"] as? String, (value == "failure" || value == "fail"){
                
                UtilsSwift.showAlertWithMessage(message, dict["title"] as? String)
//                Utils.showAlert(withMessage: message ,andTitle: dict["title"] as? String)
                
                result?(response, error, false)
                return
            }
            guard success == true else {
                result?(response, error, false)
                return
            }
//            print("sucessss     :::::::: \(success)")
            result?(response, error, success)
//            guard success == true else {
//                return
//            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserDefault.NOTIFICATION.Applied_Job), object: nil)
            if let dict = response as? [String : AnyObject] {
                
                if let dict2 = dict["data"] as? [String : AnyObject] , let dict3 = dict2["User"] as? [String : AnyObject] {
                    UserDefault.saveUserInfo(dict3)
                }
                
                if let message = dict["message"] as? String{
                    UtilsSwift.showAlertWithMessage(message, dict["title"] as? String)
//                    Utils.showAlert(withMessage: message,andTitle: dict["title"] as? String)
                }else
                    if let message = dict["msg"] as? String{
                        UtilsSwift.showAlertWithMessage(message, dict["title"] as? String)
//                    Utils.showAlert(withMessage: message, andTitle: dict["title"] as? String)
                }
            }
        }
        
        
    }
    
    static func viewJob(jobid jobId : String ,userID : String, result :  Completion?){
        
        //        2. http://35.166.163.212/apis/getJobById
        //        Param: job_id
        
        
        //        1. http://35.166.163.212/apis/forgotPassword
        let dict =
            [
                "job_id" : jobId,
                "user_id" : userID
        ]
        
        let url = apis.baseURL + apis.viewedJob
        
        hitServerWith(true,urlString:url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
            result?(response, error, success)
            guard success == true else {
                return
            }
            if let dict = response as? [String : AnyObject] {
                
                if let message = dict["message"] as? String{
                    //                    Utils.showAlert(withMessage: message)
                }else
                    if let message = dict["msg"] as? String{
                        //                        Utils.showAlert(withMessage: message)
                }
            }
        }
        
        
    }

}

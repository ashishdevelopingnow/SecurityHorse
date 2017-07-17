//
//  MobileNumberVerification.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 03/04/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import Foundation
import UIKit

import Alamofire
import ObjectMapper

extension RequestClass{
    static func saveMobileNumber(_ mobile_number : String, user_id : String , result :  Completion?){
        
        //        2. http://35.166.163.212/apis/getJobById
        //        Param: job_id
        
        
        //        1. http://35.166.163.212/apis/forgotPassword
        let dict =
            [
                "user_id" : user_id,
                "mobile_number" : mobile_number
        ]
//        static let saveMobileNo = "saveMobilenumber"
        let url = apis.baseURL + apis.saveMobileNo
        
        hitServerWith(true,urlString:url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
            result?(response, error, success)
            guard success == true else {
                return
            }
//            if let dict = response as? [String : AnyObject] {
//                
//                if let message = dict["message"] as? String {
//                    UtilsSwift.showAlertWithMessage(message, dict["title"] as? String)
//
//                    
//                }else
//                    if let message = dict["msg"] as? String{
//                        UtilsSwift.showAlertWithMessage(message, dict["title"] as? String)
//
//                }
//            }
        }
        
        
    }
    
    static func sendOTP(_ pinNumber : String, user_id : String , result :  Completion?){
        
        //        2. http://35.166.163.212/apis/getJobById
        //        Param: job_id
        
        
        //        1. http://35.166.163.212/apis/forgotPassword
        let dict =
            [
                "user_id" : user_id,
                "pin_num" : pinNumber
        ]
        //        static let saveMobileNo = "saveMobilenumber"
        let url = apis.baseURL + apis.validatePin
        
        hitServerWith(true,urlString:url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
            result?(response, error, success)
            guard success == true else {
                return
            }
            if let dict = response as? [String : AnyObject] {
                
                if let message = dict["message"] as? String {
                    UtilsSwift.showAlertWithMessage(message, dict["title"] as? String)
                    //                    Utils.showAlert(withMessage: message, andTitle:   dict["title"] as? String)
                    
                }else
                    if let message = dict["msg"] as? String{
                        UtilsSwift.showAlertWithMessage(message, dict["title"] as? String)
                        //                        Utils.showAlert(withMessage: message, andTitle:   dict["title"] as? String)
                        //                                    Utils.showAlert(withMessage: message)
                }
            }
        }
        
        
    }
    static func resendOTP(_ user_id : String , result :  Completion?){
        
        //        2. http://35.166.163.212/apis/getJobById
        //        Param: job_id
        
        
        //        1. http://35.166.163.212/apis/forgotPassword
        let dict =
            [
                "user_id" : user_id
        ]
        //        static let saveMobileNo = "saveMobilenumber"
        let url = apis.baseURL + apis.resendPin
        
        hitServerWith(true,urlString:url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
            result?(response, error, success)
            guard success == true else {
                return
            }
            if let dict = response as? [String : AnyObject] {
                
                if let message = dict["message"] as? String {
                    UtilsSwift.showAlertWithMessage(message, dict["title"] as? String)
                    //                    Utils.showAlert(withMessage: message, andTitle:   dict["title"] as? String)
                    
                }else
                    if let message = dict["msg"] as? String{
                        UtilsSwift.showAlertWithMessage(message, dict["title"] as? String)
                        //                        Utils.showAlert(withMessage: message, andTitle:   dict["title"] as? String)
                        //                                    Utils.showAlert(withMessage: message)
                }
            }
        }
        
        
    }


}

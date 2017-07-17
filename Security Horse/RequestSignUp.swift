//
//  RequestSignUp.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 04/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class RequestSignUp: RequestClass {

    static func signUpWith(_ email : String, viewController : UIViewController , result :  Completion?){
//        {"email":"pravesh1@developingnow.com","password":"123456","fname":"Pravesh","lname":"Signh","mobile_number":"9898989898"}
        let dict =
        [
            "email" : email,
//            "password" : "",
//            "fname" : "",
//            "lname" : "",
//            "mobile_number" : ""
        ]
        let url = apis.baseURL + apis.signUp
        
        
        hitServerWith(false,urlString:  url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
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
//                UIApplication.shared.keyWindow?.makeToast(message)
                result?(response, error, false)
                return
            }
            guard success == true else {
                result?(response, error, false)
                return
            }
            if let dict = response as? [String : AnyObject] {
                if let dict2 = dict["data"] as? [String : AnyObject] , let dict3 = dict2["User"] as? [String : AnyObject] {
                    UserDefault.saveUserInfo(dict3)
                    
                    if let message = dict["message"] as? String {
                        UtilsSwift.showAlertWithMessage(message, dict["title"] as? String)
//                        Utils.showAlert(withMessage: message,andTitle: dict["title"] as? String)
                    }
                    result?(response, error, success)
                    return
                }
                
            }
            result?(response, error, false)
            
        }
        
        

    }
    
    static func signInWith(_ email : String ,password : String, result :  Completion?){
//        http://35.166.163.212/apis/signin
//        Params :
//        {"email":"pravesh@developingnow.com","password":"123456"}
        let dict =
        [
            "email" : email,
            "password" : password
        ]
        let url = apis.baseURL + apis.signIn
        
        hitServerWith(true,urlString:url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
            
            guard success == true else {
                
                result?(response, error, false)
                return
            }
            if let dict = response as? [String : AnyObject] {
                if let dict2 = dict["response"] as? [String : AnyObject] , let dict3 = dict2["userData"] as? [String : AnyObject] {
                    UserDefault.saveUserInfo(dict3)
                    
                    if let message = dict["message"] as? String{
                        UIApplication.shared.keyWindow?.makeToast(message)
//                        UtilsSwift.showAlertWithMessage(message, nil)
//                        Utils.showAlert(withMessage: message,andTitle: nil)
                    }
                    result?(response, error, success)
                    return
                }
                
            }
            result?(response, error, false)
            
        }
        
        
    }
    
    static func forgotPassword(_ email : String , result :  Completion?){
        //        http://35.166.163.212/apis/signin
        //        Params :
        //        {"email":"pravesh@developingnow.com","password":"123456"}
        
//        1. http://35.166.163.212/apis/forgotPassword
        let dict =
            [
                "email" : email
        ]
        let url = apis.baseURL + apis.forgotPassword
        
        hitServerWith(true,urlString:url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
            result?(response, error, success)
            guard success == true else {
                return
            }
            if let dict = response as? [String : AnyObject] {
                
                if let message = dict["message"] as? String{
                    
                    UtilsSwift.showAlertWithMessage(message, nil)
//                    Utils.showAlert(withMessage: message,andTitle: nil)
                }else
                if let message = dict["msg"] as? String{
                    
                    UtilsSwift.showAlertWithMessage(message, nil)
//                    Utils.showAlert(withMessage: message,andTitle: nil)
                }
            }
        }
        
        
    }
    
    
    

}

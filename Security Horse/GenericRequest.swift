//
//  GenericRequest.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 31/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit
import UIKit
import Alamofire
import ObjectMapper

extension RequestClass{
    static func uploadProfilePic(_ user_id : String ,image : UIImage,  result :  Completion?){
        
        //        2. http://35.166.163.212/apis/getJobById
        //        Param: job_id
        
        
        //        1. http://35.166.163.212/apis/forgotPassword
        let parameters =
            [
                "user_id" : user_id
        ]
        let urlString = apis.baseURL + apis.changeProfilePic
        
//        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
//        let almore = Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
        Alamofire.upload(multipartFormData: { (multipartFormData) in

            if let imageData = UIImageJPEGRepresentation(image, 0.1) {
                multipartFormData.append(imageData, withName: "profile_pic", fileName: "profile_pic.png", mimeType: "image/png")
            }
            
            for (key, value) in parameters {
                
//                multipartFormData.append(data: value.data(using: String.Encoding.utf8)!, name: key)
                if let dd = value.data(using: String.Encoding.utf8){
                    multipartFormData.append(dd, withName: key)
                }
                
            }
        }, to: urlString) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { responseValue in
                    debugPrint(responseValue)
                    do {
                        let response =  try JSONSerialization.jsonObject(with: responseValue.data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : AnyObject]
                        print("uuuuu rrr lll  ::: \(response)")
                        
//                        if let dict = response  , let value = dict["status"] as? String,let message = dict["message"] as? String, (value == "failure" || value == "fail"){
//                            Utils.showAlert(withMessage: message ,andTitle: dict["title"] as? String)
//                            
//                            result?(response, error, false)
//                            return
//                        }
//                        guard success == true else {
//                            result?(response, error, false)
//                            return
//                        }
//                        if let dict = response as? [String : AnyObject] {
//                            if let dict2 = dict["data"] as? [String : AnyObject] , let dict3 = dict2["User"] as? [String : AnyObject] {
//                                UserDefault.saveUserInfo(dict3)
//                                
//                                if let message = dict["message"] as? String {
//                                    Utils.showAlert(withMessage: message,andTitle: dict["title"] as? String)
//                                }
//                                result?(response, error, success)
//                                return
//                            }
//                            
//                        }
//                        result?(response, error, false)
                        print(responseValue)
                        if let a = response ,
                            let aa = a["response"] as? [String : AnyObject],
                            let bb = aa["userData"] as? [String : AnyObject],
                            let cc = bb["profile_img"]
                        {
                            debugPrint(cc)
                            result?(cc , nil, true)
                        }else{
                            result?(response as AnyObject?, nil, false)
                        }
                        
                        
                        
                    }catch{
                          result?(responseValue as AnyObject?, nil, false)
                        
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                 result?(nil, nil, false)
            }

        }
    }
    
    static func uploadSecurityLicense(_ user_id : String ,image : UIImage,  result :  Completion?){
        
        //        2. http://35.166.163.212/apis/getJobById
        //        Param: job_id
        
        
        //        1. http://35.166.163.212/apis/forgotPassword
        let parameters =
            [
                "user_id" : user_id
        ]
        let urlString = apis.baseURL + apis.changeSecurityProfilePic
        
        //        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        //        let almore = Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let imageData = UIImageJPEGRepresentation(image, 0.1) {
                multipartFormData.append(imageData, withName: "profile_pic", fileName: "profile_pic.png", mimeType: "image/png")
            }
            
            for (key, value) in parameters {
                
                //                multipartFormData.append(data: value.data(using: String.Encoding.utf8)!, name: key)
                if let dd = value.data(using: String.Encoding.utf8){
                    multipartFormData.append(dd, withName: key)
                }
                
            }
        }, to: urlString) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { responseValue in
                    debugPrint(responseValue)
                    do {
                        let response =  try JSONSerialization.jsonObject(with: responseValue.data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : AnyObject]
                        print("uuuuu rrr lll  ::: \(response)")
                        
                       
                        print(responseValue)
                        if let a = response ,
                            let aa = a["response"] as? [String : AnyObject],
                            let bb = aa["userData"] as? [String : AnyObject],
                            let cc = bb["security_license"]
                        {
                            debugPrint(cc)
                            result?(cc , nil, true)
                        }else{
                            result?(response as AnyObject?, nil, false)
                        }
                        
                        
                        
                    }catch{
                        result?(responseValue as AnyObject?, nil, false)
                        
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                result?(nil, nil, false)
            }
            
        }
    }
    
        
        
        
    
        
        
}

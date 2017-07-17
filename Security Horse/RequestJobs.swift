//
//  RequestJobs.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 05/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit
import ObjectMapper
class RequestJobs: RequestClass {

    static func getJobList(_ offset : Int ,userId : String?, result :  Completion?){
        //        http://35.166.163.212/apis/getAllJobs
        //        Params : {"offset":0}
        var dict : Dictionary =
        [
            "offset" : offset as AnyObject
            
        ]
        if let user_id = userId {
            dict["user_id"] = user_id as AnyObject?
        }
        print("dictionarryyyyy  ::::: %@",dict)
        let url = apis.baseURL + apis.getAllJobs
        
        hitServerWith(true,urlString:url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
//            result?(response, error, success)
            guard success == true else {
                result?(nil,error,false)
                return
            }
            if let dict = response as? [String : AnyObject] {
                let mapper = Mapper<Jobs>().map(JSONObject: dict)
//                let mapper = Mapper<Jobs>().map(_, response)
                result?(mapper,error,true)
//                if let resp = dict["response"] as? [String : AnyObject], let jobs = resp["jobs"] as? [AnyObject] {
////                    Utils.showAlert(withMessage: message)
//                    
//                }
            }else{
                result?(nil,error,false)
            }
        }
        
        
    }
}

//
//  ProfileRequest.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 02/03/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import Foundation
import Foundation
import UIKit
extension RequestClass{
    static func editProfile(userId : String ,jobprofile : Profile, result :  Completion?){
        
//        "linkedinProfile":[
//        {
//        "linkedin_profile_id":8,
//        "is_linkedin":1,
//        "li_unique_id":"234234234234",
//        "position_title":"TL",
//        "location":"Dehradun",
//        "company_name":"DevelopingNow",
//        "start_date":"March 2017",
//        "end_date":"March 2017",
//        "position_responsibility":"asdasd"
//        },
//        {
//        "linkedin_profile_id":15,
//        "is_linkedin":0,
//        "li_unique_id":"",
//        "position_title":"TL",
//        "location":"Dehradun",
//        "company_name":"DevelopingNow",
//        "start_date":"March 2017",
//        "end_date":"March 2017",
//        "position_responsibility":"asdasd"
//        }
//        ]
//        [21/03/17, 9:08:47 PM] John K: is_linkedin
//        [21/03/17, 9:08:57 PM] John K: li_unique_id
//        [21/03/17, 9:09:28 PM] John K: position_title
//        [21/03/17, 9:09:32 PM] John K: location
//        [21/03/17, 9:09:41 PM] John K: company_name
//        [21/03/17, 9:09:44 PM] John K: start_date
//        [21/03/17, 9:09:48 PM] John K: end_date
//        [21/03/17, 9:11:06 PM] John K: 0000-00-00 00:00:00
//        [21/03/17, 9:11:38 PM] John K: position_responsibility
//        [21/03/17, 9:12:12 PM] John K: user_id
//        [21/03/17, 9:13:15 PM] John K: linkedin_profile_id

        var linktarry  = [[String : Any]]()
        for object in jobprofile.linkedInArray {
            if jobprofile.checkToAddForRequest(linkedInProfile: object){
                
                let startDate = Utils.string(fromDateLocalformat: object.startJobDate, format: "yyyy-MM-dd")
                let endDate = Utils.string(fromDateLocalformat: object.endJobDate, format: "yyyy-MM-dd")
                let dictLin =
                    [
                        "is_linkedin" : object.isFromLinkedIn,
                        "li_unique_id" : object.linkedIn_id,
                        "position_title" : object.positionTitle,
                        "location" : object.location,
                        "company_name" : object.companyName,
                        "start_date" : startDate,
                        "end_date" : endDate,
                        "is_current" : object.isCurrentlyWorking,
                        "position_responsibility": object.positionResponsibility,
                        "user_id" : userId
                ] as [String : Any?]
                linktarry.append(dictLin)
            }
        }
        
        let dict = ["user_id" : userId,
                    "fname":jobprofile.facebookProfile.fullName,
                    "lname":"",
                    "mobile_number":jobprofile.facebookProfile.phoneNumber,
                    "description":jobprofile.facebookProfile.desciptionFB,
                    "fb_id_unique":jobprofile.isFacebookActivated ? jobprofile.facebookProfile.fbId : nil,
                    "profile_img":jobprofile.facebookProfile.profilePic,
                    "gender":"",
            "email":jobprofile.facebookProfile.email,
            
            "linkedinProfile" : linktarry
        ] as [String : Any?]
//        let dict = ["user_id" : "3",
//                    "fname":"kuldeep",
//                    "lname":"butola",
//                    "mobile_number":"",
//                    "description":"hi",
//                    "fb_id_unique":"1234",
//                    "profile_img":"xyz",
//                    "gender":"male"
//        ]
        print("dict === ",dict)
        let url = apis.baseURL + apis.editProfile
        
        hitServerWith(true,urlString:url, parameters: dict as [String : AnyObject]?) { (response, error, success) -> () in
            print("sucessss     :::::::: \(success)")
            defer {
                result?(response, error, success)
            }
            
            guard success == true else {
//                result?(response, error, false)
                return
            }
            if let dict = response as? [String : AnyObject] {
                if let dict2 = dict["data"] as? [String : AnyObject]{
                    UserDefault.saveUserInfo(dict2)
                    
//                    if let message = dict["message"] as? String{
//                        UtilsSwift.showAlertWithMessage(message, nil)
////                        Utils.showAlert(withMessage: message,andTitle: nil)
//                    }
                    
                    
//                    result?(response, error, success)
                    return
                }
            }
//            result?(response, error, false)
            
//            if let dict = response as? [String : AnyObject] {
//                
//                if let message = dict["message"] as? String{
//                    //                    Utils.showAlert(withMessage: message)
//                }else
//                    if let message = dict["msg"] as? String{
//                        //                        Utils.showAlert(withMessage: message)
//                }
//            }
        }
    }
    
    
        
}

//
//  Profile.swift
//  Security Horse
//
//  Created by Rahul Sharma on 22/02/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit
import ObjectMapper

class Profile: NSObject {

    var facebookProfile = FaceBookProfile.init()
    var linkedInArray = [LinkedInProfile]()
    var isFacebookActivated : Bool = false
    var isLinkedInActivated : Bool = false
    var rating = 0
    
    var tempImg : UIImage?
    override init() {
        super.init()
        
    }
    
    
    func initWithLinkedIn(_ bool : Bool){
//        let profile = Profile.init()
        let lnk = LinkedInProfile.init()
        lnk.isFromLinkedIn = bool
        self.linkedInArray.removeAll()
        self.linkedInArray.append(lnk)
        
    }
//    public required init?(map: Map) {
//        
//    }
//    func mapping(map: Map) {
////        message <- map["status"]
////        offset <- map["offset"]
////        jobsArray <- map["response.jobs"]
//    }
    
    func checkToAddNewPosition()->Bool{
//        let count = linkedInArray.count - 1
        if let linkedInProfile = linkedInArray.last{
            if linkedInProfile.isFromLinkedIn == true {
                return true
            }
            if Utils.check(forEmpty: linkedInProfile.positionTitle){
                return false
            }else if Utils.check(forEmpty: linkedInProfile.location){
                return false
            }else if Utils.check(forEmpty: linkedInProfile.companyName){
                return false
            }else if Utils.check(forEmpty: linkedInProfile.startDate){
                return false
            }else if Utils.check(forEmpty: linkedInProfile.endDate){
                return false
            }
            return true
        }else{
            return false
        }
    }
    func checkToAddForRequest(linkedInProfile : LinkedInProfile)->Bool{
//        if let linkedInProfile = linkedInArray.last {
            if Utils.check(forEmpty: linkedInProfile.positionTitle){
                return false
            }
//            else if Utils.check(forEmpty: linkedInProfile.location){
//                return false
//            }else if Utils.check(forEmpty: linkedInProfile.companyName){
//                return false
//            }else if Utils.check(forEmpty: linkedInProfile.startDate){
//                return false
//            }else if Utils.check(forEmpty: linkedInProfile.endDate){
//                return false
//            }
            return true
//        }else{
//            return false
//        }
    }
    
    func fillWithProfile(_ data : Any? , isLinkedIn : Bool) -> Bool {
        
        if let param = data as? [String : AnyObject] {
            //           description = "";
            //        email = "kuldeep.butola03@gmail.com";
            //        fname = "Kuldeep Butola";
            //        "is_facebook" = 1;
            //        lname = "";
            //        "mobile_number" = "";
            //        "profile_img" = "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/14702273_10208307974234856_3661244088455871850_n.jpg?oh=ec154c4e5686e432ce134e84c561626f&oe=5970C28B";
            //        "user_id" = 3;
            //            facebook_email
            
            let isFaceBook = param["is_facebook"]?.int16Value == 1
            facebookProfile.email = isFaceBook ? (param["facebook_email"] as? String) : (param["email"] as? String)
            facebookProfile.fullName = param["fname"] as? String
            
            facebookProfile.fbId = param["fb_id_unique"] as? String 
            //            firstName = param["first_name"] as? String
            //            lastName = param["last_name"] as? String
            //            gender = param["gender"] as? String
            //            fbId = param["id"] as? String
            
            
            
            
            let dec =  param["description"] as? String
            if Utils.check(forEmpty: dec) == false{
                facebookProfile.desciptionFB = dec
            }
            
            facebookProfile.profilePic = isFaceBook ? param["facebook_profile_img"] as? String : param["profile_img"] as? String
            //                        self.profileModel.facebookProfile.profilePic = ((param["picture"] as? [String : AnyObject])?["data"] as? [String : AnyObject])?["url"] as? String
            
            
//            facebookProfile.mobile_verified = param["mobile_verified"]?.int16Value == 1
//            let mobileNo = param["mobile_number"] as? String
//            facebookProfile.phoneNumber = mobileNo
//            if facebookProfile.mobile_verified == true {
//                UserDefault.saveVerifiedPhoneNumber(mobileNo)
//            }
            
            facebookProfile.mobile_verified = UserDefault.isMobileNumberVerified()
            facebookProfile.phoneNumber = UserDefault.getVerifiedPhoneNo()
            
            
            
            
            
            
            if let dictArray = param["LinkedinData"] as? [[String : AnyObject]]{
                
                linkedInArray.removeAll()
                for dictLnked in dictArray {
                    let linkedInDta = LinkedInProfile.init()
                    linkedInDta.companyName = dictLnked["company_name"] as? String
                    
                    linkedInDta.id = dictLnked["id"] as? String
                    
                    let lnkLogin = dictLnked["is_linkedin"]?.int16Value == 1
                    linkedInDta.isFromLinkedIn = lnkLogin
                    
                    if lnkLogin == true {
                        isLinkedInActivated = true
                    }
                    
                    
                    linkedInDta.linkedIn_id = dictLnked["li_unique_id"] as? String
                    linkedInDta.location = dictLnked["location"] as? String
                    linkedInDta.positionResponsibility = dictLnked["position_responsibility"] as? String
                    
                    linkedInDta.positionTitle = dictLnked["position_title"] as? String
                    
                    if let isCureentDate = dictLnked["is_current"]?.int8Value , isCureentDate == 1 {
                        linkedInDta.isCurrentlyWorking = true
                        linkedInDta.endDate = "Present"
                    }
                    let format = linkedInDta.isFromLinkedIn == true ? "MMM, yyyy" : "dd MMM, yyyy"
                    
                    if let sDate = dictLnked["start_date"] as? String {
                        linkedInDta.startJobDate = Utils.date(fromStringFormat: "yyyy-MM-dd", dateString: sDate)
                        linkedInDta.startDate = Utils.string(fromDateLocalformat: linkedInDta.startJobDate, format: format)
                    }
                    if linkedInDta.isCurrentlyWorking == false , let eDate = dictLnked["end_date"] as? String {
                        
                        linkedInDta.endJobDate = Utils.date(fromStringFormat: "yyyy-MM-dd", dateString: eDate)
                        linkedInDta.endDate = Utils.string(fromDateLocalformat: linkedInDta.endJobDate, format: format)
                    }

                    
                    
                    linkedInArray.append(linkedInDta)
                    
                    
//                    linkedInDta.endDate = dictLnked["end_date"] as? String
//                    linkedInDta.startDate = dictLnked["start_date"] as? String
                    
                    
                }
                
                if linkedInArray.count == 0 {
                    let lnk = LinkedInProfile.init()
                    lnk.isFromLinkedIn = isLinkedIn
                    linkedInArray.append(lnk)
                }
                
                
            }
//            "company_name" = "";
//            "created_date_time" = "2017-03-29 17:31:26";
//            "end_date" = "0000-00-00";
//            id = 110;
//            "is_current" = 0;
//            "is_linkedin" = 0;
//            "li_unique_id" = "";
//            location = "";
//            "position_responsibility" = "We're qdwqdasddasdsadsa";
//            "position_title" = "kulk jknk non kink kk blink kn jknjk NHL";
//            "start_date" = "0000-00-00";
//            "updated_date_time" = "2017-03-29 17:31:26";
//            "user_id" = 3;
            
            

            
            
            
            return (isFaceBook)
        }
        return false
    }
    
    func removeFillInWithLinkedIn() {
        let datass = linkedInArray
        for vallss in datass {
            if vallss.isFromLinkedIn {
                if let index = linkedInArray.index(of: vallss) {
                    linkedInArray.remove(at: index)
                }
                
            }
        }
        isLinkedInActivated = false
        if linkedInArray.count == 0 {
            linkedInArray.append(LinkedInProfile.init())
        }
    }
    
    func fillWithLinkedInArray(data : [String : AnyObject]){
        var arryof = [LinkedInProfile]()
        if let arrayOfDict = data["positions"]?["values"] as? [[String : AnyObject]] {
            let profile = LinkedInProfile.init()
            for dict in arrayOfDict {

                profile.isFromLinkedIn = true
                profile.companyName = dict["company"]?["name"] as? String
                profile.linkedIn_id = dict["id"] as? String
                
                profile.positionTitle = dict["title"] as? String
                profile.positionResponsibility = dict["summary"] as? String
                profile.location = dict["location"]?["name"] as? String
                
                profile.isCurrentlyWorking = dict["isCurrent"]?.int8Value == 1
                if profile.isCurrentlyWorking == true{
                    profile.endDate = "Present"
                }
                let format = profile.isFromLinkedIn == true ? "MMM, yyyy" : "dd MMM, yyyy"
                
                if let startDate = dict["startDate"] as? [String : AnyObject] {
                    
                    let ddValue = 1
                    var monthValue = 1
                    
                    if let month = startDate["month"]?.int16Value  {
                        monthValue = Int(month)
                    }
                    if let endDate = startDate["year"]?.int16Value{
                       let dateformat = String(format: "%i-%02i-%02i",endDate,monthValue,ddValue)
                        profile.startJobDate = Utils.date(fromStringFormat: "yyyy-MM-dd", dateString: dateformat)
                        
                        
                        profile.startDate = Utils.string(fromDateLocalformat: profile.startJobDate, format: format)
                        
                    }
                }
                
                if profile.isCurrentlyWorking == false , let startDate = dict["endDate"] as? [String : String] {
                    
                    let ddValue = 1
                    var monthValue = 1
                    
                    if let month = startDate["month"] , let mnValue = Int(month) {
                        monthValue = mnValue
                    }
                    if let endDate = startDate["year"]{
                        let dateformat = String(format: "%@-%02i-%02i",endDate,monthValue,ddValue)
                        profile.endJobDate = Utils.date(fromStringFormat: "yyyy-MM-dd", dateString: dateformat)
                        profile.startDate = Utils.string(fromDateLocalformat: profile.endJobDate, format: format)
                        
                    }
                }
                
                
                
                arryof.append(profile)
                
                
                
            }
            
            let datass = linkedInArray
            linkedInArray.removeAll()
            if datass.count > 0 {
                isLinkedInActivated = true
            }
            linkedInArray.append(contentsOf: arryof)
            linkedInArray.append(contentsOf: datass)
            
        }
        
        
        
//        ["industry": Internet, "positions": {
//            "_total" = 1;
//            values =     (
//                {
//                    company =             {
//                        name = "DevelopingNow, Inc.";
//                    };
//                    id = 542930361;
//                    isCurrent = 1;
//                    startDate =             {
//                        month = 3;
//                        year = 2014;
//                    };
//                    summary = "- Lead all mobile app development projects from concept to product launch\n- Form strategic partnerships with media agencies to create new development channels\n- Lead the incubator division with new concepts built around an application/platform environment";
//                    title = "President and CEO";
//                }
//            );
//            }, "id": IhjIVf5gFK, "pictureUrl": https://media.licdn.com/mpr/mprx/0_hTReA0mu61nMMEKAChUBAyg-kAlsJuAAC8fcAy2tUq5w6H6lubIkxpZyExAkswrj3CJnORY52OkM, "numConnections": 297]
        
    }

}

class LinkedInProfile : NSObject {
    
    var positionTitle, location,companyName,startDate,endDate,positionResponsibility , linkedIn_id , id : String?
    var isLastRow : Bool = false
    var isFirstRow : Bool = false
    var isFromLinkedIn : Bool = true
    
    var isCurrentlyWorking : Bool = false
    var startJobDate , endJobDate : Date?
    
    override init() {
        super.init()
    }
}

class FaceBookProfile: NSObject {
    
    var fbId, firstName,lastName,fullName,email,gender,profilePic,phoneNumber,desciptionFB : String?
//    var facebookEmail ,facebookImage : String?
//    var facebookData : Any?
    var mobile_verified : Bool = false
    
    override init() {
        super.init()
    }
    func setEmpty(_ emptyFb : Bool) {
        fbId = ""
        firstName = ""
        lastName = ""
        fullName = ""
        email = emptyFb ? UserDefault.getUserEmailId() : ""
        gender = ""
        profilePic = emptyFb ? UserDefault.getUserProfileImage() : ""
//        phoneNumber = ""
//        desciptionFB = ""
    }
    
    func fillWithFacebook(_ data : Any) {
//        facebookData = data
        if let param = data as? [String : AnyObject] {
            if let pict = param["picture"] as? [String : AnyObject] , let data = pict["data"] as? [String : AnyObject] , let img = data["url"] as? String{
                print("\(pict)")
                profilePic = img
            }
            
            email = param["email"] as? String
            fullName = param["name"] as? String
            firstName = param["first_name"] as? String
            lastName = param["last_name"] as? String
            gender = param["gender"] as? String
            fbId = param["id"] as? String
            //                        self.profileModel.facebookProfile.profilePic = ((param["picture"] as? [String : AnyObject])?["data"] as? [String : AnyObject])?["url"] as? String
            
            
        }
    }
//    if let param = data as? [String : AnyObject] {
//        if let pict = param["picture"] as? [String : AnyObject] , let data = pict["data"] as? [String : AnyObject] , let img = data["url"] as? String{
//            print("\(pict)")
//            self.profileModel.facebookProfile.profilePic = img
//        }
//        
//        self.profileModel.facebookProfile.email = param["email"] as? String
//        self.profileModel.facebookProfile.fullName = param["name"] as? String
//        self.profileModel.facebookProfile.firstName = param["first_name"] as? String
//        self.profileModel.facebookProfile.lastName = param["last_name"] as? String
//        self.profileModel.facebookProfile.gender = param["gender"] as? String
//        self.profileModel.facebookProfile.fbId = param["id"] as? String
//        //                        self.profileModel.facebookProfile.profilePic = ((param["picture"] as? [String : AnyObject])?["data"] as? [String : AnyObject])?["url"] as? String
//        
//        self.profileModel.isFacebookActivated = true
//    }

//    public required init?(map: Map) {
//
//    }
//    func mapping(map: Map) {
//        //        message <- map["status"]
//        //        offset <- map["offset"]
//        //        jobsArray <- map["response.jobs"]
//    }
}

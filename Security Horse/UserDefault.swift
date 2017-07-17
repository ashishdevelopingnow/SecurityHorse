//
//  UserDefault.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 17/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class UserDefault: NSObject {

    struct NOTIFICATION {
        static let Applied_Job = "userappliedForTheJob"
//        static let USER_EMAIL = "userDefaultEmailId"
    }
    struct USER_DEFAULT {
        static let USER_INFO = "userDefaultUsersInformation"
        static let USER_EMAIL = "userDefaultEmailId"
        static let CONNECTED_TO_FACEBOOK = "connectedToFaceBook"
        static let FACEBOOK_DATA = "facebookdata"
        
        static let LICENCE_IMAGE = "licenceImage"
        
        static let VERIFIED_MOBILE_NO = "userdefaultVarifiedMobileNo"
        static let IS_VERIFIED_MOBILE_NO = "userdefaultismobilenumberVerified"
    }
    //MARK: - SignOu
    static func signOut(){
        saveUserInfo(nil)
        connectedToFB(false)
        saveFbData(nil)
        saveLicenceImage(nil)
        
        saveVerifiedMobileNumber(nil)
        saveMobileNumberVerified(false)
    }
    
    //MARK: - User details
    static func saveUserInfo(_ data : [String : AnyObject]?) {

        if let param = data {
            let mobileNo = param["mobile_number"] as? String
            
            let verified = param["mobile_verified"]?.int16Value == 1
            
            if let securitLicence = param["security_license"] as? String  {
                UserDefault.saveLicenceImage(securitLicence)
            }
            
            self.saveVerifiedMobileNumber(mobileNo)
            self.saveMobileNumberVerified(verified)
            
        }
        
        
        Utils.saveData(toUserDefault: data, key: USER_DEFAULT.USER_INFO)
    }
    static func getUserInfo() -> Any? {
        return Utils.dataFromUserDefault(forKey: USER_DEFAULT.USER_INFO)
    }
    static func getUserEmailId() -> String? {
        if let dict = Utils.dataFromUserDefault(forKey: USER_DEFAULT.USER_INFO) as? [String : AnyObject] , let email = dict["email"] as? String {
            return email
        }
        
        return nil
    }
    static func getUserId() -> String? {
        if let dict = Utils.dataFromUserDefault(forKey: USER_DEFAULT.USER_INFO) as? [String : AnyObject] , let email = dict["id"] as? String {
            return email
        }
        if let dict = Utils.dataFromUserDefault(forKey: USER_DEFAULT.USER_INFO) as? [String : AnyObject] , let email = dict["user_id"] as? String {
            return email
        }
        
        return nil
    }
    static func getUserProfileImage() -> String? {
        if let dict = Utils.dataFromUserDefault(forKey: USER_DEFAULT.USER_INFO) as? [String : AnyObject] , let email = dict["profile_img"] as? String {
            return email
        }
//        if let dict = Utils.dataFromUserDefault(forKey: USER_DEFAULT.USER_INFO) as? [String : AnyObject] , let email = dict["user_id"] as? String {
//            return email
//        }
        
        return nil
    }

    
    //MARK: FB
    static func connectedToFacebook() -> Bool {
        if (Utils.dataFromUserDefault(forKey: USER_DEFAULT.CONNECTED_TO_FACEBOOK) != nil) {
            return true
        }
        
        return false
    }
    static func connectedToFB (_ isConnected : Bool){
        Utils.saveData(toUserDefault: isConnected ? "Y" : nil, key: USER_DEFAULT.USER_INFO)
    }
    static func saveFbData(_ data : [String : AnyObject]?) {
        Utils.saveData(toUserDefault: data, key: USER_DEFAULT.FACEBOOK_DATA)
    }
    static func getFbData(_ data : [String : AnyObject]?) -> Any? {
        return Utils.dataFromUserDefault(forKey: USER_DEFAULT.FACEBOOK_DATA)
    }
    
    static func getLicenceImage() -> String? {
        return Utils.dataFromUserDefault(forKey: USER_DEFAULT.LICENCE_IMAGE) as? String
    }
    static func saveLicenceImage(_ data : String?) {
        
        Utils.saveData(toUserDefault: data, key: USER_DEFAULT.LICENCE_IMAGE)
    }

    
    //MARK: User data
    static func saveUserProfileDetails(_ fullName : String? , email : String? ,phonenumber : String? , details : String?){
        
    }
    
    static func saveVerifiedMobileNumber (_ string : String?){
        Utils.saveData(toUserDefault: string, key: USER_DEFAULT.VERIFIED_MOBILE_NO)
    }
    static func getVerifiedPhoneNo() -> String? {
        return Utils.dataFromUserDefault(forKey: USER_DEFAULT.VERIFIED_MOBILE_NO) as? String
    }
    static func saveMobileNumberVerified (_ string : Bool){
        if string == true {
            Utils.saveData(toUserDefault: "Y", key: USER_DEFAULT.IS_VERIFIED_MOBILE_NO)
        }else{
            Utils.saveData(toUserDefault: nil, key: USER_DEFAULT.IS_VERIFIED_MOBILE_NO)
        }
        
    }
    static func isMobileNumberVerified() -> Bool {
        if let data =  Utils.dataFromUserDefault(forKey: USER_DEFAULT.IS_VERIFIED_MOBILE_NO) as? String, data == "Y"{
            return true
        }
        return false
    }
    
}

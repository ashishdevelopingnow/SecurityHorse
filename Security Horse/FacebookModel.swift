//
//  FacebookModel.swift
//  Security Horse
//
//  Created by Rahul Sharma on 22/02/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit
class FacebookModel: NSObject {

    static func getDataFromFB (_ viewController : UIViewController,completed : @escaping (AnyObject)->Void){
     
        let facebookReadPermissions = ["public_profile", "email", "user_friends"]
        let login = FBSDKLoginManager.init()
        login.logIn(withReadPermissions: facebookReadPermissions, from: viewController) { (result, error) in
            if error == nil {
                self.fetchData(completed: completed)
            }
            
        }
    
    
        
    }
        
    static func fetchData(completed :@escaping (AnyObject)->Void) {
        let parameters = ["fields" : "id, name, first_name, last_name, picture.type(large), email , work,gender,about"]
        
        FBSDKGraphRequest.init(graphPath: "me", parameters: parameters).start { (connection, object, error) in
            if let obj = object as? NSDictionary {
                completed(obj as AnyObject)
            }
            
        }
        
//        FBSDKGraphRequest.init(graphPath: "me", parameters: parameters).start { (connection, object, error) in
//        
//            
////            NSLog("fetched user:%@  and Email : %@", result,result["email"]);
//        }

        

    }
    
}

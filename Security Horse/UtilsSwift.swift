//
//  UtilsSwift.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 10/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class UtilsSwift: NSObject {

    static func changeToPhoneNumberFormat (string : String) -> String  {
        var str = string
        str = str.replacingOccurrences(of: ")", with: "")
        str = str.replacingOccurrences(of: "(", with: "")
        str = str.replacingOccurrences(of: "-", with: "")
        str = str.replacingOccurrences(of: " ", with: "")
        
       
        
        return str
        
    }
    static func changeToPhoneFormat (string : String) -> String  {
        
        var str = string
        str = str.replacingOccurrences(of: ")", with: "")
        str = str.replacingOccurrences(of: "(", with: "")
        str = str.replacingOccurrences(of: "-", with: "")
        str = str.replacingOccurrences(of: " ", with: "")
        
        let stringts : NSMutableString = NSMutableString.init(string: str)
        
        
        
        
        if stringts.length > 0 {
            stringts.insert("(", at: 0)
        }
        
        if stringts.length > 4 {
            stringts.insert(")", at: 4)
        }
        
        if stringts.length > 5 {
            stringts.insert(" ", at: 5)
        }
        if stringts.length > 9 {
            stringts.insert("-", at: 9)
        }
        
        //        stringts.insert(")", at: 4)
        //
        //        stringts.insert("-", at: 5)
        //
        //        stringts.insert("-", at: 9)
        
        return stringts as String
        
    }
    
    static func date(fromString dateString : String , format : String) -> Date? {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        let d = dateformat.date(from: dateString)
        return d 
    }
    static func addInitilaText(_ textField : UITextField , initaltext : String , initalTextColor : UIColor){
        let label = UILabel.init()
        label.text = initaltext
        label.font = textField.font
        label.textColor = initalTextColor
        label.sizeToFit()
        var frame = label.frame
        frame.size.width += 10
        label.frame = frame
        
        textField.leftViewMode = .always
        textField.leftView = label
        textField.placeholder = ""
        
        let color = UIColor.lightGray
        self.addBorderTextFeild(textField, borderColor: color)
    }
    static func addBorderTextFeild(_ textFeild : UITextField , borderColor : UIColor){
        
        let label = UILabel.init()
        label.text = "- "
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = borderColor
        label.sizeToFit()
        let image = imageWithLabel(label: label)!
        
        
        let border = CALayer()
        let width =  CGFloat((label.frame.size.width/1.5))
        border.borderColor = UIColor.init(patternImage: image).cgColor// UIColor(patt:) .darkGray.cgColor
        let y = textFeild.frame.size.height - width
        border.frame = CGRect(x: 0, y: y, width:  textFeild.frame.size.width, height: width)
        
        border.borderWidth = width
        textFeild.layer.addSublayer(border)
        textFeild.layer.masksToBounds = true
        

    }
    
    static func imageWithLabel(label: UILabel) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    static func remainingDateLeft(date : Date) -> String {
     
        var leftDays = date.timeIntervalSinceNow
        if leftDays < 0{
            leftDays = (-1 * leftDays)
        }
//        if leftDays < 60 {
//            return "few seconds ago"
//        }
//        
        let mints = leftDays/60
//        
//        if mints < 60 {
//            return "\(Int(mints)) min ago"
//        }
//        
        let hrs = mints/60
//        if hrs < 24 {
//            return "\(Int(hrs)) hrs ago"
//        }
        if hrs < 24 {
            return "Posted today"
        }
        
        let days = hrs/24
        let dayss = Int(days)
        
        if dayss == 1 {
            return "\(Int(days)) day ago"
        }
        return "\(Int(days)) days ago"
    }
    
    static func showAlertWithMessage(_ message : String? ,_ title : String? ) {
        
//        Utils.showAlert(withMessage: message, andTitle: title)
        
        let fcAlert = FCAlertView.init()
        let image = UIImage(named: "logoSmall")
        fcAlert.showAlert(inView: ((UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).visibleViewController)!, withTitle: title != nil ? title! : APP_NAME, withSubtitle: message != nil ? message! : "" , withCustomImage: image, withDoneButtonTitle: "OK", andButtons: nil)
        
        
    }
    static func showNetworkError () {
        self.showAlertWithMessage("Please check your network and try again", nil)
    }
}

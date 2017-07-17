//
//  CustomTextView.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 14/04/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        setKeyBoardDone()
    }
    
    func setKeyBoardDone(){
        let numberToolbar: UIToolbar = UIToolbar()
        
        let barItiem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CustomTextView.doneBttnTapped(_:)))
        barItiem.tintColor = Constants.APP_TEXT_COLOR
        
        numberToolbar.barStyle = UIBarStyle.default
        numberToolbar.items=[
            //            UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: "hoopla"),
            
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            barItiem
            
        ]
        
//        numberToolbar.barTintColor = UIColor.white
        
        numberToolbar.sizeToFit()
        
        self.inputAccessoryView = numberToolbar
    }
    
    func doneBttnTapped(_ sender : Any){
        self.resignFirstResponder()
    }
}

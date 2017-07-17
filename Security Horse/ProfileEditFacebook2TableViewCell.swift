//
//  ProfileEditFacebook2TableViewCell.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 29/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class ProfileEditFacebook2TableViewCell: ProfileEditFacebookTableViewCell {

    
    
    @IBOutlet weak var lblPostionDesc: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(object: AnyObject?, callBack: ((_ action : TAPPED_VALUE , _ object : AnyObject?) -> Void)?) {
        super.setData(object: object, callBack: callBack)
        
        lblPostionDesc.textColor = Constants.APP_TEXT_COLOR
        lblPostionDesc.text = "tell us about yourself"
        //        bttnLinkdin.setTitleColor( Constants.APP_TEXT_COLOR, for: .normal)
        
        let color = Constants.APP_TEXT_COLOR
        UtilsSwift.addBorderTextFeild(txtPhoneNumber, borderColor: color)
        UtilsSwift.addBorderTextFeild(txtEmail, borderColor: color)
        UtilsSwift.addBorderTextFeild(txtName, borderColor: color)
        
        //        self.layoutIfNeeded()
        UtilsSwift.addInitilaText(txtEmail, initaltext: "email", initalTextColor: Constants.APP_TEXT_COLOR)
        UtilsSwift.addInitilaText(txtName, initaltext: "full name", initalTextColor: Constants.APP_TEXT_COLOR)
//        UtilsSwift.addInitilaText(txtCompanyName, initaltext: "last name", initalTextColor: Constants.APP_TEXT_COLOR)
        UtilsSwift.addInitilaText(txtPhoneNumber, initaltext: "phone number", initalTextColor: Constants.APP_TEXT_COLOR)
        
    }    
}

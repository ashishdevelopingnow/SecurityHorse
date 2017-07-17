//
//  SettingsTableViewCell.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 03/02/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class SettingsTableViewCell: BaseSettingsTableViewCell {

    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var switchSettings: UISwitch!
    
//    weak var settingData : Any?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func settingsData(_ object: Any) {
        txtTitle.isUserInteractionEnabled = false
        
        guard let obj = object as? [Any],let titleSring = obj[0] as? String,let switchState = obj[1] as? Bool else {
            UtilsSwift.addInitilaText(txtTitle, initaltext: "", initalTextColor: Constants.APP_TEXT_COLOR)
            return
        }
        
        UtilsSwift.addInitilaText(txtTitle, initaltext: titleSring, initalTextColor: Constants.APP_TEXT_COLOR)
        switchSettings.setOn(switchState, animated: true)
        
    }
    
    @IBAction func switchedTapped(_ sender: Any) {
    }
    
    

}

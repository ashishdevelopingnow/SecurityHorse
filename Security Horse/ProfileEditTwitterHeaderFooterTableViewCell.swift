//
//  ProfileEditTwitterHeaderFooterTableViewCell.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 21/03/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class ProfileEditTwitterHeaderFooterTableViewCell: BaseMyProfileTableViewCell {

    @IBOutlet weak var bttnLinkedin: UIButton?
    
    @IBOutlet weak var bttnDisconnectLinkedin: UIButton?
    
    weak var profileDetail : Profile?
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
        profileDetail = object as? Profile
        
        bttnDisconnectLinkedin?.layer.cornerRadius = 2
        bttnDisconnectLinkedin?.layer.masksToBounds = true
        
        if let conntLinkD = profileDetail?.isLinkedInActivated{
            bttnLinkedin?.isHidden = conntLinkD
            bttnDisconnectLinkedin?.isHidden = !conntLinkD
        }
        
        
    }
    @IBOutlet weak var addAnotherPosition: UIButton!

    @IBAction func addAnotherPositionTapped(_ sender: Any) {
        if profileDetail?.checkToAddNewPosition() == true {
            self.completion?(TAPPED_VALUE.LINKED_IN_ADD,profileDetail)
        }else{
            
            UtilsSwift.showAlertWithMessage("Please enter all the text", Constants.APP_NAME)
//            Utils.showAlert(withMessage: "Please enter all the text", andTitle: Constants.APP_NAME)
        }
        
    }
    
    @IBAction func connectLinkedIn(_ sender: Any) {
        self.completion?(TAPPED_VALUE.CONNECT_LINKEDIN,profileDetail)
    }
    @IBAction func disConnectLinkedIn(_ sender: Any) {
        self.completion?(TAPPED_VALUE.DISCONNECTED_LINKEDIN,profileDetail)
    }

    
}

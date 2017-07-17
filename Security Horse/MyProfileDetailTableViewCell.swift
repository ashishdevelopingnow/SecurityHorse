//
//  MyProfileDetailTableViewCell.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 24/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class MyProfileDetailTableViewCell: BaseMyProfileTableViewCell {

    @IBOutlet weak var nameConstrain: NSLayoutConstraint!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var fbImageView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblEmailId: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    
    @IBOutlet weak var profileVerified: UIImageView!
    
    
    @IBOutlet weak var lblVerifed: UILabel!
    weak var profile : Profile?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
//          myProfileDetail
    }
    override func setData(object: AnyObject?, callBack: ((_ action : TAPPED_VALUE , _ object : AnyObject?) -> Void)?) {
        super.setData(object: object, callBack: callBack)
        
        logoImageView.layer.cornerRadius = 50.0
        logoImageView.layer.borderColor = UIColor(colorLiteralRed: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1).cgColor
        logoImageView.layer.borderWidth = 0.5
        logoImageView.layer.masksToBounds = true
        logoImageView.contentMode = .center
//        logoImageView
//        logoSmall
//        facebookImage
        fbImageView.isHidden = true
        lblUserName.text = ""
        lblMobile.text = ""
        lblDetail.text = ""
        
        let valuedforverifed = !UserDefault.isMobileNumberVerified()
        profileVerified.isHidden = valuedforverifed
        lblVerifed.isHidden = valuedforverifed
        
        let userInfo = UserDefault.getUserInfo()
        
//        let profileDetail = Profile.init()
//        let fbActive = profileDetail.facebookProfile.fillWithProfile(userInfo)
//        profileDetail.isFacebookActivated = fbActive
        let profileDetail = object as! Profile
        profile = profileDetail
        
        if userInfo != nil {
            var rating = 0
            rating = rating + (profileDetail.isFacebookActivated ? 1 : 0)
            rating = rating + (profileDetail.isFacebookActivated ? 1 : 0)
            rating = rating + (UserDefault.isMobileNumberVerified() ? 1 : 0)
            if rating == 0 {
                rating = 1
            }
            self.setImageSelection(number: rating)
        }else{
            self.setImageSelection(number: 5)
        }
        
        
        let fbActive = profileDetail.isFacebookActivated
        fbImageView.isHidden = !fbActive
        
        nameConstrain.constant = (fbActive == true) ? 51 : 26
        
        lblUserName.text = Utils .check(forEmpty: profileDetail.facebookProfile.fullName) == true ? "Full Name" : profileDetail.facebookProfile.fullName
        
        lblMobile.text = UtilsSwift.changeToPhoneFormat(string:profileDetail.facebookProfile.phoneNumber ?? "")
        
        lblEmailId.text = profileDetail.facebookProfile.email
        
        lblDetail.text = profileDetail.facebookProfile.desciptionFB
        let imagePlace = UIImage(named: "logoSmall")
        if let imageStr = profileDetail.facebookProfile.profilePic ,  let imageURL = NSURL.init(string: imageStr) {
            
            
            logoImageView.af_setImage(withURL: imageURL as URL, placeholderImage: imagePlace, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false, completion:
                { (imagesss) in
//                    imagesss.data
                    if (imagesss.result.value != nil) {
                        self.logoImageView.contentMode = .scaleToFill
                    }
                
            })
            
            
//
        }else{
            logoImageView.image = imagePlace
        }
//        if let emailId = UserDefault.getUserEmailId(){
//            lblEmailId.text = emailId
//        }else{
//            //            lblEmail.text = " "
//        }
        
//        lblDetail.text = "I am an experienced bouncer who has held several position in the Tri-State area. I have worked for bars, stores, as well as private events. I know all the correct protocals, and I an very committed to which ever role I an working in."
    }
    
    func setImageSelection (number : Int){
        let imageSelected = #imageLiteral(resourceName: "starSelected")
        setInitialImage()
        switch number {
        case 1:
            star1.image = imageSelected
            //            starImageView2.image = imageSelected
            //            starImageView3.image = imageSelected
            //            starImageView4.image = imageSelected
        //            starImageView5.image = imageSelected
        case 2:
            star1.image = imageSelected
            star2.image = imageSelected
            //            starImageView3.image = imageSelected
            //            starImageView4.image = imageSelected
        //            starImageView5.image = imageSelected
        case 3:
            star1.image = imageSelected
            star2.image = imageSelected
            star3.image = imageSelected
            //            starImageView4.image = imageSelected
        //            starImageView5.image = imageSelected
        case 4:
            star1.image = imageSelected
            star2.image = imageSelected
            star3.image = imageSelected
            star4.image = imageSelected
        //            starImageView5.image = imageSelected
        case 5:
            star1.image = imageSelected
            star2.image = imageSelected
            star3.image = imageSelected
            star4.image = imageSelected
            star5.image = imageSelected
        default:
            break
        }
        
        
    }
    func setInitialImage(){
        let imageUnselected = #imageLiteral(resourceName: "starUnSelected")
        star1.image = imageUnselected
        star2.image = imageUnselected
        star3.image = imageUnselected
        star4.image = imageUnselected
        star5.image = imageUnselected
        
    }
//    }
//    override func setData(object: AnyObject?, callBack: ((.UPLOAD_PHOTO) -> Void)?) {
    

}

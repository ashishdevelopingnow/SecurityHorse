//
//  ProfileEditFacebookTableViewCell.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 24/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class ProfileEditFacebookTableViewCell: BaseMyProfileTableViewCell , UITextViewDelegate{
    @IBOutlet weak var bttnFacebook: UIButton!
    @IBOutlet weak var imageViewFb: UIImageView!

    @IBOutlet weak var bttnCancelFB: UIButton!
    @IBOutlet weak var bgViewTxtDesc: UIView!
    @IBOutlet weak var bttnUplaodPhoto: UIButton!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var mobileVerified: UIImageView?
    
    weak var profileDetail : Profile?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func setData(object: AnyObject?, callBack: ((TAPPED_VALUE,AnyObject?) -> Void)?) {
        super.setData(object: object, callBack: callBack)
    
        bttnCancelFB.layer.cornerRadius = 2
        bttnCancelFB.layer.masksToBounds = true
        
        bgViewTxtDesc.backgroundColor = UIColor.white
        bgViewTxtDesc.layer.shadowOpacity = 0.7
        bgViewTxtDesc.layer.shadowOffset = CGSize.zero
        bgViewTxtDesc.layer.shadowRadius = 5.0
        bgViewTxtDesc.layer.shadowColor = UIColor.gray.cgColor
        
//        imageViewFb
        imageViewFb.layer.cornerRadius = 50
        imageViewFb.layer.masksToBounds = true
//        bttnUplaodPhoto.layer.cornerRadius = 50
//        bttnUplaodPhoto.layer.masksToBounds = true
//        bttnUplaodPhoto.af
        let color = UIColor.lightGray
        UtilsSwift.addBorderTextFeild(txtPhoneNumber, borderColor: color)
        UtilsSwift.addBorderTextFeild(txtEmail, borderColor: color)
        UtilsSwift.addBorderTextFeild(txtName, borderColor: color)
        
        txtPhoneNumber.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: UIControlEvents.editingDidEnd)
        txtEmail.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: UIControlEvents.editingDidEnd)
        txtName.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: UIControlEvents.editingDidEnd)
        
        txtDescription.delegate = self
//        txtDescription.addTarget(self, action: #selector(textViewDidChanged(_:)), for: UIControlEvents.editingDidEnd)
        if let fbObj = object as? Profile {
            profileDetail = fbObj
            
        }
        
        
        setUI()
        
    }
    func setUI(){
        txtPhoneNumber.text = ""
        txtEmail.text = ""
        txtName.text = ""
        txtDescription.text = ""
        imageViewFb.contentMode = .center
        
        mobileVerified?.isHidden = !UserDefault.isMobileNumberVerified()
//        bttnUplaodPhoto.contentHorizontalAlignment = .fill
//        bttnUplaodPhoto.contentVerticalAlignment = .fill
         let placeHoled =  UIImage(named: "uploadPhoto")
        if let profile = profileDetail {
            
            txtEmail.isUserInteractionEnabled = false
            
            txtPhoneNumber.text = profileDetail?.facebookProfile.phoneNumber
            txtEmail.text = profileDetail?.facebookProfile.email
            txtName.text = profileDetail?.facebookProfile.fullName
            txtDescription.text = profileDetail?.facebookProfile.desciptionFB
            
            txtPhoneNumber.isUserInteractionEnabled = true
//                !profile.isFacebookActivated
//            txtEmail.isUserInteractionEnabled = !profile.isFacebookActivated
            txtName.isUserInteractionEnabled = !profile.isFacebookActivated
//            bgViewTxtDesc.isUserInteractionEnabled = !profile.isFacebookActivated
            bttnUplaodPhoto.isUserInteractionEnabled = !profile.isFacebookActivated
            
            bttnCancelFB.isHidden = !profile.isFacebookActivated
            bttnFacebook.isHidden = profile.isFacebookActivated
            
           
            if let imageStr = profileDetail?.facebookProfile.profilePic, let imageURL = NSURL.init(string: imageStr) {
                
                imageViewFb.af_setImage(withURL: imageURL as URL, placeholderImage: placeHoled, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: true, completion: {(imm) in
                    self.imageViewFb.contentMode = .scaleToFill
                })
//                bttnUplaodPhoto.af_setImage(for: .normal, url: imageURL as URL, , filter: nil, progress: nil, progressQueue: DispatchQueue.main, completion: nil)
            }else{
//                bttnUplaodPhoto.setImage(UIImage(named: "uploadPhoto")!, for: .normal)
                imageViewFb.image = placeHoled
                imageViewFb.contentMode = .center
            }
        }else{
            imageViewFb.image = placeHoled
            imageViewFb.contentMode = .center
//             bttnUplaodPhoto.setImage(UIImage(named: "uploadPhoto")!, for: .normal)
        }
        
        
    }
    
    //MARK:
    @IBAction func cancelFBTapped(_ sender: Any) {
        profileDetail?.facebookProfile.setEmpty(true)
        profileDetail?.isFacebookActivated = false
        bttnCancelFB.isHidden = false
        bttnFacebook.isHidden = true
        
        
        
        
        setUI()
        
    }
    @IBAction func fillFacebookTapped(_ sender: Any) {
        profileDetail?.facebookProfile.setEmpty(false)
        self.completion?(TAPPED_VALUE.FB_TAPPED,profileDetail)
    }
    
    @IBAction func uploadPhotoTapped(_ sender: Any) {
        self.completion?(TAPPED_VALUE.UPLOAD_PHOTO,profileDetail)
    }
    
    @IBAction func facebookFillTapped(_ sender: Any) {
    }
    
//    @available(iOS 10.0, *)
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textView text is ::::::::  \(textView.text)")
        profileDetail?.facebookProfile.desciptionFB = textView.text
    }
    
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        
//    }
    func textfieldDidChanged(_ sender : UITextField) {
        print("writen text is ::::::::  \(sender.text)")
        if sender == txtName {
            profileDetail?.facebookProfile.fullName = sender.text
        }else if sender == txtEmail {
            profileDetail?.facebookProfile.email = sender.text
        }else if sender == txtPhoneNumber {
            
           profileDetail?.facebookProfile.phoneNumber = UtilsSwift.changeToPhoneNumberFormat(string: sender.text ?? "")
        }
        
        txtEmail.text = profileDetail?.facebookProfile.email
        txtName.text = profileDetail?.facebookProfile.fullName
    }
//    func textViewDidChanged(_ sender : UITextField) {
//        print("abc text is ::::::::  \(sender.text)")
//        profileDetail?.facebookProfile.desciptionFB = sender.text
//    }

//    @IBAction override func uploadPhotoTapped(_ sender: Any) {
//    }
    
    
}

//
//  ProfileEditImageTableViewCell.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 01/04/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class ProfileEditImageTableViewCell: BaseMyProfileTableViewCell {

    @IBOutlet weak var headerInfo: UILabel!
    @IBOutlet weak var licenceImage: UIImageView!
    
    @IBOutlet weak var bgViewUpload: UIView!
    @IBOutlet weak var bgViewImage: UIView!
    @IBOutlet weak var crossBttnTapped: UIButton!
    
    weak var profile : Profile?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(object: AnyObject?, callBack: ((TAPPED_VALUE, AnyObject?) -> Void)?) {
        super.setData(object: object, callBack: callBack)
        
        profile = object as? Profile
        setUI()
    }
    func setUI () {
        bgViewUpload.backgroundColor = UIColor.clear
        bgViewImage.backgroundColor = UIColor.clear
        
        setLayer(bgViewUpload)
        setLayer(licenceImage)
        
//        licenceImage.backgroundColor = UIColor.red
        if let img = profile?.tempImg {//  {
            bgViewUpload.isHidden = true
            bgViewImage.isHidden = false
            licenceImage.image = img
        }else if let str = UserDefault.getLicenceImage() , let url = NSURL(string: str) as? URL{
            bgViewUpload.isHidden = true
            bgViewImage.isHidden = false
            
            licenceImage.af_setImage(withURL: url)
        }
        else{
            bgViewUpload.isHidden = false
            bgViewImage.isHidden = true
        }
        
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
        completion?(.UPLOAD_IMAGE_LICENCE,nil)
        
    }
    
    
    @IBAction func cancelBttnTapped(_ sender: Any) {
        UserDefault.saveLicenceImage(nil)
        profile?.tempImg = nil
        setUI()
    }

    func setLayer (_ bgViewPostionDesc : UIView){
        bgViewPostionDesc.backgroundColor = UIColor.white
        bgViewPostionDesc.layer.shadowOpacity = 0.7
        bgViewPostionDesc.layer.shadowOffset = CGSize.zero
        bgViewPostionDesc.layer.shadowRadius = 5.0
        bgViewPostionDesc.layer.shadowColor = UIColor.gray.cgColor
    }
}

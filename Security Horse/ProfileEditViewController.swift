//
//  ProfileEditViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 24/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class ProfileEditViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate ,FCAlertViewDelegate{

    @IBOutlet weak var tableView : UITableView!
    var profileModel = Profile.init()
//    var callback : CallBack?
    func alertView(alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title:String){
//        if index == 1 {
//            self.verifyMobileNo(profileModel.facebookProfile.phoneNumber)
//        }else{
            _ = self.navigationController?.popViewController(animated: true)
            
//        }
    }
    func FCAlertDoneButtonClicked(alertView: FCAlertView){
        self.verifyMobileNo(profileModel.facebookProfile.phoneNumber)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileModel.initWithLinkedIn(false)
//        let fbActive = profileModel.fillWithProfile(UserDefault.getUserInfo())
        let fbActive = profileModel.fillWithProfile((UserDefault.getUserInfo()), isLinkedIn: false)
        profileModel.isFacebookActivated = fbActive
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0

        let nib = UINib(nibName: "ProfileEditFacebookTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "facebookEdit")
        
        let nib2 = UINib(nibName: "ProfileEditTwitter1TableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "linkedInEdit1")
        let nib3 = UINib(nibName: "ProfileEditTwitter2TableViewCell", bundle: nil)
        tableView.register(nib3, forCellReuseIdentifier: "linkedInEditx")
        let nib4 = UINib(nibName: "ProfileEditTwitter3TableViewCell", bundle: nil)
        tableView.register(nib4, forCellReuseIdentifier: "linkedInEdit0")
        
        let nib5 = UINib(nibName: "ProfileEditTwitter4TableViewCell", bundle: nil)
        tableView.register(nib5, forCellReuseIdentifier: "linkedInEdit4")
        
        
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveBttnTapped (_ sender : UIButton){
//        sadadsasddadas
        self.view.endEditing(true)
        self.showHudWithMessage("")
        RequestClass.editProfile(userId: UserDefault.getUserId()!, jobprofile: profileModel) { (an, ee, vv) in
            self.hideHud()
            if vv {
                self.validateAlert()
                
            }
        }
    }
    
    func validateAlert() {
//        qwe
        let profileModel2 = Profile.init()
        profileModel2.initWithLinkedIn(false)
        
        let fbActive = profileModel2.fillWithProfile((UserDefault.getUserInfo()), isLinkedIn: false)
        profileModel2.isFacebookActivated = fbActive
        
        if profileModel2.facebookProfile.mobile_verified == false, !Utils.check(forEmpty: profileModel2.facebookProfile.phoneNumber) {
            
            let fcAlert = FCAlertView.init()
            let image = UIImage(named: "logoSmall")
            
            fcAlert.delegate = self
            
            fcAlert.showAlert(inView: (UIApplication.shared.keyWindow?.rootViewController)!, withTitle: Constants.TITLE_MOBILE_VERIFY, withSubtitle: Constants.SUB_TITLE_MOBILE_VERIFY , withCustomImage: image, withDoneButtonTitle:"Verify" , andButtons: ["Not Now"])
            
//            let alert = UIAlertController(title: Constants.TITLE_MOBILE_VERIFY, message: Constants.SUB_TITLE_MOBILE_VERIFY, preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "Not Now", style: UIAlertActionStyle.cancel, handler:{ (ACTION :UIAlertAction!)in
//                
//                _ = self.navigationController?.popViewController(animated: true)
//            }))
//            alert.addAction(UIAlertAction(title: "Verify", style: UIAlertActionStyle.default, handler:{ (ACTION :UIAlertAction!)in
//                
//                self.verifyMobileNo(profileModel2.facebookProfile.phoneNumber)
//                
//                
//            }))
//            self.present(alert, animated: true, completion: nil)
        }else{
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    func verifyMobileNo (_ string : String?) {
        if let text = string , let userID = UserDefault.getUserId() {
            //            self.showHudWithMessage("")
            RequestClass.saveMobileNumber(text, user_id: userID, result: { (obc, err, done) in
                self.hideHud()
                //                if done {
                
                //                }
            })
            self.performSegue(withIdentifier: "verifySMS", sender: text)
        }
    }
    
    // MARK: - UiTableView methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 385
        }else if indexPath.section == 1 {
            return 110
        }else if indexPath.section == 2 {
            return 378
        }else if indexPath.section == 3 {
            return 59
        }
        else{
            return 300
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 2 {
            return profileModel.linkedInArray.count
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var identifier = "linkedInEdit"
        if indexPath.section == 0 {
            identifier = "facebookEdit"
        }else if indexPath.section == 1 {
            identifier = "linkedInEdit0"

        }else if indexPath.section == 2 {
            identifier = "linkedInEdit1"
 
        }else if indexPath.section == 4 {
            identifier = "linkedInEdit4"
            
        }
        else {
            identifier = "linkedInEditx"

        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! BaseMyProfileTableViewCell
        cell.selectionStyle = .none
        
        if indexPath.section == 2{
            let data = profileModel.linkedInArray[indexPath.row]
            data.isLastRow = profileModel.linkedInArray.count - 1 == indexPath.row
            data.isFirstRow = indexPath.row == 0
            cell.setData(object: data, callBack: { (value , object) in
                if value == .LINKED_IN_DELETE , let ob = object as? LinkedInProfile {
                    
                    let aa = (self.profileModel.linkedInArray as NSArray).index(of: ob)
                    self.profileModel.linkedInArray.remove(at: aa)
//                    self.profileModel.linkedInArray.append(LinkedInProfile.init())
                    self.tableView.reloadData()
                    
                }else if value == .START_DATE , let ob = object as? LinkedInProfile{
                    
                    let viewCnt = self.storyboard?.instantiateViewController(withIdentifier: "DateMonthViewController") as! DateMonthViewController
                    self.present(viewCnt, animated: true, completion: { 
                        
                    })
                    viewCnt.callBack = { (currntdate) in
                        ob.startJobDate = currntdate
                        let format = ob.isFromLinkedIn == true ? "MMM, yyyy" : "dd MMM, yyyy"
                        ob.startDate = Utils.string(fromDateLocalformat: currntdate, format: format)
                        self.tableView.reloadData()
                    }
                    
                }else if value == .END_DATE , let ob = object as? LinkedInProfile{
                    let viewCnt = self.storyboard?.instantiateViewController(withIdentifier: "DateMonthViewController") as! DateMonthViewController
                    self.present(viewCnt, animated: true, completion: {
                        
                    })
                    viewCnt.callBack = { (currntdate) in
                        ob.endJobDate = currntdate
                        let format = ob.isFromLinkedIn == true ? "MMM, yyyy" : "dd MMM, yyyy"
                        ob.endDate = Utils.string(fromDateLocalformat: currntdate, format: format)
                        self.tableView.reloadData()
                    }
                }
            })
        }else{
            
            cell.setData(object: profileModel) { (value , object) in
                if value == .UPLOAD_PHOTO {
                    self.pickImageView({ (image) in
                        self.profileModel.facebookProfile.profilePic = image
                        self.tableView.reloadData()
                    } , nil)
                }else if value == .FB_TAPPED {
                    //                if UserDefault.getUserEmailId() == nil {
                    //                    self.performSegue(withIdentifier: "signIn", sender: nil)
                    //                }else{
                    self.fillWithFaceBook()
                    
                    //                }
                }else if value == .CONNECT_LINKEDIN {
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                    self.present(vc, animated: true, completion: {
                        
                    })
                    vc.completion = { (datstss) in
                        self.profileModel.fillWithLinkedInArray(data: datstss)
                        self.tableView.reloadData()
                    }
                    
                   
                    
                }else if value == .DISCONNECTED_LINKEDIN {
                
                    
                    self.profileModel.removeFillInWithLinkedIn()
                    self.tableView.reloadData()
                    
                }else if value == .LINKED_IN_ADD {
                    self.view.endEditing(true)
                    let prof = LinkedInProfile.init()
                    prof.isFromLinkedIn = false
                    self.profileModel.linkedInArray.append(prof)
                    self.tableView.reloadData()
                }else if value == .UPLOAD_IMAGE_LICENCE {
                    self.pickImageView(nil, { (img) in
                        
//                        if let objjjj = img as? UIImage {
                            self.showImageCroppingScreen(img)
//                        }
                        
                        
                        
                       
                    })
                }
                
                
                
                
            }
        }
        
        return cell
    }
    func showImageCroppingScreen (_ image : UIImage?){
        
//        let viewCnt = self.storyboard?.instantiateViewController(withIdentifier: "CropImageViewController") as? CropImageViewController
//        viewCnt?.callBack = { (finish , obj) in
        
            if let imggg = image , let userId = UserDefault.getUserId()  {
                self.profileModel.tempImg = imggg
                RequestClass.uploadSecurityLicense(userId, image: imggg, result: { (obj, err, success) in
                    if success == true {
                        self.profileModel.tempImg = nil
                        UserDefault.saveLicenceImage(obj as? String)
                        self.tableView.reloadData()
                    }else{
                        
                    }
                })
            }
            
            
//            self.profileModel.tempImg = image as? UIImage
            self.tableView.reloadData()
//        }
//        viewCnt?.image = image
//        self.navigationController?.pushViewController((viewCnt)!, animated: true)
//        
    
        
    }
    func fillWithFaceBook(){
        FacebookModel.getDataFromFB(self, completed: { (data) in
            self.profileModel.facebookProfile.fillWithFacebook(data)
            self.profileModel.isFacebookActivated = true
            self.tableView.reloadData()
        })
        
    }
    //MARK: override methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verifySMS" {
            let viewCnt = segue.destination as? VerifyMobileCodeViewController
            viewCnt?.mobileNumberStr = ((sender as? String) != nil) ? sender as? String : ""
            viewCnt?.callBackDismis = { (done , obj) in
                if done {
                    _ = self.navigationController?.popViewController(animated: true)
                }
                
            }
//            viewCnt?.showAlert = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

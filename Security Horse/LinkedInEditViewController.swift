//
//  LinkedInEditViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 29/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class LinkedInEditViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    var profileModel = Profile.init()
    
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
        
//        let nib2 = UINib(nibName: "ProfileEditTwitterTableViewCell", bundle: nil)
//        tableView.register(nib2, forCellReuseIdentifier: "linkedInEdit")
        
        let nib2 = UINib(nibName: "ProfileEditTwitter1TableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "linkedInEdit1")
        let nib3 = UINib(nibName: "ProfileEditTwitter2TableViewCell", bundle: nil)
        tableView.register(nib3, forCellReuseIdentifier: "linkedInEditx")
        let nib4 = UINib(nibName: "ProfileEditTwitter3TableViewCell", bundle: nil)
        tableView.register(nib4, forCellReuseIdentifier: "linkedInEdit0")
        
        // Do any additional setup after loading the view.
    }
    override func backButtonTapped(_ sender: UIButton?) {
        if sender?.tag == 1 {
            super.backButtonTapped(sender)
            return
        }
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - UiTableView methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 1 {
            return profileModel.linkedInArray.count
        }
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var identifier = "linkedInEdit"
//        if indexPath.section == 0 {
//            identifier = "facebookEdit"
//        }else
            if indexPath.section == 0 {
            identifier = "linkedInEdit0"
            
        }else if indexPath.section == 1 {
            identifier = "linkedInEdit1"
            
        }
//            else if indexPath.section == 4 {
//            identifier = "linkedInEdit4"
//            
//        }
        else {
            identifier = "linkedInEditx"
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! BaseMyProfileTableViewCell
        cell.selectionStyle = .none
        
        if indexPath.section == 1{
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
                }
//                else
//                    if value == .FB_TAPPED {
//                    //                if UserDefault.getUserEmailId() == nil {
//                    //                    self.performSegue(withIdentifier: "signIn", sender: nil)
//                    //                }else{
//                    self.fillWithFaceBook()
//                    
//                    //                }
//                }
                    else if value == .CONNECT_LINKEDIN {
                    
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
                }
//                else if value == .UPLOAD_IMAGE_LICENCE {
//                    self.pickImageView(nil, { (img) in
//                        
//                        self.showImageCroppingScreen(img)
//                        
//                        
//                        
//                    })
//                }
                
                
                
                
            }
        }
        
        return cell
    }
    @IBAction func doneBttnTapped (_ sender : UIButton){
        self.view.endEditing(true)
        self.showHudWithMessage("")
        RequestClass.editProfile(userId: UserDefault.getUserId()!, jobprofile: profileModel) { (an, ee, vv) in
            self.hideHud()
            if vv {
//                self.performSegue(withIdentifier: "mobileNumberVerify", sender: nil)
            }
        }
    }

    @IBAction func finishBttnTapped (_ sender : UIButton) {
        self.view.endEditing(true)
        self.performSegue(withIdentifier: "mobileNumberVerify", sender: nil)
        
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

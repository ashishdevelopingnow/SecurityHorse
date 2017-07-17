//
//  MyProfileViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 19/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class MyProfileViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
//    @IBOutlet weak var editProfileView: UIView!
   
    @IBOutlet weak var bttnEdit : UIButton!
    @IBOutlet weak var bgEmptyView : UIView!
    
    let profileDetail = Profile.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        updateProfile()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateProfile () {
        let userExist = UserDefault.getUserEmailId() != nil ? true : false
        bgEmptyView.isHidden = userExist
        let title = userExist ? "EDIT" : "SIGN UP"
        bttnEdit.setTitle(title, for: .normal)
        
//        let userInfo = UserDefault.getUserInfo()
//        let fbActive = profileDetail.fillWithProfile(userInfo)
        profileDetail.initWithLinkedIn(true)
        let fbActive = profileDetail.fillWithProfile((UserDefault.getUserInfo()), isLinkedIn: true)
        profileDetail.isFacebookActivated = fbActive
//        if (userExist == true)  {
            tableView.reloadData()
//        }
    }

    // MARK: - IBAction
    
    @IBAction func statusTapped (_ sender : UIButton){
        performSegue(withIdentifier: "status", sender: nil)
    }
    @IBAction func doneTapped (_ sender : UIButton){
        if sender.title(for: .normal) == "EDIT"{
            
            performSegue(withIdentifier: "editProfile", sender: nil)
        }else{
            performSegue(withIdentifier: "signUp", sender: nil)
        }
        
        
//        sender.setTitle(editProfileView.isHidden ? "EDIT" : "DONE", for: .normal)
    }
    @IBAction func signUpTapped (_ sender : UIButton) {
        performSegue(withIdentifier: "signUp", sender: nil)
    }

    //Mark UITableView delegate datasourse
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return section == 0 ? 1 : profileDetail.linkedInArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var identifier = "myProfileJobs"
        if indexPath.section == 0 {
            identifier = "myProfileDetail"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! BaseMyProfileTableViewCell
        cell.selectionStyle = .none
//        let data = ratingTableData[indexPath.row]
        if indexPath.section == 0 {
            cell.setData(object: profileDetail) { (value) in
//                if value == .UPLOAD_PHOTO {
//                    self.pickImageView({ (image) in
//                        
//                    })
//                }
            }
        }else{
            let data = profileDetail.linkedInArray[indexPath.row]
            cell.setData(object: data) { (value) in
//                if value == .UPLOAD_PHOTO {
//                    self.pickImageView({ (image) in
//                        
//                    })
//                }
            }
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUp" {
            let viewCnt = segue.destination as? BaseSignInNavigationViewController
            viewCnt?.callBack = { (comp,object) in
                if comp {
                    self.updateProfile()
                }
            }
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

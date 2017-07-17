//
//  ApplyJobSignInViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 02/05/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class ApplyJobSignInViewController: SignInViewController {
    @IBOutlet weak var verticalConstrain: NSLayoutConstraint!

    @IBOutlet weak var lblTitle : UILabel!
    
    @IBOutlet weak var emailImageView : UIImageView!
    @IBOutlet weak var txtPhoneNumber : UITextField?
    @IBOutlet weak var txtFullName : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUI()
        
        
    }
    func setUI (){
        
        let emilatxt = UserDefault.getUserEmailId()
        textFeild1?.text = emilatxt
        
        let hideEmail = !Utils.check(forEmpty : emilatxt)
        textFeild1?.isHidden = hideEmail
        emailImageView?.isHidden = hideEmail
        
        verticalConstrain.constant = !hideEmail ? 104 : 45
        self.view.layoutIfNeeded()
        
        if hideEmail == true{
            bttnCreateAccount.setTitle("Complete Profile", for: .normal)
        }
        lblTitle.text = hideEmail == false ? "Create an account to apply" : "Complete your profile below to apply!"
        
        
        let profileModel =  Profile.init()
        profileModel.initWithLinkedIn(false)
        let fbActive = profileModel.fillWithProfile((UserDefault.getUserInfo()), isLinkedIn: false)
        profileModel.isFacebookActivated = fbActive
        
        txtPhoneNumber?.text = profileModel.facebookProfile.phoneNumber
        txtFullName?.text = profileModel.facebookProfile.fullName
        
        createAccountUI()
    }
    @IBAction override func signUpTapped(_ sender : UIButton){
        super.signUpTapped(sender)
    }
    
    override func applyForJob(_ jobId: String) {
        
        if validation() == false {
            return
        }
        
        self.showHudWithMessage("")
        
        
        let phoneNo = UtilsSwift.changeToPhoneNumberFormat(string: txtPhoneNumber?.text ?? "")
        if let jobId = (self.navigationController as? BaseSignInNavigationViewController)?.jobId {
            RequestClass.applyForJob(jobid: jobId, userID: UserDefault.getUserId(), email: textFeild1?.text, fullName: txtFullName?.text, phoneNumber: phoneNo, viewController: self, result: { (response, error, success) -> () in
                            self.hideHud()
                            if success {
                                (self.navigationController as? BaseSignInNavigationViewController)?.callBack?(true,nil)
                                self.backButtonTapped(nil)
                
                            }else if let rr = response as? String , rr == "1"{
                                self.performSegue(withIdentifier: "signIn", sender: self.textFeild1?.text)
                            }
                            
                
            })
        }
        
    }
    
    func validation () -> Bool{
        if Utils.check(forEmpty: txtFullName?.text) {
            UtilsSwift.showAlertWithMessage(Constants.ALERT_FULL_NAME, Constants.TITLE_ALERT)
            return false
            
        }else if Utils.check(forEmpty: txtPhoneNumber?.text) {
            UtilsSwift.showAlertWithMessage(Constants.ALER_PHONENUMBER, Constants.TITLE_ALERT)
            return false
            
        }
        return true
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

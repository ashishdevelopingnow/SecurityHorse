//
//  VerifyMobileNumberViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 30/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class VerifyMobileNumberViewController: BaseViewController {

    @IBOutlet weak var mobileNumber : UITextField!
    
    @IBOutlet weak var bttnSendCode : UIButton!
//    var profileModel = Profile.init()
    @IBOutlet weak var lblTitle : UILabel!
    
    @IBOutlet weak var imageViewCheck : UIImageView!
    
//    @IBOutlet weak var sendCodeBttn : UIButton!
    @IBOutlet weak var nextBttn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        let mobileNo =  UserDefault.getVerifiedPhoneNo()
        
        if UserDefault.isMobileNumberVerified() == true , let mb = mobileNo {
            let mmm = UtilsSwift.changeToPhoneFormat(string: mb)
            lblTitle.text = "Your number \(mmm) is already verified.  To update your mobile number, change it below and tap “SEND CODE”"
            imageViewCheck.isHidden = false
            
            
            
            
        }else{
            lblTitle.text = "Verify your mobile number to increase your chance of landing a job."
             imageViewCheck.isHidden = true
        }
        
        mobileNumber.text = mobileNo
        checkForPhoneNo()
//        self.view.layoutIfNeeded()
        setUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func backButtonTapped(_ sender: UIButton?) {
        if sender?.tag == 1 {
            super.backButtonTapped(sender)
            return
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUI()  {
        mobileNumber.isUserInteractionEnabled = false
        UtilsSwift.addInitilaText(mobileNumber, initaltext: "phone-number", initalTextColor: Constants.APP_TEXT_COLOR)
    }
    @IBAction func numberTapped (_ sender : UIButton) {
        
        
        let text = UtilsSwift.changeToPhoneNumberFormat(string:mobileNumber.text ?? "")
            if sender.tag == -1 {
                if text.characters.count > 0 {
                    let truncated = text.substring(to: text.index(before: text.endIndex))
                    mobileNumber.text = truncated
                }
                
            }else{
                if text.characters.count < 10 {
                     mobileNumber.text = text + "\(sender.tag)"
                }
               
            }
            
        
        checkForPhoneNo()
    }
    
    
    
    
    func checkForPhoneNo () {
        let text = UtilsSwift.changeToPhoneNumberFormat(string:mobileNumber.text ?? "")
            
            if UserDefault.isMobileNumberVerified() == true , let mobileNo = UserDefault.getVerifiedPhoneNo() , mobileNo == text{
                
                let color =  UIColor.init(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1)
                
                bttnSendCode.backgroundColor = color
                bttnSendCode.isEnabled = false
                
                imageViewCheck.isHidden = false
            }else{
                imageViewCheck.isHidden = true
                
                let createAc = (text.characters.count) >= 10
                let color = (createAc == false) ? UIColor.init(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1) : UIColor.init(red: 249/255.0, green: 137/255.0, blue: 24/255.0, alpha: 1)
                bttnSendCode.backgroundColor = color
                bttnSendCode.isEnabled = createAc
            }
            
            
        
        
    }
    
    @IBAction func nextTapped (_ sender : UIButton) {
        self.performSegue(withIdentifier: "verifyCode1", sender: nil)
    }
    
    @IBAction func verifyCode (_ sender : UIButton) {
        if let userID = UserDefault.getUserId(){
//            self.showHudWithMessage("")
            let text = UtilsSwift.changeToPhoneNumberFormat(string:mobileNumber.text ?? "")
            RequestClass.saveMobileNumber(text, user_id: userID, result: { (obc, err, done) in
                self.hideHud()
//                if done {
                
//                }
            })
            self.performSegue(withIdentifier: "verifyCode", sender: nil)
        }
        
        
//
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "verifyCode" {
            let viewCnt = segue.destination as? VerifyMobileCodeViewController
            viewCnt?.mobileNumberStr = UtilsSwift.changeToPhoneNumberFormat(string:mobileNumber.text ?? "")
        }
        
        
    }

}

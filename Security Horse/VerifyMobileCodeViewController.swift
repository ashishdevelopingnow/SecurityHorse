//
//  VerifyMobileCodeViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 02/02/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class VerifyMobileCodeViewController: BaseViewController {

     @IBOutlet weak var mobileNumber : UITextField!
    
    @IBOutlet weak var bttnFinish : UIButton!
    @IBOutlet weak var lblTitle : UILabel!
    
    var mobileNumberStr : String?
    var callBackDismis : CallBack?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI() {
        
        let mobNo = UtilsSwift.changeToPhoneFormat(string: mobileNumberStr ?? "")
        
        mobileNumber.isUserInteractionEnabled = false
        UtilsSwift.addInitilaText(mobileNumber, initaltext: "6-digit code", initalTextColor: Constants.APP_TEXT_COLOR)
        
        lblTitle.text = "Enter the 6-digit code sent to your mobile number \(mobNo) below"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func backButtonTapped(_ sender: UIButton?) {
        if self.navigationController != nil {
            super.backButtonTapped(sender)
        }else{
            self.dismiss(animated: true, completion: {
                self.callBackDismis?(true,nil)
            })
        }
    }
    
    @IBAction func numberTapped (_ sender : UIButton) {
        
        
        if let text = mobileNumber.text {
            if sender.tag == -1 {
                if text.characters.count > 0 {
                    let truncated = text.substring(to: text.index(before: text.endIndex))
                    mobileNumber.text = truncated
                }
                
            }else if text.characters.count < 6{
                mobileNumber.text = text + "\(sender.tag)"
            }
            
        }
        checkForPhoneNo()
    }
    func checkForPhoneNo () {
        if let text = mobileNumber.text {
            let createAc = (text.characters.count) >= 6
            let color = (createAc == false) ? UIColor.init(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1) : UIColor.init(red: 249/255.0, green: 137/255.0, blue: 24/255.0, alpha: 1)
            bttnFinish .setTitleColor(color, for: .normal)
            bttnFinish.isEnabled = createAc
        }
        
    }
    
    @IBAction func finishTapped (_ sender : UIButton) {
        
//        self.performSegue(withIdentifier: "submit", sender: nil)
        if  let userID = UserDefault.getUserId(),let txt = mobileNumber.text{
            self.showHudWithMessage("")
            RequestClass.sendOTP(txt,user_id:userID,  result: { (obj, err, cmp) in
                self.hideHud()
                if cmp {
                    UserDefault.saveVerifiedMobileNumber(self.mobileNumberStr)
                    UserDefault.saveMobileNumberVerified(true)
                    
                    if self.navigationController != nil {
                        self.performSegue(withIdentifier: "submit", sender: nil)
                    }else{
                        self.backButtonTapped(nil)
                    }
                    
                }
            })
        }
    }
    
    @IBAction func resendCodeTapped (_ sender : UIButton) {
        
        
        if  let userID = UserDefault.getUserId(){
            sender.isEnabled = false
            RequestClass.resendOTP(userID, result: { (obj, err, cmp) in
            sender.isEnabled = true
            })
        }
    }


}

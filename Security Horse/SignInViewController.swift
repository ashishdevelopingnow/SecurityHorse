//
//  SignInViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 17/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {

    @IBOutlet weak var bttnCreateAccount: UIButton!
//    var applyJob : Bool = false
//    var callBack : CallBack?
//    var showAlert : Bool = true
    @IBOutlet weak var textFeild1 : UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFeild1?.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: UIControlEvents.editingChanged)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func backButtonTapped(_ sender: UIButton?) {
        self.dismiss(animated: true) { 
            
        }
    }
    
    @IBAction func signUpTapped(_ sender : UIButton){
        //        self.performSegueWithIdentifier("signIn", sender: nil)
        //        return
        guard Utils.check(forEmpty: textFeild1?.text) == false else{
             UtilsSwift.showAlertWithMessage(Constants.VALID_EMAIL_ID, Constants.TITLE_ALERT)
//            Utils.showAlert(withMessage: Constants.VALID_EMAIL_ID, andTitle: Constants.TITLE_ALERT)
            return
        }
        self.view.endEditing(true)
        if let text = textFeild1?.text {
            if let jobId = (self.navigationController as? BaseSignInNavigationViewController)?.jobId {
                
                self.applyForJob(jobId)
                
                
                
                
            }else{
                self.showHudWithMessage("")
                RequestSignUp.signUpWith(text, viewController : self,result: { (response, error, success) -> () in
                    self.hideHud()
                    if success {
                        (self.navigationController as? BaseSignInNavigationViewController)?.callBack?(true,nil)
                        self.backButtonTapped(nil)
                    }else {
                        if let rr = response as? String , rr == "1"{
                            self.performSegue(withIdentifier: "signIn", sender: self.textFeild1?.text)
                        }
                    }
                    
                })
            }
        }
        
    }
    func applyForJob(_ jobId : String) {
//        self.showHudWithMessage("")
//        RequestClass.applyForJob(jobid: jobId, userID: nil, email: textFeild1?.text, password: nil, viewController: self, result: { (response, error, success) -> () in
//            self.hideHud()
//            if success {
//                (self.navigationController as? BaseSignInNavigationViewController)?.callBack?(true,nil)
//                self.backButtonTapped(nil)
//                
//            }else if let rr = response as? String , rr == "1"{
//                self.performSegue(withIdentifier: "signIn", sender: self.textFeild1?.text)
//            }
//            
//        })
    }
    func createAccountUI(){
        let createAc = Utils.validateEmail(textFeild1?.text)
        let color = (createAc == false) ? UIColor.init(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1) : UIColor.init(red: 249/255.0, green: 137/255.0, blue: 24/255.0, alpha: 1)
        bttnCreateAccount.backgroundColor = color
    }
    // MARK: - UITextFeilddelegate
    func textfieldDidChanged(_ sender : UITextField) {
        print("writen text is ::::::::  \(sender.text)")
        self.createAccountUI()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "signIn"{
            let viewCont = segue.destination as? SignInMainViewController
            viewCont?.emailId = sender as? String
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

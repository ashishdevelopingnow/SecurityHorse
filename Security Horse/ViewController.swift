//
//  ViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 23/12/16.
//  Copyright © 2016 Kuldeep Butola. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

//    var emailId : String?
    @IBOutlet weak var launchView : UIView?
    @IBOutlet weak var textFeild1 : UITextField?
//    @IBOutlet weak var textFeild2 : UITextField?
//    @IBOutlet weak var imageViewText1 : UIImageView?
//    @IBOutlet weak var imageViewText2 : UIImageView?
//    @IBOutlet weak var bttnFindJob : UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchView?.isHidden = false
//        textFeild1?.text = emailId
        
        self.view.layoutIfNeeded()
        
        
//        UtilsSwift.addBorderTextFeild(textFeild1!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefault.getUserEmailId() != nil && launchView != nil{
            launchView?.isHidden = false
            performSegue(withIdentifier: "showJobs", sender: nil)
        }else{
            launchView?.isHidden = true
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signOutTapped(_ segue : UIStoryboardSegue){
        
    }

    func requestForgetPassword(_ text : String){
        RequestSignUp.forgotPassword(text) { (abc, err, finish) in
            
        }
    }
    //MARK: IBAction
    @IBAction func forgotPasswordTapped(_ sender : UIButton){
        
        
        
        let alert = UIAlertController(title: "Forgot Password", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textFeild) -> Void in
            print("abc")
            textFeild.placeholder = "Enter your email"
            
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:nil))
        
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ (ACTION :UIAlertAction!)in
            //            println("User click Ok button")
            let txtFld = alert.textFields?.first
            guard let name = txtFld?.text else{
                return
            }
            if !Utils.check(forEmpty: name){
                self.requestForgetPassword(name)
            }else{
                 UtilsSwift.showAlertWithMessage(Constants.VALID_EMAIL_ID, Constants.TITLE_ALERT)
//                Utils.showAlert(withMessage: Constants.VALID_EMAIL_ID, andTitle: Constants.TITLE_ALERT)
            }
            
        }))
        

        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func signUpTapped(_ sender : UIButton){
//        self.performSegueWithIdentifier("signIn", sender: nil)
//        return
        guard Utils.check(forEmpty: textFeild1?.text) == false else{
             UtilsSwift.showAlertWithMessage(Constants.VALID_EMAIL_ID, Constants.TITLE_ALERT)
//            Utils.showAlert(withMessage: Constants.VALID_EMAIL_ID, andTitle: Constants.TITLE_ALERT)
            return
        }
        if let text = textFeild1?.text {
            
            self.showHudWithMessage("")
            RequestSignUp.signUpWith(text, viewController : self,result: { (response, error, success) -> () in
                self.hideHud()
                if success {
                    self.performSegue(withIdentifier: "showJobs", sender: self.textFeild1?.text)
                }else {
                    if let rr = response as? String , rr == "1"{
                        self.performSegue(withIdentifier: "signIn", sender: self.textFeild1?.text)
                    }
                }

            })
            
            
        }
        
    }
//    @IBAction func findWorkTapped(_ sender : UIButton){
//        guard Utils.check(forEmpty: textFeild1?.text) == false else{
//            Utils.showAlert(withMessage: "Please enter email")
//            return
//        }
//        guard Utils.check(forEmpty: textFeild2?.text) == false else{
//            Utils.showAlert(withMessage: "Please enter password")
//            return
//        }
//        
//        
//        if let text = textFeild1?.text , let password = textFeild2?.text{
//            self.showHudWithMessage("")
//            RequestSignUp.signInWith(text, password: password, result: { (response, error, success) -> () in
//                self.hideHud()
//                if success {
//                    self.performSegue(withIdentifier: "showJobs", sender: nil)
//                }
//            })
//        }
//    }
    
    
    @IBAction func postJobTapped(_ sender : UIButton){
        if let url = URL(string: "https://www.securityhorse.com/post-a-job"){
            UIApplication.shared.openURL(url)
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "signIn"{
            let viewCont = segue.destination as? SignInMainViewController
            viewCont?.emailId = sender as? String
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}


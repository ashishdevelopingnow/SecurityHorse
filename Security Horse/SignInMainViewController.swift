//
//  SignInMainViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 28/02/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class SignInMainViewController: BaseViewController {

    var emailId : String?
//    @IBOutlet weak var launchView : UIView?
    @IBOutlet weak var textFeild1 : UITextField?
    @IBOutlet weak var textFeild2 : UITextField?
    //    @IBOutlet weak var imageViewText1 : UIImageView?
    //    @IBOutlet weak var imageViewText2 : UIImageView?
    //    @IBOutlet weak var bttnFindJob : UIButton?
    @IBOutlet weak var crossBttn : UIButton?
    @IBOutlet weak var skipBttn : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        launchView?.isHidden = false
        
        
        textFeild1?.text = emailId
        if ((self.navigationController as? BaseSignInNavigationViewController) != nil) {
            crossBttn?.isHidden = false
            skipBttn?.isHidden = true
        }else{
            crossBttn?.isHidden = true
            skipBttn?.isHidden = false
        }
        self.view.layoutIfNeeded()
        
        
        //        UtilsSwift.addBorderTextFeild(textFeild1!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func requestForgetPassword(_ text : String){
//        self.showHudWithMessage("")
        RequestSignUp.forgotPassword(text) { (abc, err, finish) in
//            self.hideHud()
        }
    }
    //MARK: Methods
    func dismisView () {
        self.dismiss(animated: true) {
            
        }
    }
    //MARK: IBAction
    @IBAction func crossBttnTapped(_ sender : UIButton){
        self.dismisView()
    }
    @IBAction func forgotPasswordTapped(_ sender : UIButton){
        
        
        
        let alert = UIAlertController(title: "Forgot Password", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textFeild) -> Void in
            print("abc")
            textFeild.placeholder = "Enter your email address"
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
//                 Utils.showAlert(withMessage: , andTitle: )
            }
            
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
   
    @IBAction func findWorkTapped(_ sender : UIButton){
        guard Utils.check(forEmpty: textFeild1?.text) == false else{
            UtilsSwift.showAlertWithMessage(Constants.VALID_EMAIL_ID, Constants.TITLE_ALERT)
//            Utils.showAlert(withMessage: Constants.VALID_EMAIL_ID, andTitle: Constants.TITLE_ALERT)
            return
        }
        guard Utils.check(forEmpty: textFeild2?.text) == false else{
            UtilsSwift.showAlertWithMessage(Constants.VALID_PASSWORD, Constants.TITLE_ALERT)
//            Utils.showAlert(withMessage: Constants.VALID_PASSWORD, andTitle: Constants.TITLE_ALERT)
            return
        }
        self.view.endEditing(true)
        
        if let text = textFeild1?.text , let password = textFeild2?.text{
//            if let jobId = (self.navigationController as? BaseSignInNavigationViewController)?.jobId {
//                
//                self.showHudWithMessage("")
//                RequestClass.applyForJob(jobid: jobId, userID: nil, email: text, password: password, viewController: self, result: { (response, error, success) -> () in
//                    self.hideHud()
//                    if success {
//                        (self.navigationController as? BaseSignInNavigationViewController)?.callBack?(true,nil)
//                        self.dismisView()
//                        
//                    }
////                    else if let rr = response as? String , rr == "1"{
////                        self.performSegue(withIdentifier: "signIn", sender: self.textFeild1?.text)
////                    }
//                    
//                })
//                
//                
//                
//                
//            }else{
                self.showHudWithMessage("")
                RequestSignUp.signInWith(text, password: password, result: { (response, error, success) -> () in
                    self.hideHud()
                    if success {
                        if (self.navigationController as? BaseSignInNavigationViewController)?.jobId != nil{
                            _ = self.navigationController?.popViewController(animated: true)
                        }else
                        
                        if let viewCnt = (self.navigationController as? BaseSignInNavigationViewController) {
                            viewCnt.callBack?(true,nil)
                            self.dismisView()

                        }else{
                            self.performSegue(withIdentifier: "showJobs", sender: nil)
                        }
                        
                    }
                })
//            }
            
            
        }
    }
    
    
    @IBAction func postJobTapped(_ sender : UIButton){
        if let url = URL(string: "https://www.securityhorse.com/post-a-job"){
            UIApplication.shared.openURL(url)
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "signIn"{
//            let viewCont = segue.destination as? ViewController
//            viewCont?.emailId = sender as? String
//        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

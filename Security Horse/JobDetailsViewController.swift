//
//  JobDetailsViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 25/12/16.
//  Copyright © 2016 Kuldeep Butola. All rights reserved.
//

import UIKit

class JobDetailsViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var jobDetailsTableView : UITableView?
    
    @IBOutlet weak var bgView : UIView?
    @IBOutlet weak var logoImageView : UIImageView?
    @IBOutlet weak var checkImageView : UIImageView?
    
    @IBOutlet weak var jobApplyBttn : UIButton?
    @IBOutlet weak var jobAppliedBttn : UIButton?
    
    @IBOutlet weak var jobDescription: UILabel!
    @IBOutlet weak var jobTime: UILabel!
    @IBOutlet weak var jobSubTitle: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jabNature : UILabel!
    
    @IBOutlet weak var jobDecWebView : UIWebView!
    var jobsArray : JobsArray?
    
    var refreshView : (()-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
//        requestForDetails()
//        jobDetailsTableView.delegate = self
//        jobDetailsTableView.dataSource = self
//        jobDetailsTableView.rowHeight = UITableViewAutomaticDimension
//        jobDetailsTableView.estimatedRowHeight = 44.0
        // Do any additional setup after loading the view.
    }
    func setUI()  {
        showAppliedJob()
        
        
        bgView?.backgroundColor = UIColor.white
        bgView?.layer.shadowOpacity = 0.7
        bgView?.layer.shadowOffset = CGSize.zero
        bgView?.layer.shadowRadius = 5.0
        bgView?.layer.shadowColor = UIColor.gray.cgColor
        
        logoImageView?.layer.cornerRadius = 50.0
        logoImageView?.layer.borderColor = UIColor(colorLiteralRed: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1).cgColor
        logoImageView?.layer.borderWidth = 0.5
        logoImageView?.layer.masksToBounds = true
        
        
        jobTitle.text = ""
        jobDescription.text = ""
//        jobTime.text = "3 days"
        jobSubTitle.text = ""
        

        jobDecWebView.backgroundColor = UIColor.clear
        jobDecWebView.isOpaque = false
        
        
        let format = "yyyy-MM-dd HH:mm:ss"
        if  let dateStr1 = jobsArray?.jobDescription?.created_date_time ,let date1 = Utils.date(fromStringFormat: format, dateString: dateStr1 )  {
            jobTime.text = UtilsSwift.remainingDateLeft(date: date1)
        }else{
            jobTime.text = ""
        }
        
        let placeHolder = UIImage.init(named: "logoSmall")
        logoImageView?.contentMode = .center
        
        if let imageStr = jobsArray?.companyDetails?.companyImage, let imageURL = NSURL.init(string: imageStr) as? URL{
            
            logoImageView?.af_setImage(withURL: imageURL, placeholderImage: placeHolder, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: true, completion: nil)
            //            bttnUplaodPhoto.af_setImage(for: .normal, url: imageURL as URL, placeholderImage: UIImage(named: "uploadPhoto")!, filter: nil, progress: nil, progressQueue: DispatchQueue.main, completion: nil)
        }else{
            logoImageView?.image = placeHolder
        }
        
        if let title = jobsArray?.jobDescription?.job_title{
            jobTitle.text = title
        }
        if let dec = jobsArray?.companyDetails?.company_name{
            jobSubTitle.text = dec
        }
        if let cc = jobsArray?.jobDescription?.job_description{
            jobDescription.text = ""
            jobDecWebView.loadHTMLString(cc, baseURL: nil)
        }
        if let cc = jobsArray?.jobDetails?.job_type, let dd = jobsArray?.jobDetails?.hourly_rate{
            let rateEmpty = Utils.check(forEmpty: cc)
            let durationEmpty = Utils.check(forEmpty: dd)
            if  rateEmpty && durationEmpty{
                jabNature.text = ""
            }else if rateEmpty && !durationEmpty{
                jabNature.text = "$\(dd)"
            }else if !rateEmpty && durationEmpty{
                jabNature.text = "\(cc)"
            }else{
               jabNature.text = "$\(dd) | \(cc)" 
            }
//
        }else{
            jabNature.text = "Rate | Part-Time"
        }

        
        
    }
    
    func showAppliedJob () {
         let show = (jobsArray?.jobDescription?.applied == "1" ? true : false)
            jobApplyBttn?.isHidden = show
            jobAppliedBttn?.isHidden = !show
        checkImageView?.isHidden = !show
        
    }
    func requestForDetails()  {
        if let jobId = jobsArray?.jobDescription?.id{
            RequestClass.getJobDetails(jobId) { (obj, err, comp) in
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: override methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUp" {
            let viewCnt = segue.destination as? BaseSignInNavigationViewController
            viewCnt?.callBack = { (comp,object) in
                if comp {
//                    self.applyForTheJob()
                    self.jobsArray?.jobDescription?.applied = "1"
                    self.refreshView?()
                    self.showAppliedJob()
                }
            }
            viewCnt?.jobId = jobsArray?.jobDescription?.id
        }
    }
    //MARK: IBACtion
    @IBAction func applyJobTapped(_ sender : UIButton){
        if UserDefault.getUserEmailId() == nil {
            performSegue(withIdentifier: "signUp", sender: nil)
        }else{
            let profileModel =  Profile.init()
            profileModel.initWithLinkedIn(false)
            let fbActive = profileModel.fillWithProfile((UserDefault.getUserInfo()), isLinkedIn: false)
            profileModel.isFacebookActivated = fbActive
            
            if !Utils.check(forEmpty: profileModel.facebookProfile.fullName) , !Utils.check(forEmpty: profileModel.facebookProfile.phoneNumber) {
                 applyForTheJob(profileModel)
            }else{
                performSegue(withIdentifier: "signUp", sender: nil)
            }
           
            
        }
        
    }
    //MARK: requestMethods
    
    func applyForTheJob(_ profileModel : Profile) -> Void {
        if let jobID = jobsArray?.jobDescription?.id , let userId = UserDefault.getUserId(){
            self.showHudWithMessage("")
            
            RequestClass.applyForJob(jobid: jobID, userID: userId, email: profileModel.facebookProfile.email, fullName: profileModel.facebookProfile.fullName, phoneNumber: profileModel.facebookProfile.phoneNumber, viewController: self, result: { (objwct, err, completed) in
                self.hideHud()
                if completed {
                    
                    self.jobsArray?.jobDescription?.applied = "1"
                    self.refreshView?()
                    self.showAppliedJob()
                }
            })
            
            
        }
    }
    
    //MARK: UITableView delegate datasourse
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
            return 1
        }else if section == 1 {
            return 2
        }else if section == 2 {
            return 2
        }else if section == 3 {
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var identifier = "Cell"
        if indexPath.section == 0 {
            identifier = "JobLogoTableViewCell"
        }else{
            if indexPath.section <= 3 {
                if indexPath.row == 1{
                    identifier = "JobDetailsTableViewCell"
                }else{
                    identifier = "JobTitleTableViewCell"
                }
                
            }else{
                identifier = "JobApplyTableViewCell"
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! JobDetailsTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegueWithIdentifier("JobDetail", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

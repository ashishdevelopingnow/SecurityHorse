//
//  JobTableViewCell.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 25/12/16.
//  Copyright © 2016 Kuldeep Butola. All rights reserved.
//

import UIKit
import Alamofire

class JobTableViewCell: UITableViewCell {

    @IBOutlet weak var companyAppliedImageView: UIImageView!
    @IBOutlet weak var lblViewed: UILabel!
    @IBOutlet weak var jobDescription: UILabel!
    @IBOutlet weak var jobTime: UILabel!
    @IBOutlet weak var jobSubTitle: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobLogo: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setdata(jobs : JobsArray)  {
        jobTitle.text = ""
        jobDescription.text = ""
//        jobTime.text = "3 days ago"
        jobSubTitle.text = ""
        
        let format = "yyyy-MM-dd HH:mm:ss"
        if  let dateStr1 = jobs.jobDescription?.created_date_time ,let date1 = Utils.date(fromStringFormat: format, dateString: dateStr1 )  {
            jobTime.text = UtilsSwift.remainingDateLeft(date: date1)
        }else{
            jobTime.text = ""
        }
//        jobLogo.af_set
//        if let imageURL = jobs
        companyAppliedImageView.isHidden = true
//        248 125
//        lblViewed.textColor = UIColor.init(colorLiteralRed: 0/255.0, green: 122/255.0, blue: 226/255.0, alpha: 1)
        lblViewed.textColor = UIColor.init(colorLiteralRed: 248/255.0, green: 125/255.0, blue: 0, alpha: 1)
        
        if let appplied = jobs.jobDescription?.applied , appplied == "1"{
            lblViewed.text = "APPLIED"
//            lblViewed.textColor = UIColor.init(colorLiteralRed: 248/255.0, green: 125/255.0, blue: 0, alpha: 1)
            companyAppliedImageView.isHidden = false
        }else if let viewed = jobs.jobDescription?.viewed , viewed == "1" {
            lblViewed.text = "VIEWED"
        }else{
            lblViewed.text = ""
        }
        
        if let title = jobs.jobDescription?.job_title{
            jobTitle.text = title
        }
        if let dec = jobs.companyDetails?.company_name{
            jobSubTitle.text = dec
        }
        
//        jobLogo.clipsToBounds = true
        jobLogo.layer.cornerRadius = 76 / 2.0
        jobLogo.layer.masksToBounds = true
        jobLogo.contentMode = .scaleToFill
        
//        let placeHolder = UIImage(named: "logoSmall")
        let placeHolder = UIImage(named: "companyLogo2")
//         let placeHolder = UIImage(named: "uploadPhoto")
        if let imageStr = jobs.companyDetails?.companyImage, let imageURL = NSURL.init(string: imageStr) as? URL{
            
            
            
            jobLogo.af_setImage(withURL: imageURL, placeholderImage: placeHolder, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: true, completion:{ (ii) in
                self.jobLogo.contentMode = .scaleToFill
                self.jobLogo.layer.cornerRadius = 76 / 2.0
                self.jobLogo.layer.masksToBounds = true
                
            })
//            bttnUplaodPhoto.af_setImage(for: .normal, url: imageURL as URL, placeholderImage: UIImage(named: "uploadPhoto")!, filter: nil, progress: nil, progressQueue: DispatchQueue.main, completion: nil)
        }else{
            jobLogo.image = placeHolder
        }
        if let cc = jobs.jobDetails?.job_type, let dd = jobs.jobDetails?.hourly_rate{
            let rateEmpty = Utils.check(forEmpty: cc)
            let durationEmpty = Utils.check(forEmpty: dd)
            if  rateEmpty && durationEmpty{
                jobDescription.text = ""
            }else if rateEmpty && !durationEmpty{
                jobDescription.text = "$\(dd)"
            }else if !rateEmpty && durationEmpty{
                jobDescription.text = "\(cc)"
            }else{
                jobDescription.text = "$\(dd) | \(cc)"
            }
//            jobDescription.text = "$\(dd) | \(cc)"
        }else{
            jobDescription.text = "Rate | Part-Time"
        }
//        if let cc = jobs.jobDescription?.created_date_time{
//            jobDescription.text = "Rate | Part-Time"
//        }
    }

}
